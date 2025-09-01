import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/trade_statistics.dart';
import '../provider/home_provider.dart';
import '../../../account_management/presentation/widgets/balance_card.dart';
import '../../../account_management/presentation/widgets/quick_actions.dart';
import '../../../account_management/presentation/widgets/transaction_list.dart';
import '../../../account_management/domain/entities/transaction.dart';
import '../../../account_management/presentation/pages/transaction_history_page.dart';
import '../../../account_management/presentation/provider/account_provider.dart';

import '../widgets/account_growth_chart.dart';
import '../../../../core/utils/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Statistics are already loaded in MainNavigationPage
  // No need to load them again here

  @override
  void initState() {
    super.initState();
    // Load account data when page is opened
    context.read<AccountProvider>().loadAccountData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TradeMate',
          style: AppTheme.subheadingStyle.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, size: 20),
            onPressed: () {
              context.read<HomeProvider>().refresh();
            },
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          switch (provider.status) {
            case HomeStatus.initial:
            case HomeStatus.loading:
              return const Center(
                child: CircularProgressIndicator(
                  color: AppTheme.primaryColor,
                  strokeWidth: 2,
                ),
              );
            
            case HomeStatus.error:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: AppTheme.errorColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error loading statistics',
                      style: AppTheme.subheadingStyle,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      provider.errorMessage,
                      style: AppTheme.captionStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => provider.refresh(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            
            case HomeStatus.loaded:
              final statistics = provider.statistics!;
              return _buildDashboard(statistics);
          }
        },
      ),
    );
  }

  Widget _buildDashboard(TradeStatistics statistics) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeProvider>().refresh();
        context.read<AccountProvider>().loadAccountData();
      },
      color: AppTheme.primaryColor,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Balance Card
            Consumer<AccountProvider>(
              builder: (context, accountProvider, child) {
                if (accountProvider.status == AccountStatus.loaded && accountProvider.balance != null) {
                  return BalanceCard(balance: accountProvider.balance!);
                }
                return const SizedBox.shrink();
              },
            ),
            
            const SizedBox(height: 12),
            
            // Quick Actions
            Consumer<AccountProvider>(
              builder: (context, accountProvider, child) {
                if (accountProvider.status == AccountStatus.loaded) {
                  return QuickActions(
                    onDeposit: () => _showDepositDialog(context),
                    onWithdraw: () => _showWithdrawalDialog(context),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            
            const SizedBox(height: 12),
            
            // Account Growth Chart
            Container(
              decoration: AppTheme.cardDecoration,
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                height: 240,
                child: AccountGrowthChart(statistics: statistics),
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Statistics Overview
            Container(
              decoration: AppTheme.cardDecoration,
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.bar_chart_rounded,
                        size: 16,
                        color: AppTheme.textSecondaryColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Overview',
                        style: AppTheme.labelStyle.copyWith(
                          color: AppTheme.textSecondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildQuickStats(statistics),
                ],
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Detailed Statistics
            Container(
              decoration: AppTheme.cardDecoration,
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.table_chart_rounded,
                        size: 16,
                        color: AppTheme.textSecondaryColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Performance',
                        style: AppTheme.labelStyle.copyWith(
                          color: AppTheme.textSecondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildDetailedStatistics(statistics),
                ],
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Recent Transactions
            Consumer<AccountProvider>(
              builder: (context, accountProvider, child) {
                if (accountProvider.status == AccountStatus.loaded) {
                  return Container(
                    decoration: AppTheme.cardDecoration,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.receipt_long_rounded,
                              size: 16,
                              color: AppTheme.textSecondaryColor,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Recent Transactions',
                              style: AppTheme.labelStyle.copyWith(
                                color: AppTheme.textSecondaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () => _showTransactionHistory(context),
                              child: const Text('View All'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        TransactionList(
                          transactions: accountProvider.transactions,
                          showAll: false,
                          showDeleteButton: false,
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats(TradeStatistics statistics) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: _buildQuickStatItem(
            'Total P&L',
            statistics.formattedOverallPnl,
            statistics.overallPnl >= 0 ? AppTheme.bullishColor : AppTheme.bearishColor,
          ),
        ),
        Expanded(
          child: _buildQuickStatItem(
            'Win Rate',
            statistics.formattedWinRate,
            statistics.winRate >= 50 ? AppTheme.bullishColor : AppTheme.bearishColor,
          ),
        ),
        Expanded(
          child: _buildQuickStatItem(
            'Avg R',
            statistics.avgAchievedR > 0 ? '${statistics.avgAchievedR.toStringAsFixed(2)}x' : 'N/A',
            AppTheme.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStatItem(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: AppTheme.captionStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTheme.priceStyle.copyWith(color: color),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDetailedStatistics(TradeStatistics statistics) {
    return Column(
      children: [
        _buildStatRow('Total Trades', statistics.totalTrades.toString(), null),
        _buildStatRow('Winning Trades', statistics.winningTrades.toString(), AppTheme.bullishColor),
        _buildStatRow('Losing Trades', statistics.losingTrades.toString(), AppTheme.bearishColor),
        _buildStatRow('Breakeven Trades', statistics.breakevenTrades.toString(), AppTheme.textSecondaryColor),
        const Divider(height: 16),
        _buildStatRow('Avg R Multiple', statistics.formattedAvgAchievedR, null),
        _buildStatRow('Profit Factor', statistics.formattedProfitFactor, null),
        _buildStatRow('Avg Duration', statistics.formattedAvgTradeDuration, null),
        const Divider(height: 16),
        _buildStatRow('Total Deposits', statistics.formattedTotalDeposits, AppTheme.bullishColor),
        _buildStatRow('Total Withdrawals', statistics.formattedTotalWithdrawals, AppTheme.bearishColor),
        _buildStatRow('Account Growth', statistics.formattedTotalAccountGrowth, 
            statistics.totalAccountGrowth >= 0 ? AppTheme.bullishColor : AppTheme.bearishColor),
      ],
    );
  }

  Widget _buildStatRow(String label, String value, Color? valueColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTheme.captionStyle,
          ),
          Text(
            value,
            style: AppTheme.bodyStyle.copyWith(
              color: valueColor ?? AppTheme.textPrimaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showDepositDialog(BuildContext context) {
    final accountProvider = context.read<AccountProvider>();
    double? currentBalance;
    if (accountProvider.status == AccountStatus.loaded && accountProvider.balance != null) {
      currentBalance = accountProvider.balance!.balance;
    }
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _TransactionDialog(
        type: TransactionType.deposit,
        currentBalance: currentBalance,
        onConfirm: (amount, note) {
          accountProvider.addToBalance(amount, note);
        },
      ),
    );
  }

  void _showWithdrawalDialog(BuildContext context) {
    final accountProvider = context.read<AccountProvider>();
    double? currentBalance;
    if (accountProvider.status == AccountStatus.loaded && accountProvider.balance != null) {
      currentBalance = accountProvider.balance!.balance;
    }
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _TransactionDialog(
        type: TransactionType.withdrawal,
        currentBalance: currentBalance,
        onConfirm: (amount, note) {
          accountProvider.addToBalance(-amount, note); // Negative for withdrawal
        },
      ),
    );
  }

  void _showTransactionHistory(BuildContext context) {
    final accountProvider = context.read<AccountProvider>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TransactionHistoryPage(),
      ),
    ).then((_) {
      // Reload account data when returning from transaction history
      accountProvider.loadAccountData();
    });
  }
}

class _TransactionDialog extends StatefulWidget {
  final TransactionType type;
  final Function(double amount, String? note) onConfirm;
  final double? currentBalance;

  const _TransactionDialog({
    required this.type,
    required this.onConfirm,
    this.currentBalance,
  });

  @override
  State<_TransactionDialog> createState() => _TransactionDialogState();
}

class _TransactionDialogState extends State<_TransactionDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Add listener to update button state when amount changes
    _amountController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  bool _isValidAmount() {
    if (_amountController.text.isEmpty) return false;
    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) return false;
    
    // Check if withdrawal amount exceeds available balance
    if (widget.type == TransactionType.withdrawal && 
        widget.currentBalance != null && 
        amount > widget.currentBalance!) {
      return false;
    }
    
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final isDeposit = widget.type == TransactionType.deposit;
    final title = isDeposit ? 'Deposit' : 'Withdrawal';
    final icon = isDeposit ? Icons.add_circle : Icons.remove_circle;
    final color = isDeposit ? AppTheme.bullishColor : AppTheme.bearishColor;

    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: AppTheme.subheadingStyle.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                prefixText: '\$',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                helperText: widget.type == TransactionType.withdrawal && widget.currentBalance != null
                    ? 'Available balance: \$${widget.currentBalance!.toStringAsFixed(2)}'
                    : null,
                helperStyle: TextStyle(
                  color: AppTheme.textSecondaryColor,
                  fontSize: 12,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter amount';
                }
                final amount = double.tryParse(value);
                if (amount == null || amount <= 0) {
                  return 'Please enter a valid amount';
                }
                
                // Check if withdrawal amount exceeds available balance
                if (widget.type == TransactionType.withdrawal && 
                    widget.currentBalance != null && 
                    amount > widget.currentBalance!) {
                  return 'Amount exceeds available balance (\$${widget.currentBalance!.toStringAsFixed(2)})';
                }
                
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'Note (Optional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            StatefulBuilder(
              builder: (context, setState) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isValidAmount() ? () {
                      if (_formKey.currentState!.validate()) {
                        final amount = double.parse(_amountController.text);
                        final note = _noteController.text.isEmpty 
                            ? null 
                            : _noteController.text;
                        
                        widget.onConfirm(amount, note);
                        Navigator.pop(context);
                      }
                    } : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isValidAmount() ? color : AppTheme.textSecondaryColor.withValues(alpha: 0.3),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('Confirm $title'),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
