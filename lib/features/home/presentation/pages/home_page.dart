import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/trade_statistics.dart';
import '../provider/home_provider.dart';
import '../widgets/statistics_card.dart';
import '../widgets/account_growth_chart.dart';
import '../../../../core/utils/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Load statistics when page is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().loadStatistics();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TradeMate Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<HomeProvider>().refresh();
            },
          ),
        ],
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          switch (provider.status) {
            case HomeStatus.initial:
            case HomeStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
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
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Growth Chart
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account Growth',
                      style: AppTheme.subheadingStyle,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: AccountGrowthChart(statistics: statistics),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Statistics Grid
            Text(
              'Trading Statistics',
              style: AppTheme.subheadingStyle,
            ),
            const SizedBox(height: 16),
            
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,
              children: [
                StatisticsCard(
                  title: 'Total Trades',
                  value: statistics.totalTrades.toString(),
                  icon: Icons.analytics,
                  color: AppTheme.primaryColor,
                ),
                StatisticsCard(
                  title: 'Win Rate',
                  value: statistics.formattedWinRate,
                  icon: Icons.trending_up,
                  color: AppTheme.successColor,
                ),
                StatisticsCard(
                  title: 'Overall PnL',
                  value: statistics.formattedOverallPnl,
                  icon: Icons.account_balance_wallet,
                  color: statistics.overallPnl >= 0 
                      ? AppTheme.successColor 
                      : AppTheme.errorColor,
                ),
                StatisticsCard(
                  title: 'Avg Achieved R',
                  value: statistics.formattedAvgAchievedR,
                  icon: Icons.speed,
                  color: AppTheme.primaryColor,
                ),
                StatisticsCard(
                  title: 'Open Positions',
                  value: statistics.openPositions.toString(),
                  icon: Icons.open_in_new,
                  color: AppTheme.warningColor,
                ),
                StatisticsCard(
                  title: 'Account Balance',
                  value: statistics.formattedCurrentAccountBalance,
                  icon: Icons.account_balance,
                  color: AppTheme.primaryColor,
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Detailed Statistics
            Text(
              'Detailed Statistics',
              style: AppTheme.subheadingStyle,
            ),
            const SizedBox(height: 16),
            
            _buildDetailedStatistics(statistics),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedStatistics(TradeStatistics statistics) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildStatRow('Winning Trades', statistics.winningTrades.toString()),
            _buildStatRow('Losing Trades', statistics.losingTrades.toString()),
            _buildStatRow('Breakeven Trades', statistics.breakevenTrades.toString()),
            _buildStatRow('Loss Rate', statistics.formattedLossRate),
            _buildStatRow('Breakeven Rate', statistics.formattedBreakevenRate),
            _buildStatRow('Profit Factor', statistics.formattedProfitFactor),
            _buildStatRow('Avg Trade Duration', statistics.formattedAvgTradeDuration),
            _buildStatRow('Avg PnL', statistics.formattedAvgPnl),
            _buildStatRow('Total Deposits', statistics.formattedTotalDeposits),
            _buildStatRow('Total Withdrawals', statistics.formattedTotalWithdrawals),
            _buildStatRow('Account Growth', statistics.formattedTotalAccountGrowth),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTheme.bodyStyle,
          ),
          Text(
            value,
            style: AppTheme.numberStyle,
          ),
        ],
      ),
    );
  }
}
