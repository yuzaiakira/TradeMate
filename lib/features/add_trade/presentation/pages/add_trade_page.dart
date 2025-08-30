import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/trade.dart' as domain;
import '../provider/add_trade_provider.dart';
import '../../../../core/utils/app_theme.dart';
import '../../../../core/widgets/multi_select_dropdown.dart';
import '../../../../core/widgets/custom_time_picker.dart';
import '../../../../core/widgets/toast_message.dart';
import '../../../../core/widgets/checklist_widget.dart';
import '../../../../core/providers/user_defined_values_provider.dart';
import 'manage_values_page.dart';
import '../../../../core/utils/navigation_service.dart';

class AddTradePage extends StatefulWidget {
  const AddTradePage({super.key});

  @override
  State<AddTradePage> createState() => _AddTradePageState();
}

class _AddTradePageState extends State<AddTradePage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _entryPriceController = TextEditingController();
  final TextEditingController _positionMarginController = TextEditingController();
  final TextEditingController _leverageController = TextEditingController();
  final TextEditingController _stopLossController = TextEditingController();
  final TextEditingController _takeProfitController = TextEditingController();
  final TextEditingController _exitPriceController = TextEditingController();
  final TextEditingController _memoController = TextEditingController();
  
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<UserDefinedValuesProvider>().initializeDefaultValues();
      // Set default side to long if not already set
      final addTradeProvider = context.read<AddTradeProvider>();
      if (addTradeProvider.side == null) {
        addTradeProvider.updateSide(domain.Side.long);
      }
      
      // Load current account balance
      await addTradeProvider.loadCurrentAccountBalance();
      
      // Add a safety timeout to prevent UI from getting stuck in loading state
      Future.delayed(const Duration(seconds: 20), () {
        if (mounted && addTradeProvider.status == AddTradeStatus.loading) {
          addTradeProvider.reset();
          if (mounted) {
            showToast(
              context,
              message: 'Operation timed out. Please try again.',
              type: ToastType.error,
            );
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _entryPriceController.dispose();
    _positionMarginController.dispose();
    _leverageController.dispose();
    _stopLossController.dispose();
    _takeProfitController.dispose();
    _exitPriceController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  void _toggleSection(String sectionKey) {
    setState(() {
      _expandedSections[sectionKey] = !(_expandedSections[sectionKey] ?? false);
    });
  }

  void _clearTextControllers() {
    _entryPriceController.clear();
    _positionMarginController.clear();
    _leverageController.clear();
    _stopLossController.clear();
    _takeProfitController.clear();
    _exitPriceController.clear();
    _memoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 20),
          onPressed: () {
            // Navigate to home instead of popping
            NavigationService().navigateToHome();
          },
          tooltip: 'Back to Home',
        ),
        title: Text(
          'Add Trade',
          style: AppTheme.subheadingStyle.copyWith(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, size: 20),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ManageValuesPage()),
            ),
            tooltip: 'Manage Values',
          ),
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
                        _buildTradeTransfersSection(
                          context,
                          addTradeProvider,
                          userValuesProvider,
                        ),
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
                        _buildTradeExitSection(
                          context,
                          addTradeProvider,
                          userValuesProvider,
                        ),
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
                        _buildTrackingsSection(
                          context,
                          addTradeProvider,
                          userValuesProvider,
                        ),
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
      (provider.quantity > 0 ||
          (provider.positionMargin != null && provider.positionMargin! > 0)),
    ];
    final completedFields = requiredFields.where((field) => field).length;
    final progress = completedFields / requiredFields.length;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      decoration: AppTheme.cardDecoration,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.assignment_turned_in,
                      color: AppTheme.primaryColor,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Form Progress',
                      style: AppTheme.bodyStyle.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: progress == 1.0 
                        ? AppTheme.successColor.withValues(alpha: 0.1)
                        : AppTheme.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: progress == 1.0 
                          ? AppTheme.successColor.withValues(alpha: 0.3)
                          : AppTheme.primaryColor.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    '$completedFields/${requiredFields.length}',
                    style: AppTheme.captionStyle.copyWith(
                      color: progress == 1.0 
                          ? AppTheme.successColor
                          : AppTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: AppTheme.borderColor,
              valueColor: AlwaysStoppedAnimation<Color>(
                progress == 1.0 ? AppTheme.successColor : AppTheme.primaryColor,
              ),
              minHeight: 8,
            ),
            const SizedBox(height: 8),
            Text(
              progress == 1.0 
                  ? 'All required fields completed! You can now save your trade.'
                  : 'Complete all required fields to save your trade',
              style: AppTheme.captionStyle.copyWith(
                color: progress == 1.0 
                    ? AppTheme.successColor
                    : AppTheme.textSecondaryColor,
                fontWeight: progress == 1.0 ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableSection(
    String sectionKey,
    String title,
    IconData icon,
    Widget content, {
    bool isRequired = false,
  }) {
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
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(7),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: isRequired
                        ? AppTheme.primaryColor
                        : AppTheme.textSecondaryColor,
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
                            color: isRequired
                                ? AppTheme.primaryColor
                                : AppTheme.textPrimaryColor,
                          ),
                        ),
                        if (isRequired) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
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
                    isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: AppTheme.textSecondaryColor,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),

          // Section content
          if (isExpanded)
            Container(padding: const EdgeInsets.all(12), child: content),
        ],
      ),
    );
  }

  Widget _buildSubmitSection(AddTradeProvider provider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.cardDecoration,
      child: Column(
        children: [
          // Form validation summary
          if (!provider.isFormValid) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.errorColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppTheme.errorColor.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppTheme.errorColor,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Required Fields Missing',
                          style: AppTheme.bodyStyle.copyWith(
                            color: AppTheme.errorColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Please complete all required fields to continue',
                          style: AppTheme.captionStyle.copyWith(
                            color: AppTheme.errorColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],

          // Loading state with progress
          if (provider.status == AddTradeStatus.loading) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppTheme.primaryColor.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Saving Trade...',
                              style: AppTheme.bodyStyle.copyWith(
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Please wait while we save your trade data',
                              style: AppTheme.captionStyle.copyWith(
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    backgroundColor: AppTheme.borderColor,
                    valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                    minHeight: 4,
                  ),
                  const SizedBox(height: 12),
                  // Add a cancel button in case of hanging
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        provider.reset();
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.primaryColor,
                        side: BorderSide(color: AppTheme.primaryColor),
                      ),
                      child: Text(
                        'Cancel',
                        style: AppTheme.captionStyle.copyWith(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],

                    // Submit button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: (provider.isFormValid && provider.status != AddTradeStatus.loading && provider.status != AddTradeStatus.success) 
                  ? () async {
                      try {
                        // Simple save without confirmation dialog
                        await provider.addTrade().timeout(
                          const Duration(seconds: 10),
                          onTimeout: () {
                            throw Exception('Operation timed out. Please try again.');
                          },
                        );
                        // Show toast based on result
                        if (mounted) {
                          if (provider.status == AddTradeStatus.success) {
                            showToast(
                              context,
                              message: 'Trade saved successfully!',
                              type: ToastType.success,
                            );
                          } else if (provider.status == AddTradeStatus.error) {
                            showToast(
                              context,
                              message: provider.errorMessage,
                              type: ToastType.error,
                            );
                          }
                        }
                      } catch (e) {
                        debugPrint('Error in submit button: $e');
                        if (mounted) {
                          showToast(
                            context,
                            message: 'Error saving trade: $e',
                            type: ToastType.error,
                          );
                        }
                      }
                    }
                  : null,
              style: (provider.isFormValid && provider.status != AddTradeStatus.loading && provider.status != AddTradeStatus.success)
                  ? AppTheme.primaryButtonStyle.copyWith(
                      backgroundColor: WidgetStateProperty.all(AppTheme.primaryColor),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                    )
                  : AppTheme.secondaryButtonStyle,
              child: _buildSubmitButtonContent(provider),
            ),
          ),
          
          // Success message and action
          if (provider.status == AddTradeStatus.success) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.successColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppTheme.successColor.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppTheme.successColor,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Trade Saved Successfully!',
                          style: AppTheme.bodyStyle.copyWith(
                            color: AppTheme.successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Add Another Trade Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        provider.resetAfterSuccess();
                        _clearTextControllers();
                        // Scroll to top
                        _scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      style: AppTheme.primaryButtonStyle.copyWith(
                        backgroundColor: WidgetStateProperty.all(AppTheme.successColor),
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, size: 18, color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            'Add Another Trade',
                            style: AppTheme.bodyStyle.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // View Trades Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to trade list using navigation service
                        if (context.mounted) {
                          NavigationService().navigateToTradeList();
                          showToast(
                            context,
                            message: 'Navigating to Trade List...',
                            type: ToastType.success,
                          );
                        }
                      },
                      style: AppTheme.secondaryButtonStyle.copyWith(
                        backgroundColor: WidgetStateProperty.all(AppTheme.primaryColor),
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.list, size: 18, color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            'View Trades',
                            style: AppTheme.bodyStyle.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.errorColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.errorColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.error_outline, color: AppTheme.errorColor, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Trade Not Saved',
                        style: AppTheme.subheadingStyle.copyWith(
                          color: AppTheme.errorColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  provider.errorMessage,
                  style: AppTheme.bodyStyle.copyWith(
                    color: AppTheme.errorColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      provider.reset();
                      _scrollController.animateTo(
                        0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    style: AppTheme.dangerButtonStyle,
                    child: Text(
                      'Try Again',
                      style: AppTheme.bodyStyle.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        // Success Message - Removed duplicate message since it's already shown in submit section
      ],
    );
  }

  Widget _buildTradeTransfersSection(
    BuildContext context,
    AddTradeProvider addTradeProvider,
    UserDefinedValuesProvider userValuesProvider,
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
              text:
                  addTradeProvider.datetime?.toString().substring(0, 16) ??
                  'Select datetime',
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
              // Include currently selected value in options if it's not already there
              final allOptions = List<String>.from(exchanges);
              if (addTradeProvider.exchanges != null &&
                  !allOptions.contains(addTradeProvider.exchanges!)) {
                allOptions.add(addTradeProvider.exchanges!);
              }
              return MultiSelectDropdown(
                label: 'Exchanges',
                prefixIcon: Icons.swap_horiz,
                options: allOptions,
                selectedValues: addTradeProvider.exchanges != null
                    ? [addTradeProvider.exchanges!]
                    : [],
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
          child: DropdownButtonFormField<domain.EntryType>(
            decoration: AppTheme.inputDecoration(
              labelText: 'Entry Type',
              prefixIcon: Icons.input,
            ),
            value: addTradeProvider.entryType,
            items: domain.EntryType.values
                .where((type) => type != domain.EntryType.deposit && type != domain.EntryType.withdrawal)
                .map(
                  (type) => DropdownMenuItem(
                    value: type,
                    child: Text(_getEntryTypeDisplayName(type)),
                  ),
                )
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
              // Include currently selected value in options if it's not already there
              final allOptions = List<String>.from(symbols);
              if (addTradeProvider.symbol.isNotEmpty &&
                  !allOptions.contains(addTradeProvider.symbol)) {
                allOptions.add(addTradeProvider.symbol);
              }
              return MultiSelectDropdown(
                label: 'Symbol',
                prefixIcon: Icons.currency_exchange,
                options: allOptions,
                selectedValues: addTradeProvider.symbol.isNotEmpty
                    ? [addTradeProvider.symbol]
                    : [],
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
              // Include currently selected value in options if it's not already there
              final allOptions = List<String>.from(strategies);
              if (addTradeProvider.strategies != null &&
                  !allOptions.contains(addTradeProvider.strategies!)) {
                allOptions.add(addTradeProvider.strategies!);
              }
              return MultiSelectDropdown(
                label: 'Strategies',
                prefixIcon: Icons.trending_up,
                options: allOptions,
                selectedValues: addTradeProvider.strategies != null
                    ? [addTradeProvider.strategies!]
                    : [],
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
            controller: _entryPriceController,
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
            controller: _positionMarginController,
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
            controller: _leverageController,
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
          child: DropdownButtonFormField<domain.OrderType>(
            decoration: AppTheme.inputDecoration(
              labelText: 'Order Type',
              prefixIcon: Icons.shopping_cart,
            ),
            value: addTradeProvider.orderType,
                          items: domain.OrderType.values
                .map(
                  (type) => DropdownMenuItem(
                    value: type,
                    child: Text(type.name.toUpperCase()),
                  ),
                )
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
                .map(
                  (timeframe) => DropdownMenuItem(
                    value: timeframe,
                    child: Text(timeframe),
                  ),
                )
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
              // Include currently selected value in options if it's not already there
              final allOptions = List<String>.from(feeRates);
              if (addTradeProvider.entryFeeRate != null) {
                final currentValue = addTradeProvider.entryFeeRate.toString();
                if (!allOptions.contains(currentValue)) {
                  allOptions.add(currentValue);
                }
              }
              return MultiSelectDropdown(
                label: 'Entry Fee Rate',
                prefixIcon: Icons.percent,
                options: allOptions,
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
              // Include currently selected value in options if it's not already there
              final allOptions = List<String>.from(mentalStates);
              if (addTradeProvider.entryMentalStates != null &&
                  !allOptions.contains(addTradeProvider.entryMentalStates!)) {
                allOptions.add(addTradeProvider.entryMentalStates!);
              }
              return MultiSelectDropdown(
                label: 'Entry Mental States',
                prefixIcon: Icons.psychology,
                options: allOptions,
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
    return Consumer<UserDefinedValuesProvider>(
      builder: (context, userValuesProvider, child) {
        return FutureBuilder<List<String>>(
          future: userValuesProvider.getValues('checklist'),
          builder: (context, snapshot) {
            final availableItems = snapshot.data ?? [];
            
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
                ChecklistWidget(
                  selectedItems: provider.checklist ?? [],
                  availableItems: availableItems,
                  onSelectionChanged: (selectedItems) {
                    provider.updateChecklist(selectedItems);
                  },
                  label: 'Select checklist items',
                  hint: 'Search and select items from your checklist',
                ),
              ],
            );
          },
        );
      },
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
    UserDefinedValuesProvider userValuesProvider,
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
          child: DropdownButtonFormField<domain.ExitType>(
            decoration: AppTheme.inputDecoration(
              labelText: 'Exit Type',
              prefixIcon: Icons.exit_to_app,
            ),
            value: addTradeProvider.exitType,
                          items: domain.ExitType.values
                .map(
                  (type) => DropdownMenuItem(
                    value: type,
                    child: Text(type.name.toUpperCase()),
                  ),
                )
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
              // Include currently selected value in options if it's not already there
              final allOptions = List<String>.from(feeRates);
              if (addTradeProvider.exitFeeRate != null) {
                final currentValue = addTradeProvider.exitFeeRate.toString();
                if (!allOptions.contains(currentValue)) {
                  allOptions.add(currentValue);
                }
              }
              return MultiSelectDropdown(
                label: 'Exit Fee Rate',
                prefixIcon: Icons.percent,
                options: allOptions,
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
              text:
                  addTradeProvider.exitDatetime?.toString().substring(0, 16) ??
                  'Select exit datetime',
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
              // Include currently selected value in options if it's not already there
              final allOptions = List<String>.from(mentalStates);
              if (addTradeProvider.exitMentalStates != null &&
                  !allOptions.contains(addTradeProvider.exitMentalStates!)) {
                allOptions.add(addTradeProvider.exitMentalStates!);
              }
              return MultiSelectDropdown(
                label: 'Exit Mental States',
                prefixIcon: Icons.psychology,
                options: allOptions,
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
                .map(
                  (rating) => DropdownMenuItem(
                    value: rating,
                    child: Row(
                      children: [
                        Text('$rating '),
                        ...List.generate(
                          rating,
                          (index) => const Icon(Icons.star, size: 16),
                        ),
                      ],
                    ),
                  ),
                )
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
            controller: _memoController,
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
    UserDefinedValuesProvider userValuesProvider,
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
              // Include currently selected value in options if it's not already there
              final allOptions = List<String>.from(trackings);
              if (addTradeProvider.trackings != null &&
                  !allOptions.contains(addTradeProvider.trackings!)) {
                allOptions.add(addTradeProvider.trackings!);
              }
              return MultiSelectDropdown(
                label: 'Trackings',
                prefixIcon: Icons.track_changes,
                options: allOptions,
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
              // Include currently selected value in options if it's not already there
              final allOptions = List<String>.from(mistakes);
              if (addTradeProvider.mistakes != null &&
                  !allOptions.contains(addTradeProvider.mistakes!)) {
                allOptions.add(addTradeProvider.mistakes!);
              }
              return MultiSelectDropdown(
                label: 'Mistakes',
                prefixIcon: Icons.error,
                options: allOptions,
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
                    left: (provider.side ?? domain.Side.long) == domain.Side.long ? 0 : null,
        right: (provider.side ?? domain.Side.long) == domain.Side.short ? 0 : null,
            top: 0,
            bottom: 0,
            child: Container(
              width:
                  MediaQuery.of(context).size.width *
                  0.4, // Half width minus padding
              decoration: BoxDecoration(
                color: (provider.side ?? domain.Side.long) == domain.Side.long
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
                  onTap: () => provider.updateSide(domain.Side.long),
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
                              key: ValueKey((provider.side ?? domain.Side.long) == domain.Side.long),
                              color: (provider.side ?? domain.Side.long) == domain.Side.long
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
                              key: ValueKey((provider.side ?? domain.Side.long) == domain.Side.long),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: (provider.side ?? domain.Side.long) == domain.Side.long
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
                  onTap: () => provider.updateSide(domain.Side.short),
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
                              key: ValueKey((provider.side ?? domain.Side.long) == domain.Side.short),
                                                              color: (provider.side ?? domain.Side.long) == domain.Side.short
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
                              key: ValueKey((provider.side ?? domain.Side.long) == domain.Side.short),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: (provider.side ?? domain.Side.long) == domain.Side.short
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
  Future<void> _selectDateTime(
    BuildContext context,
    AddTradeProvider provider,
  ) async {
    try {
      // Use the provider's datetime if available, otherwise use current time
      final DateTime initialDateTime = provider.datetime ?? DateTime.now();
      
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDateTime,
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
      );

      if (!mounted || picked == null) return;

      if (!mounted) return;
      // ignore: use_build_context_synchronously
      final TimeOfDay? time = await showCustomTimePicker(
        // ignore: use_build_context_synchronously
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDateTime),
      );

      if (!mounted || time == null) return;

      final DateTime selectedDateTime = DateTime(
        picked.year,
        picked.month,
        picked.day,
        time.hour,
        time.minute,
      );
      
      if (mounted) {
        provider.updateDatetime(selectedDateTime);
      }
    } catch (e) {
      if (mounted && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error selecting date/time: $e'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }

  // ignore: use_build_context_synchronously
  Future<void> _selectExitDateTime(
    BuildContext context,
    AddTradeProvider provider,
  ) async {
    try {
      // Use the provider's exit datetime if available, otherwise use current time
      final DateTime initialDateTime = provider.exitDatetime ?? DateTime.now();
      
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDateTime,
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
      );

      if (!mounted || picked == null) return;

      if (!mounted) return;
      // ignore: use_build_context_synchronously
      final TimeOfDay? time = await showCustomTimePicker(
        // ignore: use_build_context_synchronously
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDateTime),
      );

      if (!mounted || time == null) return;

      final DateTime selectedDateTime = DateTime(
        picked.year,
        picked.month,
        picked.day,
        time.hour,
        time.minute,
      );
      
      if (mounted) {
        provider.updateExitDatetime(selectedDateTime);
      }
    } catch (e) {
      if (mounted && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error selecting exit date/time: $e'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.help_outline, color: AppTheme.primaryColor, size: 24),
            const SizedBox(width: 8),
            const Text('How to Add a Trade'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Welcome section
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppTheme.primaryColor.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: AppTheme.primaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Welcome to TradeMate! Follow this guide to add your first trade.',
                        style: AppTheme.bodyStyle.copyWith(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Required Fields section
              Text(
                '📋 Required Fields',
                style: AppTheme.subheadingStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              _buildHelpItem(
                'Symbol (Trading Pair)',
                'The asset you\'re trading (e.g., BTC/USDT, ETH/USD)',
              ),
              _buildHelpItem(
                'Entry Price',
                'The price at which you entered the trade',
              ),
              _buildHelpItem(
                'Trade Date & Time',
                'When you opened the position',
              ),
              _buildHelpItem(
                'Position Size',
                'How much you invested (quantity or margin amount)',
              ),
              const SizedBox(height: 16),

              // Optional Fields section
              Text(
                '📝 Optional Fields',
                style: AppTheme.subheadingStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              _buildHelpItem(
                'Exchange',
                'Which platform you used (e.g., Binance, Coinbase)',
              ),
              _buildHelpItem(
                'Strategy',
                'Your trading strategy (e.g., Swing, Scalping, DCA)',
              ),
              _buildHelpItem(
                'Stop Loss & Take Profit',
                'Risk management levels',
              ),
              _buildHelpItem('Mental State', 'How you felt during the trade'),
              _buildHelpItem('Memo & Rating', 'Notes and trade evaluation'),
              const SizedBox(height: 16),

              // Tips section
              Text(
                '💡 Pro Tips',
                style: AppTheme.subheadingStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              _buildHelpItem(
                'Expand/Collapse Sections',
                'Tap section headers to show/hide fields',
              ),
              _buildHelpItem(
                'Custom Values',
                'Type and press "Add" to save new dropdown options',
              ),
              _buildHelpItem(
                'Auto-Save',
                'Your custom values are saved for future trades',
              ),
              _buildHelpItem(
                'Progress Tracking',
                'Watch the progress bar to see completion status',
              ),
              const SizedBox(height: 16),

              // Best Practices section
              Text(
                '🎯 Best Practices',
                style: AppTheme.subheadingStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              _buildHelpItem(
                'Be Consistent',
                'Use the same naming for similar trades',
              ),
              _buildHelpItem(
                'Add Screenshots',
                'Capture entry/exit points for analysis',
              ),
              _buildHelpItem(
                'Rate Your Trades',
                'Evaluate performance to improve',
              ),
              _buildHelpItem(
                'Track Emotions',
                'Monitor mental state for better decision making',
              ),
              const SizedBox(height: 16),

              // Note section
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.warningColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppTheme.warningColor.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppTheme.warningColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'The more data you record, the better your trading analysis will be!',
                        style: AppTheme.captionStyle.copyWith(
                          color: AppTheme.warningColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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

  Widget _buildHelpItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.bodyStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
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




  String _getEntryTypeDisplayName(domain.EntryType type) {
    switch (type) {
      case domain.EntryType.trade:
        return 'Trade';
      case domain.EntryType.marginInOut:
        return 'Margin In/Out';
      case domain.EntryType.ignore:
        return 'Ignore';
      default:
        return 'Unknown';
    }
  }

  Widget _buildSubmitButtonContent(AddTradeProvider provider) {
    switch (provider.status) {
      case AddTradeStatus.loading:
        return Row(
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
            const SizedBox(width: 12),
            Text(
              'Saving Trade...',
              style: AppTheme.bodyStyle.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      case AddTradeStatus.success:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              'Trade Saved Successfully!',
              style: AppTheme.bodyStyle.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      case AddTradeStatus.error:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              'Try Again',
              style: AppTheme.bodyStyle.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      default:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              'Add Trade',
              style: AppTheme.bodyStyle.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
    }
  }
}
