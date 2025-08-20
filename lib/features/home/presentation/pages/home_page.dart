import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/trade_statistics.dart';
import '../provider/home_provider.dart';
import '../widgets/statistics_card.dart';
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
      },
      color: AppTheme.primaryColor,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats(TradeStatistics statistics) {
    return Row(
      children: [
        Expanded(
          child: _buildQuickStatItem(
            'Total P&L',
            statistics.formattedOverallPnl,
            statistics.overallPnl >= 0 ? AppTheme.bullishColor : AppTheme.bearishColor,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildQuickStatItem(
            'Win Rate',
            statistics.formattedWinRate,
            statistics.winRate >= 50 ? AppTheme.bullishColor : AppTheme.bearishColor,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildQuickStatItem(
            'Balance',
            statistics.formattedCurrentAccountBalance,
            AppTheme.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStatItem(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.captionStyle,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTheme.priceStyle.copyWith(color: color),
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
}
