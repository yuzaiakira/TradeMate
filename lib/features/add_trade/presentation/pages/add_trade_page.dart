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
  final ScrollController _scrollController = ScrollController();
  final Map<String, bool> _expandedSections = {
    'trade_transfers': true,
    'checklist': false,
    'trade_management': false,
    'trade_exit': false,
    'memo': false,
    'trackings': false,
    'transfers': false,
  };

  @override
  void initState() {
    super.initState();
    // Initialize default values when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserDefinedValuesProvider>().initializeDefaultValues();
      // Set default side to long if not already set
      final addTradeProvider = context.read<AddTradeProvider>();
      if (addTradeProvider.side == null) {
        addTradeProvider.updateSide(Side.long);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleSection(String sectionKey) {
    setState(() {
      _expandedSections[sectionKey] = !(_expandedSections[sectionKey] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Trade',
          style: AppTheme.subheadingStyle.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline_rounded, size: 20),
            onPressed: () => _showHelpDialog(context),
            tooltip: 'Help',
          ),
        ],
      ),
      body: Consumer2<AddTradeProvider, UserDefinedValuesProvider>(
        builder: (context, addTradeProvider, userValuesProvider, child) {
          return Column(
            children: [
              // Progress indicator
              _buildProgressIndicator(addTradeProvider),
              
              // Main content
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      
                      // Trade Transfers Section
                      _buildExpandableSection(
                        'trade_transfers',
                        'Trade Transfers',
                        Icons.swap_horiz,
                        _buildTradeTransfersSection(context, addTradeProvider, userValuesProvider),
                        isRequired: true,
                      ),
                      const SizedBox(height: 12),
                      
                      // Checklist Section
                      _buildExpandableSection(
                        'checklist',
                        'Pre-Trade Checklist',
                        Icons.checklist,
                        _buildChecklistSection(addTradeProvider),
                        isRequired: false,
                      ),
                      const SizedBox(height: 12),
                      
                      // Trade Management Section
                      _buildExpandableSection(
                        'trade_management',
                        'Trade Management',
                        Icons.settings,
                        _buildTradeManagementSection(addTradeProvider),
                        isRequired: false,
                      ),
                      const SizedBox(height: 12),
                      
                      // Trade Exit Section
                      _buildExpandableSection(
                        'trade_exit',
                        'Trade Exit',
                        Icons.exit_to_app,
                        _buildTradeExitSection(context, addTradeProvider, userValuesProvider),
                        isRequired: false,
                      ),
                      const SizedBox(height: 12),
                      
                      // Memo Section
                      _buildExpandableSection(
                        'memo',
                        'Memo & Rating',
                        Icons.note,
                        _buildMemoSection(addTradeProvider),
                        isRequired: false,
                      ),
                      const SizedBox(height: 12),
                      
                      // Trackings Section
                      _buildExpandableSection(
                        'trackings',
                        'Analysis & Tracking',
                        Icons.analytics,
                        _buildTrackingsSection(context, addTradeProvider, userValuesProvider),
                        isRequired: false,
                      ),
                      const SizedBox(height: 12),
                      
                      // Transfers Section
                      _buildExpandableSection(
                        'transfers',
                        'Transfers',
                        Icons.money,
                        _buildTransfersSection(addTradeProvider),
                        isRequired: false,
                      ),
                      const SizedBox(height: 32),
                      
                      // Submit Button
                      _buildSubmitSection(addTradeProvider),
                      
                      const SizedBox(height: 12),
                      
                      // Status Messages
                      _buildStatusMessages(addTradeProvider),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProgressIndicator(AddTradeProvider provider) {
    final requiredFields = [
      provider.symbol.isNotEmpty,
      provider.entryPrice > 0,
      provider.datetime != null,
      (provider.quantity > 0 || (provider.positionMargin != null && provider.positionMargin! > 0)),
    ];
    final completedFields = requiredFields.where((field) => field).length;
    final progress = completedFields / requiredFields.length;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: AppTheme.cardDecoration,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Progress',
                  style: AppTheme.captionStyle,
                ),
                const SizedBox(height: 2),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: AppTheme.bodyStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Required fields',
                      style: AppTheme.captionStyle,
                    ),
                    Text(
                      '$completedFields/${requiredFields.length}',
                      style: AppTheme.captionStyle.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: AppTheme.borderColor,
                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                  minHeight: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildExpandableSection(
    String sectionKey,
    String title,
    IconData icon,
    Widget content,
    {bool isRequired = false}
  ) {
    final isExpanded = _expandedSections[sectionKey] ?? false;
    
    return Container(
      decoration: AppTheme.cardDecoration.copyWith(
        border: Border.all(
          color: isRequired ? AppTheme.primaryColor : AppTheme.borderColor,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Section header
          InkWell(
            onTap: () => _toggleSection(sectionKey),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isRequired 
                    ? AppTheme.primaryColor.withValues(alpha: 0.1)
                    : AppTheme.borderColor.withValues(alpha: 0.3),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(7)),
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: isRequired ? AppTheme.primaryColor : AppTheme.textSecondaryColor,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          title,
                          style: AppTheme.bodyStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            color: isRequired ? AppTheme.primaryColor : AppTheme.textPrimaryColor,
                          ),
                        ),
                        if (isRequired) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'REQUIRED',
                              style: AppTheme.labelStyle.copyWith(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                    color: AppTheme.textSecondaryColor,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          
          // Section content
          if (isExpanded)
            Container(
              padding: const EdgeInsets.all(12),
              child: content,
            ),
        ],
      ),
    );
  }

  Widget _buildSubmitSection(AddTradeProvider provider) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: AppTheme.cardDecoration,
      child: Column(
        children: [
          // Form validation summary
          if (!provider.isFormValid) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.errorColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.errorColor.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppTheme.errorColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Please complete all required fields to continue',
                      style: AppTheme.captionStyle.copyWith(
                        color: AppTheme.errorColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
          
          // Submit button
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              onPressed: provider.isFormValid ? provider.addTrade : null,
              style: provider.isFormValid 
                  ? AppTheme.primaryButtonStyle 
                  : AppTheme.secondaryButtonStyle,
              child: _buildSubmitButtonContent(provider),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusMessages(AddTradeProvider provider) {
    return Column(
      children: [
        // Error Message
        if (provider.status == AddTradeStatus.error)
          Container(
            width: double.infinity,
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
        
        // Success Message
        if (provider.status == AddTradeStatus.success)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.successColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.successColor),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: AppTheme.successColor,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Trade added successfully!',
                        style: TextStyle(
                          color: AppTheme.successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Your trade has been saved to the database.',
                        style: AppTheme.captionStyle.copyWith(
                          color: AppTheme.successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildTradeTransfersSection(
    BuildContext context, 
    AddTradeProvider addTradeProvider, 
    UserDefinedValuesProvider userValuesProvider
  ) {
    return Column(
      children: [
        // Tag
        _buildFormField(
          label: 'Tag',
          hint: 'Enter trade tag (optional)',
          icon: Icons.tag,
          child: TextFormField(
            decoration: AppTheme.inputDecoration(
              labelText: 'Tag',
              hintText: 'Enter trade tag',
              prefixIcon: Icons.tag,
            ),
            onChanged: addTradeProvider.updateTag,
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Datetime
        _buildFormField(
          label: 'Trade Date & Time',
          hint: 'When did you enter this trade?',
          icon: Icons.schedule,
          isRequired: true,
          child: TextFormField(
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
        ),
        
        const SizedBox(height: 16),
        
        // Exchanges
        _buildFormField(
          label: 'Exchange',
          hint: 'Which exchange did you use?',
          icon: Icons.swap_horiz,
          child: FutureBuilder<List<String>>(
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
        ),
        
        const SizedBox(height: 16),
        
        // Entry Type
        _buildFormField(
          label: 'Entry Type',
          hint: 'What type of entry is this?',
          icon: Icons.input,
          child: DropdownButtonFormField<EntryType>(
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
        ),
        
        const SizedBox(height: 16),
        
        // Symbol
        _buildFormField(
          label: 'Trading Pair',
          hint: 'Which asset are you trading?',
          icon: Icons.currency_exchange,
          isRequired: true,
          child: FutureBuilder<List<String>>(
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
        ),
        
        const SizedBox(height: 16),
        
        // Strategies
        _buildFormField(
          label: 'Strategy',
          hint: 'What strategy are you using?',
          icon: Icons.trending_up,
          child: FutureBuilder<List<String>>(
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
        ),
        
        const SizedBox(height: 16),
        
        // Side
        _buildFormField(
          label: 'Position Side',
          hint: 'Are you going long or short?',
          icon: Icons.trending_up,
          child: _buildPositionSideSwitch(addTradeProvider),
        ),
        
        const SizedBox(height: 16),
        
        // Entry Price
        _buildFormField(
          label: 'Entry Price',
          hint: 'At what price did you enter?',
          icon: Icons.attach_money,
          isRequired: true,
          child: TextFormField(
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
        ),
        
        const SizedBox(height: 16),
        
        // Position Margin
        _buildFormField(
          label: 'Position Size',
          hint: 'How much are you investing?',
          icon: Icons.account_balance_wallet,
          isRequired: true,
          child: TextFormField(
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
        ),
        
        const SizedBox(height: 16),
        
        // Leverage
        _buildFormField(
          label: 'Leverage',
          hint: 'What leverage are you using?',
          icon: Icons.trending_up,
          child: TextFormField(
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
        ),
        
        const SizedBox(height: 16),
        
        // Order Type
        _buildFormField(
          label: 'Order Type',
          hint: 'What type of order did you place?',
          icon: Icons.shopping_cart,
          child: DropdownButtonFormField<OrderType>(
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
        ),
        
        const SizedBox(height: 16),
        
        // Time Frame
        _buildFormField(
          label: 'Time Frame',
          hint: 'What time frame are you trading?',
          icon: Icons.timer,
          child: DropdownButtonFormField<String>(
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
        ),
        
        const SizedBox(height: 16),
        
        // Entry Fee Rate
        _buildFormField(
          label: 'Entry Fee Rate',
          hint: 'What fee rate did you pay?',
          icon: Icons.percent,
          child: FutureBuilder<List<String>>(
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
        ),
        
        const SizedBox(height: 16),
        
        // Entry Mental States
        _buildFormField(
          label: 'Mental State',
          hint: 'How are you feeling about this trade?',
          icon: Icons.psychology,
          child: FutureBuilder<List<String>>(
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
        ),
        
        const SizedBox(height: 16),
        
        // Entry Screenshot
        _buildFormField(
          label: 'Entry Screenshot',
          hint: 'Add a screenshot of your entry (optional)',
          icon: Icons.photo,
          child: TextFormField(
            decoration: AppTheme.inputDecoration(
              labelText: 'Entry Screenshot Path',
              hintText: 'Path to screenshot',
              prefixIcon: Icons.photo,
            ),
            onChanged: addTradeProvider.updateEntryScreenshot,
          ),
        ),
      ],
    );
  }

  Widget _buildFormField({
    required String label,
    required String hint,
    required IconData icon,
    required Widget child,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: AppTheme.textSecondaryColor),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTheme.labelStyle.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimaryColor,
              ),
            ),
            if (isRequired) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'REQUIRED',
                  style: AppTheme.labelStyle.copyWith(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 2),
        Text(
          hint,
          style: AppTheme.captionStyle.copyWith(
            color: AppTheme.textTertiaryColor,
          ),
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }

  Widget _buildChecklistSection(AddTradeProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
    );
  }

  Widget _buildTradeManagementSection(AddTradeProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Set your stop loss and take profit levels to manage risk.',
          style: AppTheme.captionStyle.copyWith(
            color: AppTheme.textSecondaryColor,
          ),
        ),
        const SizedBox(height: 16),
        
        _buildFormField(
          label: 'Stop Loss Price',
          hint: 'At what price will you exit if the trade goes against you?',
          icon: Icons.stop_circle,
          child: TextFormField(
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
        ),
        
        const SizedBox(height: 16),
        
        _buildFormField(
          label: 'Take Profit Price',
          hint: 'At what price will you take your profits?',
          icon: Icons.trending_up,
          child: TextFormField(
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
        ),
      ],
    );
  }

  Widget _buildTradeExitSection(
    BuildContext context, 
    AddTradeProvider addTradeProvider, 
    UserDefinedValuesProvider userValuesProvider
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fill in exit details when you close the trade.',
          style: AppTheme.captionStyle.copyWith(
            color: AppTheme.textSecondaryColor,
          ),
        ),
        const SizedBox(height: 16),
        
        _buildFormField(
          label: 'Actual Exit Price',
          hint: 'At what price did you exit the trade?',
          icon: Icons.exit_to_app,
          child: TextFormField(
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
        ),
        
        const SizedBox(height: 16),
        
        _buildFormField(
          label: 'Position Closed',
          hint: 'What percentage of your position did you close?',
          icon: Icons.percent,
          child: TextFormField(
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
        ),
        
        const SizedBox(height: 16),
        
        _buildFormField(
          label: 'Exit Type',
          hint: 'Did you hit take profit or stop loss?',
          icon: Icons.exit_to_app,
          child: DropdownButtonFormField<ExitType>(
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
        ),
        
        const SizedBox(height: 16),
        
        _buildFormField(
          label: 'Exit Fee Rate',
          hint: 'What fee rate did you pay on exit?',
          icon: Icons.percent,
          child: FutureBuilder<List<String>>(
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
        ),
        
        const SizedBox(height: 16),
        
        _buildFormField(
          label: 'Exit Date & Time',
          hint: 'When did you exit this trade?',
          icon: Icons.schedule,
          child: TextFormField(
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
        ),
        
        const SizedBox(height: 16),
        
        _buildFormField(
          label: 'Exit Mental State',
          hint: 'How did you feel when you exited?',
          icon: Icons.psychology,
          child: FutureBuilder<List<String>>(
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
        ),
        
        const SizedBox(height: 16),
        
        _buildFormField(
          label: 'Exit Screenshot',
          hint: 'Add a screenshot of your exit (optional)',
          icon: Icons.photo,
          child: TextFormField(
            decoration: AppTheme.inputDecoration(
              labelText: 'Exit Screenshot Path',
              hintText: 'Path to screenshot',
              prefixIcon: Icons.photo,
            ),
            onChanged: addTradeProvider.updateExitScreenshot,
          ),
        ),
      ],
    );
  }

  Widget _buildMemoSection(AddTradeProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rate your trade and add notes for future reference.',
          style: AppTheme.captionStyle.copyWith(
            color: AppTheme.textSecondaryColor,
          ),
        ),
        const SizedBox(height: 16),
        
        _buildFormField(
          label: 'Trade Rating',
          hint: 'How would you rate this trade?',
          icon: Icons.star,
          child: DropdownButtonFormField<int>(
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
        ),
        
        const SizedBox(height: 16),
        
        _buildFormField(
          label: 'Memo',
          hint: 'Add your thoughts and lessons learned',
          icon: Icons.note,
          child: TextFormField(
            decoration: AppTheme.inputDecoration(
              labelText: 'Memo',
              hintText: 'Enter trade memo...',
              prefixIcon: Icons.note,
            ),
            maxLines: 3,
            onChanged: provider.updateMemo,
          ),
        ),
      ],
    );
  }

  Widget _buildTrackingsSection(
    BuildContext context, 
    AddTradeProvider addTradeProvider, 
    UserDefinedValuesProvider userValuesProvider
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Track what you analyzed and any mistakes made.',
          style: AppTheme.captionStyle.copyWith(
            color: AppTheme.textSecondaryColor,
          ),
        ),
        const SizedBox(height: 16),
        
        _buildFormField(
          label: 'Analysis Method',
          hint: 'What did you analyze before entering?',
          icon: Icons.track_changes,
          child: FutureBuilder<List<String>>(
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
        ),
        
        const SizedBox(height: 16),
        
        _buildFormField(
          label: 'Mistakes Made',
          hint: 'What mistakes did you make in this trade?',
          icon: Icons.error,
          child: FutureBuilder<List<String>>(
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
        ),
      ],
    );
  }

  Widget _buildTransfersSection(AddTradeProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Record any transfers related to this trade.',
          style: AppTheme.captionStyle.copyWith(
            color: AppTheme.textSecondaryColor,
          ),
        ),
        const SizedBox(height: 16),
        
        _buildFormField(
          label: 'Transfer Amount',
          hint: 'How much did you transfer?',
          icon: Icons.money,
          child: TextFormField(
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
        ),
        
        const SizedBox(height: 16),
        
        _buildFormField(
          label: 'Transfer Screenshot',
          hint: 'Add a screenshot of the transfer (optional)',
          icon: Icons.photo,
          child: TextFormField(
            decoration: AppTheme.inputDecoration(
              labelText: 'Transfer Screenshot Path',
              hintText: 'Path to screenshot',
              prefixIcon: Icons.photo,
            ),
            onChanged: provider.updateTransferScreenshot,
          ),
        ),
      ],
    );
  }

  Widget _buildPositionSideSwitch(AddTradeProvider provider) {
    return Container(
      height: 50,
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
                child: InkWell(
                  onTap: () => provider.updateSide(Side.long),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: SizedBox(
                    height: 50,
                    child: Center(
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
              Expanded(
                child: InkWell(
                  onTap: () => provider.updateSide(Side.short),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: SizedBox(
                    height: 50,
                    child: Center(
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
            ],
          ),
        ],
      ),
    );
  }

  // ignore: use_build_context_synchronously
  Future<void> _selectDateTime(BuildContext context, AddTradeProvider provider) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    
    if (!mounted || picked == null) return;
    
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
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
  }

  // ignore: use_build_context_synchronously
  Future<void> _selectExitDateTime(BuildContext context, AddTradeProvider provider) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    
    if (!mounted || picked == null) return;
    
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
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
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('How to Add a Trade'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Required Fields:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('• Symbol (trading pair)'),
              Text('• Entry Price'),
              Text('• Trade Date & Time'),
              Text('• Position Size (quantity or margin)'),
              SizedBox(height: 16),
              Text(
                'Optional Fields:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('• All other fields are optional but recommended for better analysis'),
              SizedBox(height: 16),
              Text(
                'Tips:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('• You can expand/collapse sections by tapping the headers'),
              Text('• Add new values to dropdowns by typing and pressing "Add"'),
              Text('• Your custom values will be saved for future use'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
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
        return const Text(
          'Add Trade',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        );
    }
  }
}
