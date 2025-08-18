import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/trade.dart';
import '../provider/add_trade_provider.dart';
import '../../../../core/utils/app_theme.dart';
import '../../../../core/widgets/multi_select_dropdown.dart';
import '../../../../core/providers/user_defined_values_provider.dart';

class AddTradePage extends StatefulWidget {
  const AddTradePage({super.key});

  @override
  State<AddTradePage> createState() => _AddTradePageState();
}

class _AddTradePageState extends State<AddTradePage> {
  @override
  void initState() {
    super.initState();
    // Initialize default values when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserDefinedValuesProvider>().initializeDefaultValues();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Trade'),
      ),
      body: Consumer2<AddTradeProvider, UserDefinedValuesProvider>(
        builder: (context, addTradeProvider, userValuesProvider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Trade Transfers Section
                _buildTradeTransfersSection(context, addTradeProvider, userValuesProvider),
                const SizedBox(height: 16),
                
                // Checklist Section
                _buildChecklistSection(addTradeProvider),
                const SizedBox(height: 16),
                
                // Trade Management Section
                _buildTradeManagementSection(addTradeProvider),
                const SizedBox(height: 16),
                
                // Trade Exit Section
                _buildTradeExitSection(context, addTradeProvider, userValuesProvider),
                const SizedBox(height: 16),
                
                // Memo Section
                _buildMemoSection(addTradeProvider),
                const SizedBox(height: 16),
                
                // Trackings Section
                _buildTrackingsSection(context, addTradeProvider, userValuesProvider),
                const SizedBox(height: 16),
                
                // Transfers Section
                _buildTransfersSection(addTradeProvider),
                const SizedBox(height: 24),
                
                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: addTradeProvider.isFormValid ? addTradeProvider.addTrade : null,
                    style: AppTheme.primaryButtonStyle.copyWith(
                      minimumSize: const WidgetStatePropertyAll(Size(0, 50)),
                    ),
                    child: _buildSubmitButtonContent(addTradeProvider),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Error Message
                if (addTradeProvider.status == AddTradeStatus.error)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.errorColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.errorColor),
                    ),
                    child: Text(
                      addTradeProvider.errorMessage,
                      style: TextStyle(color: AppTheme.errorColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                
                // Success Message
                if (addTradeProvider.status == AddTradeStatus.success)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.successColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.successColor),
                    ),
                    child: Text(
                      'Trade added successfully!',
                      style: TextStyle(color: AppTheme.successColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTradeTransfersSection(
    BuildContext context, 
    AddTradeProvider addTradeProvider, 
    UserDefinedValuesProvider userValuesProvider
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Trade Transfers', style: AppTheme.subheadingStyle),
            const SizedBox(height: 16),
            
            // Tag
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Tag',
                hintText: 'Enter trade tag',
                prefixIcon: Icons.tag,
              ),
              onChanged: addTradeProvider.updateTag,
            ),
            
            const SizedBox(height: 16),
            
            // Datetime
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Datetime',
                hintText: 'Select date and time',
                prefixIcon: Icons.schedule,
              ),
              readOnly: true,
              onTap: () => _selectDateTime(context, addTradeProvider),
              controller: TextEditingController(
                text: addTradeProvider.datetime?.toString().substring(0, 16) ?? 'Select datetime',
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Exchanges - Multi-select dropdown
            FutureBuilder<List<String>>(
              future: userValuesProvider.getValues('exchanges'),
              builder: (context, snapshot) {
                final exchanges = snapshot.data ?? [];
                return MultiSelectDropdown(
                  label: 'Exchanges',
                  prefixIcon: Icons.swap_horiz,
                  options: exchanges,
                  selectedValues: addTradeProvider.exchanges != null ? [addTradeProvider.exchanges!] : [],
                  onChanged: (values) {
                    if (values.isNotEmpty) {
                      addTradeProvider.updateExchanges(values.first);
                    } else {
                      addTradeProvider.updateExchanges(null);
                    }
                  },
                  onAddNewValue: (value) async {
                    await userValuesProvider.addValue('exchanges', value);
                    addTradeProvider.updateExchanges(value);
                  },
                  allowMultiple: false,
                  hintText: 'Select exchange',
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // Entry Type
            DropdownButtonFormField<EntryType>(
              decoration: AppTheme.inputDecoration(
                labelText: 'Entry Type',
                prefixIcon: Icons.input,
              ),
              value: addTradeProvider.entryType,
              items: EntryType.values
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(_getEntryTypeDisplayName(type)),
                      ))
                  .toList(),
              onChanged: addTradeProvider.updateEntryType,
            ),
            
            const SizedBox(height: 16),
            
            // Symbol - Multi-select dropdown
            FutureBuilder<List<String>>(
              future: userValuesProvider.getValues('symbols'),
              builder: (context, snapshot) {
                final symbols = snapshot.data ?? [];
                return MultiSelectDropdown(
                  label: 'Symbol',
                  prefixIcon: Icons.currency_exchange,
                  options: symbols,
                  selectedValues: addTradeProvider.symbol.isNotEmpty ? [addTradeProvider.symbol] : [],
                  onChanged: (values) {
                    if (values.isNotEmpty) {
                      addTradeProvider.updateSymbol(values.first);
                    } else {
                      addTradeProvider.updateSymbol('');
                    }
                  },
                  onAddNewValue: (value) async {
                    await userValuesProvider.addValue('symbols', value);
                    addTradeProvider.updateSymbol(value);
                  },
                  allowMultiple: false,
                  hintText: 'Select symbol',
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // Strategies - Multi-select dropdown
            FutureBuilder<List<String>>(
              future: userValuesProvider.getValues('strategies'),
              builder: (context, snapshot) {
                final strategies = snapshot.data ?? [];
                return MultiSelectDropdown(
                  label: 'Strategies',
                  prefixIcon: Icons.trending_up,
                  options: strategies,
                  selectedValues: addTradeProvider.strategies != null ? [addTradeProvider.strategies!] : [],
                  onChanged: (values) {
                    if (values.isNotEmpty) {
                      addTradeProvider.updateStrategies(values.first);
                    } else {
                      addTradeProvider.updateStrategies(null);
                    }
                  },
                  onAddNewValue: (value) async {
                    await userValuesProvider.addValue('strategies', value);
                    addTradeProvider.updateStrategies(value);
                  },
                  allowMultiple: false,
                  hintText: 'Select strategy',
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // Side
            DropdownButtonFormField<Side>(
              decoration: AppTheme.inputDecoration(
                labelText: 'Side',
                prefixIcon: Icons.trending_up,
              ),
              value: addTradeProvider.side,
              items: Side.values
                  .map((side) => DropdownMenuItem(
                        value: side,
                        child: Text(side.name.toUpperCase()),
                      ))
                  .toList(),
              onChanged: addTradeProvider.updateSide,
            ),
            
            const SizedBox(height: 16),
            
            // Entry Price
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Entry Price',
                hintText: '0.00',
                prefixIcon: Icons.attach_money,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final price = double.tryParse(value) ?? 0.0;
                addTradeProvider.updateEntryPrice(price);
              },
            ),
            
            const SizedBox(height: 16),
            
            // Position Margin
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Position Margin',
                hintText: '0.00',
                prefixIcon: Icons.account_balance_wallet,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final margin = double.tryParse(value);
                addTradeProvider.updatePositionMargin(margin);
              },
            ),
            
            const SizedBox(height: 16),
            
            // Leverage
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Leverage',
                hintText: '1x',
                prefixIcon: Icons.trending_up,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final leverage = double.tryParse(value);
                addTradeProvider.updateLeverage(leverage);
              },
            ),
            
            const SizedBox(height: 16),
            
            // Order Type
            DropdownButtonFormField<OrderType>(
              decoration: AppTheme.inputDecoration(
                labelText: 'Order Type',
                prefixIcon: Icons.shopping_cart,
              ),
              value: addTradeProvider.orderType,
              items: OrderType.values
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type.name.toUpperCase()),
                      ))
                  .toList(),
              onChanged: addTradeProvider.updateOrderType,
            ),
            
            const SizedBox(height: 16),
            
            // Time Frame
            DropdownButtonFormField<String>(
              decoration: AppTheme.inputDecoration(
                labelText: 'Time Frame',
                prefixIcon: Icons.timer,
              ),
              value: addTradeProvider.timeFrame,
              items: ['1m', '5m', '15m', '30m', '1h', '4h', '1d', '1w']
                  .map((timeframe) => DropdownMenuItem(
                        value: timeframe,
                        child: Text(timeframe),
                      ))
                  .toList(),
              onChanged: addTradeProvider.updateTimeFrame,
            ),
            
            const SizedBox(height: 16),
            
            // Entry Fee Rate - Multi-select dropdown
            FutureBuilder<List<String>>(
              future: userValuesProvider.getValues('entryFeeRates'),
              builder: (context, snapshot) {
                final feeRates = snapshot.data ?? [];
                return MultiSelectDropdown(
                  label: 'Entry Fee Rate',
                  prefixIcon: Icons.percent,
                  options: feeRates,
                  selectedValues: addTradeProvider.entryFeeRate != null 
                      ? [addTradeProvider.entryFeeRate.toString()] 
                      : [],
                  onChanged: (values) {
                    if (values.isNotEmpty) {
                      final rate = double.tryParse(values.first);
                      addTradeProvider.updateEntryFeeRate(rate);
                    } else {
                      addTradeProvider.updateEntryFeeRate(null);
                    }
                  },
                  onAddNewValue: (value) async {
                    await userValuesProvider.addValue('entryFeeRates', value);
                    final rate = double.tryParse(value);
                    addTradeProvider.updateEntryFeeRate(rate);
                  },
                  allowMultiple: false,
                  hintText: 'Select fee rate',
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // Entry Mental States - Multi-select dropdown
            FutureBuilder<List<String>>(
              future: userValuesProvider.getValues('entryMentalStates'),
              builder: (context, snapshot) {
                final mentalStates = snapshot.data ?? [];
                return MultiSelectDropdown(
                  label: 'Entry Mental States',
                  prefixIcon: Icons.psychology,
                  options: mentalStates,
                  selectedValues: addTradeProvider.entryMentalStates != null 
                      ? [addTradeProvider.entryMentalStates!] 
                      : [],
                  onChanged: (values) {
                    if (values.isNotEmpty) {
                      addTradeProvider.updateEntryMentalStates(values.first);
                    } else {
                      addTradeProvider.updateEntryMentalStates(null);
                    }
                  },
                  onAddNewValue: (value) async {
                    await userValuesProvider.addValue('entryMentalStates', value);
                    addTradeProvider.updateEntryMentalStates(value);
                  },
                  allowMultiple: false,
                  hintText: 'Select mental state',
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // Entry Screenshot
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Entry Screenshot Path',
                hintText: 'Path to screenshot',
                prefixIcon: Icons.photo,
              ),
              onChanged: addTradeProvider.updateEntryScreenshot,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChecklistSection(AddTradeProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Checklist', style: AppTheme.subheadingStyle),
            const SizedBox(height: 16),
            
            // Checklist items
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Checklist Items',
                hintText: 'Enter checklist items (one per line)',
                prefixIcon: Icons.checklist,
              ),
              maxLines: 5,
              onChanged: (value) {
                final items = value.split('\n').where((item) => item.trim().isNotEmpty).toList();
                provider.updateChecklist(items);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTradeManagementSection(AddTradeProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Trade Management', style: AppTheme.subheadingStyle),
            const SizedBox(height: 16),
            
            // Stop Loss Price
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Stop Loss Price',
                hintText: '0.00',
                prefixIcon: Icons.stop_circle,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final stopLoss = double.tryParse(value);
                provider.updateStopLossPrice(stopLoss);
              },
            ),
            
            const SizedBox(height: 16),
            
            // Take Profit Price
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Take Profit Price',
                hintText: '0.00',
                prefixIcon: Icons.trending_up,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final takeProfit = double.tryParse(value);
                provider.updateTakeProfitPrice(takeProfit);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTradeExitSection(
    BuildContext context, 
    AddTradeProvider addTradeProvider, 
    UserDefinedValuesProvider userValuesProvider
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Trade Exit', style: AppTheme.subheadingStyle),
            const SizedBox(height: 16),
            
            // Actual Exit Price
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Actual Exit Price',
                hintText: '0.00',
                prefixIcon: Icons.exit_to_app,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final exitPrice = double.tryParse(value);
                addTradeProvider.updateActualExitPrice(exitPrice);
              },
            ),
            
            const SizedBox(height: 16),
            
            // Margin Closed Percent
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: '% of Margin Closed',
                hintText: '100',
                prefixIcon: Icons.percent,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final percent = double.tryParse(value);
                addTradeProvider.updateMarginClosedPercent(percent);
              },
            ),
            
            const SizedBox(height: 16),
            
            // Exit Type
            DropdownButtonFormField<ExitType>(
              decoration: AppTheme.inputDecoration(
                labelText: 'Exit Type',
                prefixIcon: Icons.exit_to_app,
              ),
              value: addTradeProvider.exitType,
              items: ExitType.values
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type.name.toUpperCase()),
                      ))
                  .toList(),
              onChanged: addTradeProvider.updateExitType,
            ),
            
            const SizedBox(height: 16),
            
            // Exit Fee Rate - Multi-select dropdown
            FutureBuilder<List<String>>(
              future: userValuesProvider.getValues('exitFeeRates'),
              builder: (context, snapshot) {
                final feeRates = snapshot.data ?? [];
                return MultiSelectDropdown(
                  label: 'Exit Fee Rate',
                  prefixIcon: Icons.percent,
                  options: feeRates,
                  selectedValues: addTradeProvider.exitFeeRate != null 
                      ? [addTradeProvider.exitFeeRate.toString()] 
                      : [],
                  onChanged: (values) {
                    if (values.isNotEmpty) {
                      final rate = double.tryParse(values.first);
                      addTradeProvider.updateExitFeeRate(rate);
                    } else {
                      addTradeProvider.updateExitFeeRate(null);
                    }
                  },
                  onAddNewValue: (value) async {
                    await userValuesProvider.addValue('exitFeeRates', value);
                    final rate = double.tryParse(value);
                    addTradeProvider.updateExitFeeRate(rate);
                  },
                  allowMultiple: false,
                  hintText: 'Select fee rate',
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // Exit Datetime
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Exit Datetime',
                hintText: 'Select exit date and time',
                prefixIcon: Icons.schedule,
              ),
              readOnly: true,
              onTap: () => _selectExitDateTime(context, addTradeProvider),
              controller: TextEditingController(
                text: addTradeProvider.exitDatetime?.toString().substring(0, 16) ?? 'Select exit datetime',
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Exit Mental States - Multi-select dropdown
            FutureBuilder<List<String>>(
              future: userValuesProvider.getValues('exitMentalStates'),
              builder: (context, snapshot) {
                final mentalStates = snapshot.data ?? [];
                return MultiSelectDropdown(
                  label: 'Exit Mental States',
                  prefixIcon: Icons.psychology,
                  options: mentalStates,
                  selectedValues: addTradeProvider.exitMentalStates != null 
                      ? [addTradeProvider.exitMentalStates!] 
                      : [],
                  onChanged: (values) {
                    if (values.isNotEmpty) {
                      addTradeProvider.updateExitMentalStates(values.first);
                    } else {
                      addTradeProvider.updateExitMentalStates(null);
                    }
                  },
                  onAddNewValue: (value) async {
                    await userValuesProvider.addValue('exitMentalStates', value);
                    addTradeProvider.updateExitMentalStates(value);
                  },
                  allowMultiple: false,
                  hintText: 'Select mental state',
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // Exit Screenshot
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Exit Screenshot Path',
                hintText: 'Path to screenshot',
                prefixIcon: Icons.photo,
              ),
              onChanged: addTradeProvider.updateExitScreenshot,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemoSection(AddTradeProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Memo', style: AppTheme.subheadingStyle),
            const SizedBox(height: 16),
            
            // Rating
            DropdownButtonFormField<int>(
              decoration: AppTheme.inputDecoration(
                labelText: 'Rating',
                prefixIcon: Icons.star,
              ),
              value: provider.rating,
              items: [1, 2, 3, 4, 5]
                  .map((rating) => DropdownMenuItem(
                        value: rating,
                        child: Row(
                          children: [
                            Text('$rating '),
                            ...List.generate(rating, (index) => const Icon(Icons.star, size: 16)),
                          ],
                        ),
                      ))
                  .toList(),
              onChanged: provider.updateRating,
            ),
            
            const SizedBox(height: 16),
            
            // Memo
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Memo',
                hintText: 'Enter trade memo...',
                prefixIcon: Icons.note,
              ),
              maxLines: 3,
              onChanged: provider.updateMemo,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingsSection(
    BuildContext context, 
    AddTradeProvider addTradeProvider, 
    UserDefinedValuesProvider userValuesProvider
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Trackings', style: AppTheme.subheadingStyle),
            const SizedBox(height: 16),
            
            // Trackings - Multi-select dropdown
            FutureBuilder<List<String>>(
              future: userValuesProvider.getValues('trackings'),
              builder: (context, snapshot) {
                final trackings = snapshot.data ?? [];
                return MultiSelectDropdown(
                  label: 'Trackings',
                  prefixIcon: Icons.track_changes,
                  options: trackings,
                  selectedValues: addTradeProvider.trackings != null 
                      ? [addTradeProvider.trackings!] 
                      : [],
                  onChanged: (values) {
                    if (values.isNotEmpty) {
                      addTradeProvider.updateTrackings(values.first);
                    } else {
                      addTradeProvider.updateTrackings(null);
                    }
                  },
                  onAddNewValue: (value) async {
                    await userValuesProvider.addValue('trackings', value);
                    addTradeProvider.updateTrackings(value);
                  },
                  allowMultiple: false,
                  hintText: 'Select tracking method',
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // Mistakes - Multi-select dropdown
            FutureBuilder<List<String>>(
              future: userValuesProvider.getValues('mistakes'),
              builder: (context, snapshot) {
                final mistakes = snapshot.data ?? [];
                return MultiSelectDropdown(
                  label: 'Mistakes',
                  prefixIcon: Icons.error,
                  options: mistakes,
                  selectedValues: addTradeProvider.mistakes != null 
                      ? [addTradeProvider.mistakes!] 
                      : [],
                  onChanged: (values) {
                    if (values.isNotEmpty) {
                      addTradeProvider.updateMistakes(values.first);
                    } else {
                      addTradeProvider.updateMistakes(null);
                    }
                  },
                  onAddNewValue: (value) async {
                    await userValuesProvider.addValue('mistakes', value);
                    addTradeProvider.updateMistakes(value);
                  },
                  allowMultiple: false,
                  hintText: 'Select mistake type',
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransfersSection(AddTradeProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Transfers', style: AppTheme.subheadingStyle),
            const SizedBox(height: 16),
            
            // Transfer Amount
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Transfer Amount',
                hintText: '0.00',
                prefixIcon: Icons.money,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final amount = double.tryParse(value);
                provider.updateTransferAmount(amount);
              },
            ),
            
            const SizedBox(height: 16),
            
            // Transfer Screenshot
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Transfer Screenshot Path',
                hintText: 'Path to screenshot',
                prefixIcon: Icons.photo,
              ),
              onChanged: provider.updateTransferScreenshot,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDateTime(BuildContext context, AddTradeProvider provider) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    
    if (picked != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      
      if (time != null) {
        final DateTime selectedDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          time.hour,
          time.minute,
        );
        provider.updateDatetime(selectedDateTime);
      }
    }
  }

  Future<void> _selectExitDateTime(BuildContext context, AddTradeProvider provider) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    
    if (picked != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      
      if (time != null) {
        final DateTime selectedDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          time.hour,
          time.minute,
        );
        provider.updateExitDatetime(selectedDateTime);
      }
    }
  }

  String _getEntryTypeDisplayName(EntryType type) {
    switch (type) {
      case EntryType.trade:
        return 'Trade';
      case EntryType.marginInOut:
        return 'Margin In/Out';
      case EntryType.deposit:
        return 'Deposit';
      case EntryType.withdrawal:
        return 'Withdrawal';
      case EntryType.ignore:
        return 'Ignore';
    }
  }

  Widget _buildSubmitButtonContent(AddTradeProvider provider) {
    switch (provider.status) {
      case AddTradeStatus.loading:
        return const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            SizedBox(width: 12),
            Text('Adding Trade...'),
          ],
        );
      default:
        return const Text('Add Trade');
    }
  }
}
