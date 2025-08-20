import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/trade.dart';
import '../provider/add_trade_provider.dart';
import '../provider/edit_trade_provider.dart';
import '../../../../core/utils/app_theme.dart';

class EditTradePage extends StatefulWidget {
  final Trade trade;

  const EditTradePage({
    super.key,
    required this.trade,
  });

  @override
  State<EditTradePage> createState() => _EditTradePageState();
}

class _EditTradePageState extends State<EditTradePage> {
  // Controllers for form fields
  late TextEditingController _tagController;
  late TextEditingController _symbolController;
  late TextEditingController _entryPriceController;
  late TextEditingController _positionMarginController;
  late TextEditingController _leverageController;
  late TextEditingController _entryFeeRateController;
  late TextEditingController _entryMentalStatesController;
  late TextEditingController _entryScreenshotController;
  late TextEditingController _checklistController;
  late TextEditingController _stopLossController;
  late TextEditingController _takeProfitController;
  late TextEditingController _actualExitPriceController;
  late TextEditingController _marginClosedPercentController;
  late TextEditingController _exitFeeRateController;
  late TextEditingController _exitMentalStatesController;
  late TextEditingController _exitScreenshotController;
  late TextEditingController _memoController;
  late TextEditingController _trackingsController;
  late TextEditingController _mistakesController;
  late TextEditingController _transferAmountController;
  late TextEditingController _transferScreenshotController;
  late TextEditingController _datetimeController;
  late TextEditingController _exitDatetimeController;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    // Initialize form data in post frame callback to ensure provider is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EditTradeProvider>().initializeWithTrade(widget.trade);
      _initializeFormWithTradeData();
    });
  }

  @override
  void dispose() {
    _tagController.dispose();
    _symbolController.dispose();
    _entryPriceController.dispose();
    _positionMarginController.dispose();
    _leverageController.dispose();
    _entryFeeRateController.dispose();
    _entryMentalStatesController.dispose();
    _entryScreenshotController.dispose();
    _checklistController.dispose();
    _stopLossController.dispose();
    _takeProfitController.dispose();
    _actualExitPriceController.dispose();
    _marginClosedPercentController.dispose();
    _exitFeeRateController.dispose();
    _exitMentalStatesController.dispose();
    _exitScreenshotController.dispose();
    _memoController.dispose();
    _trackingsController.dispose();
    _mistakesController.dispose();
    _transferAmountController.dispose();
    _transferScreenshotController.dispose();
    _datetimeController.dispose();
    _exitDatetimeController.dispose();
    super.dispose();
  }

  void _initializeControllers() {
    _tagController = TextEditingController();
    _symbolController = TextEditingController();
    _entryPriceController = TextEditingController();
    _positionMarginController = TextEditingController();
    _leverageController = TextEditingController();
    _entryFeeRateController = TextEditingController();
    _entryMentalStatesController = TextEditingController();
    _entryScreenshotController = TextEditingController();
    _checklistController = TextEditingController();
    _stopLossController = TextEditingController();
    _takeProfitController = TextEditingController();
    _actualExitPriceController = TextEditingController();
    _marginClosedPercentController = TextEditingController();
    _exitFeeRateController = TextEditingController();
    _exitMentalStatesController = TextEditingController();
    _exitScreenshotController = TextEditingController();
    _memoController = TextEditingController();
    _trackingsController = TextEditingController();
    _mistakesController = TextEditingController();
    _transferAmountController = TextEditingController();
    _transferScreenshotController = TextEditingController();
    _datetimeController = TextEditingController();
    _exitDatetimeController = TextEditingController();
  }

  void _initializeFormWithTradeData() {
    final addTradeProvider = context.read<AddTradeProvider>();
    final trade = widget.trade;

    // Set controller values first
    _tagController.text = trade.tag ?? '';
    _symbolController.text = trade.symbol;
    _entryPriceController.text = trade.entryPrice > 0 ? trade.entryPrice.toString() : '';
    _positionMarginController.text = trade.positionMargin?.toString() ?? '';
    _leverageController.text = trade.leverage?.toString() ?? '';
    _entryFeeRateController.text = trade.entryFeeRate?.toString() ?? '';
    _entryMentalStatesController.text = trade.entryMentalStates ?? '';
    _entryScreenshotController.text = trade.entryScreenshot ?? '';
    _checklistController.text = trade.checklist?.join('\n') ?? '';
    _stopLossController.text = trade.stopLossPrice?.toString() ?? '';
    _takeProfitController.text = trade.takeProfitPrice?.toString() ?? '';
    _actualExitPriceController.text = trade.actualExitPrice?.toString() ?? '';
    _marginClosedPercentController.text = trade.marginClosedPercent?.toString() ?? '';
    _exitFeeRateController.text = trade.exitFeeRate?.toString() ?? '';
    _exitMentalStatesController.text = trade.exitMentalStates ?? '';
    _exitScreenshotController.text = trade.exitScreenshot ?? '';
    _memoController.text = trade.memo ?? '';
    _trackingsController.text = trade.trackings ?? '';
    _mistakesController.text = trade.mistakes ?? '';
    _transferAmountController.text = trade.transferAmount?.toString() ?? '';
    _transferScreenshotController.text = trade.transferScreenshot ?? '';
    _datetimeController.text = trade.datetime.toString().substring(0, 16);
    _exitDatetimeController.text = trade.exitDatetime?.toString().substring(0, 16) ?? 'Select exit datetime';

    // Initialize form fields with existing trade data
    addTradeProvider.updateTag(trade.tag ?? '');
    addTradeProvider.updateDatetime(trade.datetime);
    addTradeProvider.updateExchanges(trade.exchanges);
    addTradeProvider.updateEntryType(trade.entryType);
    addTradeProvider.updateSymbol(trade.symbol);
    addTradeProvider.updateStrategies(trade.strategies);
    addTradeProvider.updateSide(trade.side);
    addTradeProvider.updateEntryPrice(trade.entryPrice);
    addTradeProvider.updatePositionMargin(trade.positionMargin);
    addTradeProvider.updateLeverage(trade.leverage);
    addTradeProvider.updateOrderType(trade.orderType);
    addTradeProvider.updateTimeFrame(trade.timeFrame);
    addTradeProvider.updateEntryFeeRate(trade.entryFeeRate);
    addTradeProvider.updateEntryMentalStates(trade.entryMentalStates);
    addTradeProvider.updateEntryScreenshot(trade.entryScreenshot ?? '');
    addTradeProvider.updateChecklist(trade.checklist ?? []);
    addTradeProvider.updateStopLossPrice(trade.stopLossPrice);
    addTradeProvider.updateTakeProfitPrice(trade.takeProfitPrice);
    addTradeProvider.updateActualExitPrice(trade.actualExitPrice);
    addTradeProvider.updateMarginClosedPercent(trade.marginClosedPercent);
    addTradeProvider.updateExitType(trade.exitType);
    addTradeProvider.updateExitFeeRate(trade.exitFeeRate);
    addTradeProvider.updateExitDatetime(trade.exitDatetime);
    addTradeProvider.updateExitMentalStates(trade.exitMentalStates);
    addTradeProvider.updateExitScreenshot(trade.exitScreenshot ?? '');
    addTradeProvider.updateRating(trade.rating);
    addTradeProvider.updateMemo(trade.memo ?? '');
    addTradeProvider.updateTrackings(trade.trackings);
    addTradeProvider.updateMistakes(trade.mistakes);
    addTradeProvider.updateTransferAmount(trade.transferAmount);
    addTradeProvider.updateTransferScreenshot(trade.transferScreenshot ?? '');
    
    // Set legacy fields that are required for validation
    addTradeProvider.updateQuantity(trade.quantity);
    addTradeProvider.updateType(trade.type);
    addTradeProvider.updateNotes(trade.notes ?? '');
    addTradeProvider.updateAccountBalance(trade.accountBalance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Trade - ${widget.trade.symbol}',
          style: AppTheme.subheadingStyle.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Consumer2<AddTradeProvider, EditTradeProvider>(
        builder: (context, addTradeProvider, editTradeProvider, child) {
          return Column(
            children: [
              // Edit message
              _buildEditMessage(),
              
              // Reuse the AddTradePage content
              Expanded(
                child: _buildEditForm(addTradeProvider, editTradeProvider),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEditMessage() {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(12),
      decoration: AppTheme.cardDecoration.copyWith(
        border: Border.all(color: AppTheme.primaryColor),
      ),
      child: Row(
        children: [
          Icon(
            Icons.edit_rounded,
            color: AppTheme.primaryColor,
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Editing Trade',
                  style: AppTheme.bodyStyle.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Make changes and save to update',
                  style: AppTheme.captionStyle.copyWith(
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditForm(AddTradeProvider addTradeProvider, EditTradeProvider editTradeProvider) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // Trade Transfers Section
                _buildTradeTransfersSection(addTradeProvider),
                const SizedBox(height: 12),
                
                // Checklist Section
                _buildChecklistSection(addTradeProvider),
                const SizedBox(height: 12),
                
                // Trade Management Section
                _buildTradeManagementSection(addTradeProvider),
                const SizedBox(height: 12),
                
                // Trade Exit Section
                _buildTradeExitSection(addTradeProvider),
                const SizedBox(height: 12),
                
                // Memo Section
                _buildMemoSection(addTradeProvider),
                const SizedBox(height: 12),
                
                // Trackings Section
                _buildTrackingsSection(addTradeProvider),
                const SizedBox(height: 12),
                
                // Transfers Section
                _buildTransfersSection(addTradeProvider),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
        
        // Submit button
        _buildSubmitSection(addTradeProvider, editTradeProvider),
        
        // Status messages
        _buildStatusMessages(editTradeProvider),
      ],
    );
  }

  Widget _buildTradeTransfersSection(AddTradeProvider provider) {
    return Container(
      decoration: AppTheme.cardDecoration,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.swap_horiz_rounded,
                  size: 16,
                  color: AppTheme.textSecondaryColor,
                ),
                const SizedBox(width: 6),
                Text(
                  'Trade Transfers',
                  style: AppTheme.bodyStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Tag
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Tag',
                prefixIcon: Icons.tag,
              ),
              controller: _tagController,
              onChanged: provider.updateTag,
            ),
            
            const SizedBox(height: 16),
            
            // Datetime
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Trade Date & Time',
                prefixIcon: Icons.schedule,
              ),
              controller: _datetimeController,
              readOnly: true,
              onTap: () => _selectDateTime(context, provider),
            ),
            
            const SizedBox(height: 16),
            
            // Symbol
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Symbol',
                prefixIcon: Icons.currency_exchange,
              ),
              controller: _symbolController,
              onChanged: provider.updateSymbol,
            ),
            
            const SizedBox(height: 16),
            
            // Entry Type
            DropdownButtonFormField<EntryType>(
              decoration: AppTheme.inputDecoration(
                labelText: 'Entry Type',
                prefixIcon: Icons.input,
              ),
              value: provider.entryType,
              items: EntryType.values
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(_getEntryTypeDisplayName(type)),
                      ))
                  .toList(),
              onChanged: provider.updateEntryType,
            ),
            
            const SizedBox(height: 16),
            
            // Side
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Position Side',
                  style: AppTheme.bodyStyle,
                ),
                const SizedBox(height: 8),
                _buildPositionSideSwitch(provider),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Entry Price
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Entry Price',
                prefixIcon: Icons.attach_money,
              ),
              controller: _entryPriceController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final price = double.tryParse(value) ?? 0.0;
                provider.updateEntryPrice(price);
              },
            ),
            
            const SizedBox(height: 16),
            
            // Position Margin
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Position Margin',
                prefixIcon: Icons.account_balance_wallet,
              ),
              controller: _positionMarginController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final margin = double.tryParse(value);
                provider.updatePositionMargin(margin);
              },
            ),
            
            const SizedBox(height: 16),
            
            // Leverage
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Leverage',
                prefixIcon: Icons.trending_up,
              ),
              controller: _leverageController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final leverage = double.tryParse(value);
                provider.updateLeverage(leverage);
              },
            ),
            
            const SizedBox(height: 16),
            
            // Order Type
            DropdownButtonFormField<OrderType>(
              decoration: AppTheme.inputDecoration(
                labelText: 'Order Type',
                prefixIcon: Icons.shopping_cart,
              ),
              value: provider.orderType,
              items: OrderType.values
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type.name.toUpperCase()),
                      ))
                  .toList(),
              onChanged: provider.updateOrderType,
            ),
            
            const SizedBox(height: 16),
            
            // Time Frame
            DropdownButtonFormField<String>(
              decoration: AppTheme.inputDecoration(
                labelText: 'Time Frame',
                prefixIcon: Icons.timer,
              ),
              value: provider.timeFrame,
              items: ['1m', '5m', '15m', '30m', '1h', '4h', '1d', '1w']
                  .map((timeframe) => DropdownMenuItem(
                        value: timeframe,
                        child: Text(timeframe),
                      ))
                  .toList(),
              onChanged: provider.updateTimeFrame,
            ),
            
            const SizedBox(height: 16),
            
            // Entry Fee Rate
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Entry Fee Rate',
                prefixIcon: Icons.percent,
              ),
              controller: _entryFeeRateController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final rate = double.tryParse(value);
                provider.updateEntryFeeRate(rate);
              },
            ),
            
            const SizedBox(height: 16),
            
            // Entry Mental States
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Entry Mental States',
                prefixIcon: Icons.psychology,
              ),
              controller: _entryMentalStatesController,
              onChanged: provider.updateEntryMentalStates,
            ),
            
            const SizedBox(height: 16),
            
            // Entry Screenshot
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Entry Screenshot',
                prefixIcon: Icons.photo,
              ),
              controller: _entryScreenshotController,
              onChanged: provider.updateEntryScreenshot,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChecklistSection(AddTradeProvider provider) {
    return Container(
      decoration: AppTheme.cardDecoration,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pre-Trade Checklist',
              style: AppTheme.subheadingStyle.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Pre-trade checklist helps ensure you\'re following your trading plan.',
              style: AppTheme.captionStyle.copyWith(
                color: AppTheme.textSecondaryColor,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Checklist Items',
                prefixIcon: Icons.checklist,
              ),
              controller: _checklistController,
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
    return Container(
      decoration: AppTheme.cardDecoration,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trade Management',
              style: AppTheme.subheadingStyle.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Set your stop loss and take profit levels to manage risk.',
              style: AppTheme.captionStyle.copyWith(
                color: AppTheme.textSecondaryColor,
              ),
            ),
            const SizedBox(height: 16),
            
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Stop Loss Price',
                prefixIcon: Icons.stop_circle,
              ),
              controller: _stopLossController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final stopLoss = double.tryParse(value);
                provider.updateStopLossPrice(stopLoss);
              },
            ),
            
            const SizedBox(height: 16),
            
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Take Profit Price',
                prefixIcon: Icons.trending_up,
              ),
              controller: _takeProfitController,
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

  Widget _buildTradeExitSection(AddTradeProvider provider) {
    return Container(
      decoration: AppTheme.cardDecoration,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trade Exit',
              style: AppTheme.subheadingStyle.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Fill in exit details when you close the trade.',
              style: AppTheme.captionStyle.copyWith(
                color: AppTheme.textSecondaryColor,
              ),
            ),
            const SizedBox(height: 16),
            
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Actual Exit Price',
                prefixIcon: Icons.exit_to_app,
              ),
              controller: _actualExitPriceController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final exitPrice = double.tryParse(value);
                provider.updateActualExitPrice(exitPrice);
              },
            ),
            
            const SizedBox(height: 16),
            
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: '% of Margin Closed',
                prefixIcon: Icons.percent,
              ),
              controller: _marginClosedPercentController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final percent = double.tryParse(value);
                provider.updateMarginClosedPercent(percent);
              },
            ),
            
            const SizedBox(height: 16),
            
            DropdownButtonFormField<ExitType>(
              decoration: AppTheme.inputDecoration(
                labelText: 'Exit Type',
                prefixIcon: Icons.exit_to_app,
              ),
              value: provider.exitType,
              items: ExitType.values
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type.name.toUpperCase()),
                      ))
                  .toList(),
              onChanged: provider.updateExitType,
            ),
            
            const SizedBox(height: 16),
            
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Exit Fee Rate',
                prefixIcon: Icons.percent,
              ),
              controller: _exitFeeRateController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final rate = double.tryParse(value);
                provider.updateExitFeeRate(rate);
              },
            ),
            
            const SizedBox(height: 16),
            
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Exit Date & Time',
                prefixIcon: Icons.schedule,
              ),
              controller: _exitDatetimeController,
              readOnly: true,
              onTap: () => _selectExitDateTime(context, provider),
            ),
            
            const SizedBox(height: 16),
            
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Exit Mental State',
                prefixIcon: Icons.psychology,
              ),
              controller: _exitMentalStatesController,
              onChanged: provider.updateExitMentalStates,
            ),
            
            const SizedBox(height: 16),
            
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Exit Screenshot',
                prefixIcon: Icons.photo,
              ),
              controller: _exitScreenshotController,
              onChanged: provider.updateExitScreenshot,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemoSection(AddTradeProvider provider) {
    return Container(
      decoration: AppTheme.cardDecoration,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Memo & Rating',
              style: AppTheme.subheadingStyle.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Rate your trade and add notes for future reference.',
              style: AppTheme.captionStyle.copyWith(
                color: AppTheme.textSecondaryColor,
              ),
            ),
            const SizedBox(height: 16),
            
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
            
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Memo',
                prefixIcon: Icons.note,
              ),
              controller: _memoController,
              maxLines: 3,
              onChanged: provider.updateMemo,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitSection(AddTradeProvider addTradeProvider, EditTradeProvider editTradeProvider) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: AppTheme.cardDecoration,
      child: SizedBox(
        width: double.infinity,
        height: 40,
        child: ElevatedButton(
          onPressed: addTradeProvider.isFormValid ? () => _updateTrade(addTradeProvider, editTradeProvider) : null,
          style: addTradeProvider.isFormValid 
              ? AppTheme.primaryButtonStyle 
              : AppTheme.secondaryButtonStyle,
          child: _buildSubmitButtonContent(editTradeProvider),
        ),
      ),
    );
  }

  void _updateTrade(AddTradeProvider addTradeProvider, EditTradeProvider editTradeProvider) async {
    // Build the trade with the original ID preserved
    final trade = addTradeProvider.buildTrade().copyWith(id: widget.trade.id);
    
    await editTradeProvider.updateTrade(trade);
    
    // If successful, navigate back
    if (editTradeProvider.status == EditTradeStatus.success) {
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Trade updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  // ignore: use_build_context_synchronously
  Future<void> _selectDateTime(BuildContext context, AddTradeProvider provider) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: provider.datetime ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    
    if (!mounted || picked == null) return;
    
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(provider.datetime ?? DateTime.now()),
    );
    
    if (!mounted || time == null) return;
    
    final DateTime selectedDateTime = DateTime(
      picked.year,
      picked.month,
      picked.day,
      time.hour,
      time.minute,
    );
    provider.updateDatetime(selectedDateTime);
    // Update the datetime field in the form
    setState(() {
      _datetimeController.text = selectedDateTime.toString().substring(0, 16);
    });
  }

  // ignore: use_build_context_synchronously
  Future<void> _selectExitDateTime(BuildContext context, AddTradeProvider provider) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: provider.exitDatetime ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    
    if (!mounted || picked == null) return;
    
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(provider.exitDatetime ?? DateTime.now()),
    );
    
    if (!mounted || time == null) return;
    
    final DateTime selectedDateTime = DateTime(
      picked.year,
      picked.month,
      picked.day,
      time.hour,
      time.minute,
    );
    provider.updateExitDatetime(selectedDateTime);
    // Update the exit datetime field in the form
    setState(() {
      _exitDatetimeController.text = selectedDateTime.toString().substring(0, 16);
    });
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

  Widget _buildSubmitButtonContent(EditTradeProvider provider) {
    switch (provider.status) {
      case EditTradeStatus.loading:
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
            Text('Updating Trade...'),
          ],
        );
      default:
        return const Text(
          'Update Trade',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        );
    }
  }

  Widget _buildTrackingsSection(AddTradeProvider provider) {
    return Container(
      decoration: AppTheme.cardDecoration,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Analysis & Tracking',
              style: AppTheme.subheadingStyle.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Track what you analyzed and any mistakes made.',
              style: AppTheme.captionStyle.copyWith(
                color: AppTheme.textSecondaryColor,
              ),
            ),
            const SizedBox(height: 16),
            
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Analysis Method',
                prefixIcon: Icons.track_changes,
              ),
              controller: _trackingsController,
              onChanged: provider.updateTrackings,
            ),
            
            const SizedBox(height: 16),
            
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Mistakes Made',
                prefixIcon: Icons.psychology,
              ),
              controller: _mistakesController,
              onChanged: provider.updateMistakes,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransfersSection(AddTradeProvider provider) {
    return Container(
      decoration: AppTheme.cardDecoration,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Transfers',
              style: AppTheme.subheadingStyle.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Record any transfers related to this trade.',
              style: AppTheme.captionStyle.copyWith(
                color: AppTheme.textSecondaryColor,
              ),
            ),
            const SizedBox(height: 16),
            
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Transfer Amount',
                prefixIcon: Icons.money,
              ),
              controller: _transferAmountController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final amount = double.tryParse(value);
                provider.updateTransferAmount(amount);
              },
            ),
            
            const SizedBox(height: 16),
            
            TextFormField(
              decoration: AppTheme.inputDecoration(
                labelText: 'Transfer Screenshot',
                prefixIcon: Icons.photo,
              ),
              controller: _transferScreenshotController,
              onChanged: provider.updateTransferScreenshot,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusMessages(EditTradeProvider provider) {
    return Column(
      children: [
        if (provider.status == EditTradeStatus.error)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.errorColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.errorColor),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: AppTheme.errorColor,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    provider.errorMessage,
                    style: TextStyle(
                      color: AppTheme.errorColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildPositionSideSwitch(AddTradeProvider provider) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.borderColor),
        color: AppTheme.surfaceColor,
      ),
      child: Stack(
        children: [
          // Animated sliding background
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: provider.side == Side.long ? 0 : null,
            right: provider.side == Side.short ? 0 : null,
            top: 0,
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4, // Half width minus padding
              decoration: BoxDecoration(
                color: provider.side == Side.long 
                    ? AppTheme.bullishColor 
                    : AppTheme.bearishColor,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          // Content
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => provider.updateSide(Side.long),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                      onTap: () => provider.updateSide(Side.long),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: Icon(
                                Icons.trending_up,
                                key: ValueKey(provider.side == Side.long),
                                color: provider.side == Side.long 
                                    ? Colors.white 
                                    : AppTheme.textSecondaryColor,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 8),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: Text(
                                'LONG',
                                key: ValueKey(provider.side == Side.long),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: provider.side == Side.long 
                                      ? Colors.white 
                                      : AppTheme.textSecondaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => provider.updateSide(Side.short),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                      onTap: () => provider.updateSide(Side.short),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: Icon(
                                Icons.trending_down,
                                key: ValueKey(provider.side == Side.short),
                                color: provider.side == Side.short 
                                    ? Colors.white 
                                    : AppTheme.textSecondaryColor,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 8),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: Text(
                                'SHORT',
                                key: ValueKey(provider.side == Side.short),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: provider.side == Side.short 
                                      ? Colors.white 
                                      : AppTheme.textSecondaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
