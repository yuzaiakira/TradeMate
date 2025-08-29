import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/trade_statistics.dart';
import '../../../../core/utils/app_theme.dart';
import '../../../../core/data/database.dart';

class AccountGrowthChart extends StatefulWidget {
  final TradeStatistics statistics;

  const AccountGrowthChart({
    super.key,
    required this.statistics,
  });

  @override
  State<AccountGrowthChart> createState() => _AccountGrowthChartState();
}

class _AccountGrowthChartState extends State<AccountGrowthChart> {
  List<FlSpot> _chartData = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadChartData();
  }

  Future<void> _loadChartData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      final database = context.read<TradeMateDatabase>();
      final chartData = await _generateRealChartData(database);
      
      setState(() {
        _chartData = chartData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load chart data: $e';
        _isLoading = false;
      });
    }
  }

  Future<List<FlSpot>> _generateRealChartData(TradeMateDatabase database) async {
    final List<FlSpot> spots = [];
    
    try {
      // Get all trades ordered by date
      final allTrades = await database.getAllTrades();
      final transactions = await database.getAllTransactions();
      
      if (allTrades.isEmpty && transactions.isEmpty) {
        // No data available, show a flat line at current balance
        return [
          FlSpot(0, widget.statistics.currentAccountBalance),
          FlSpot(1, widget.statistics.currentAccountBalance),
        ];
      }

      // Combine trades and transactions into a single timeline
      final events = <MapEntry<DateTime, double>>[];
      
      // Add trades
      for (final trade in allTrades) {
        final pnl = trade.pnl ?? 0.0;
        events.add(MapEntry(trade.entryDate, pnl));
        
        if (trade.exitDate != null) {
          events.add(MapEntry(trade.exitDate!, pnl));
        }
      }
      
      // Add transactions
      for (final transaction in transactions) {
        final amount = transaction.type == 'DEPOSIT' ? transaction.amount : -transaction.amount;
        events.add(MapEntry(transaction.datetime, amount));
      }
      
      // Sort events by date
      events.sort((a, b) => a.key.compareTo(b.key));
      
      // Calculate cumulative balance
      double currentBalance = 0.0;
      final Map<DateTime, double> balanceHistory = {};
      
      for (final event in events) {
        currentBalance += event.value;
        balanceHistory[event.key] = currentBalance;
      }
      
      // Convert to chart data points
      final sortedDates = balanceHistory.keys.toList()..sort();
      
      if (sortedDates.isEmpty) {
        // Fallback to current balance
        return [
          FlSpot(0, widget.statistics.currentAccountBalance),
          FlSpot(1, widget.statistics.currentAccountBalance),
        ];
      }
      
      // Normalize dates to chart coordinates (0 to 1)
      final firstDate = sortedDates.first;
      final lastDate = sortedDates.last;
      final totalDays = lastDate.difference(firstDate).inDays;
      
      for (int i = 0; i < sortedDates.length; i++) {
        final date = sortedDates[i];
        final daysFromStart = date.difference(firstDate).inDays;
        final x = totalDays > 0 ? daysFromStart / totalDays : 0.0;
        final y = balanceHistory[date]!;
        spots.add(FlSpot(x, y));
      }
      
      // Add current balance point if not already included
      if (spots.isNotEmpty) {
        final lastSpot = spots.last;
        if (lastSpot.y != widget.statistics.currentAccountBalance) {
          spots.add(FlSpot(1.0, widget.statistics.currentAccountBalance));
        }
      }
      
      return spots;
    } catch (e) {
      // Fallback to sample data if there's an error
      return _generateSampleData();
    }
  }

  List<FlSpot> _generateSampleData() {
    // Fallback sample data based on current account balance
    final baseBalance = widget.statistics.currentAccountBalance;
    final growth = widget.statistics.totalAccountGrowth;
    
    final spots = <FlSpot>[];
    double currentBalance = baseBalance - growth; // Starting balance
    
    for (int i = 0; i <= 5; i++) {
      final variation = (i * growth / 5) + (i * 100 * (i % 2 == 0 ? 1 : -1));
      currentBalance = baseBalance - growth + variation;
      spots.add(FlSpot(i.toDouble(), currentBalance));
    }
    
    return spots;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Chart Header with Refresh Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Account Growth',
              style: AppTheme.subheadingStyle,
            ),
            IconButton(
              onPressed: _isLoading ? null : _loadChartData,
              icon: _isLoading 
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.refresh),
              tooltip: 'Refresh chart data',
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Chart Content
        Expanded(
          child: _buildChartContent(),
        ),
      ],
    );
  }

  Widget _buildChartContent() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: AppTheme.errorColor,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              'Chart Error',
              style: AppTheme.captionStyle.copyWith(
                color: AppTheme.errorColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _errorMessage,
              style: AppTheme.captionStyle.copyWith(
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: _loadChartData,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_chartData.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.show_chart,
              color: AppTheme.textSecondaryColor,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              'No Data Available',
              style: AppTheme.captionStyle.copyWith(
                color: AppTheme.textSecondaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Add some trades to see your account growth',
              style: AppTheme.captionStyle.copyWith(
                fontSize: 10,
                color: AppTheme.textSecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: _getHorizontalInterval(),
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: AppTheme.borderColor.withValues(alpha: 0.3),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: _getBottomInterval(),
              getTitlesWidget: (double value, TitleMeta meta) {
                const style = TextStyle(
                  color: AppTheme.textSecondaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                );
                
                String label;
                if (value == 0) {
                  label = 'Start';
                } else if (value == 1) {
                  label = 'Now';
                } else {
                  label = '${(value * 100).toInt()}%';
                }
                
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(label, style: style),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: _getVerticalInterval(),
              getTitlesWidget: (double value, TitleMeta meta) {
                const style = TextStyle(
                  color: AppTheme.textSecondaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                );
                return Text(
                  '\$${value.toInt()}',
                  style: style,
                );
              },
              reservedSize: 50,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(
            color: AppTheme.borderColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        minX: 0,
        maxX: 1,
        minY: _getMinY(),
        maxY: _getMaxY(),
        lineBarsData: [
          LineChartBarData(
            spots: _chartData,
            isCurved: true,
            gradient: LinearGradient(
              colors: [
                AppTheme.primaryColor.withValues(alpha: 0.8),
                AppTheme.primaryColor.withValues(alpha: 0.3),
              ],
            ),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: _chartData.length <= 10, // Only show dots if not too many points
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 3,
                  color: AppTheme.primaryColor,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryColor.withValues(alpha: 0.2),
                  AppTheme.primaryColor.withValues(alpha: 0.05),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: AppTheme.cardColor,
            tooltipRoundedRadius: 8,
            tooltipPadding: const EdgeInsets.all(8),
            tooltipMargin: 8,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                return LineTooltipItem(
                  'Balance: \$${barSpot.y.toStringAsFixed(2)}',
                  const TextStyle(
                    color: AppTheme.textPrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }

  double _getHorizontalInterval() {
    if (_chartData.isEmpty) return 1000;
    final maxY = _chartData.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
    final minY = _chartData.map((spot) => spot.y).reduce((a, b) => a < b ? a : b);
    final range = maxY - minY;
    if (range <= 100) return 25;
    if (range <= 500) return 100;
    if (range <= 1000) return 200;
    if (range <= 5000) return 1000;
    return 2000;
  }

  double _getVerticalInterval() {
    if (_chartData.isEmpty) return 1000;
    final maxY = _chartData.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
    final minY = _chartData.map((spot) => spot.y).reduce((a, b) => a < b ? a : b);
    final range = maxY - minY;
    if (range <= 100) return 25;
    if (range <= 500) return 100;
    if (range <= 1000) return 200;
    if (range <= 5000) return 1000;
    return 2000;
  }

  double _getBottomInterval() {
    if (_chartData.length <= 3) return 0.5;
    if (_chartData.length <= 6) return 0.25;
    return 0.2;
  }

  double _getMinY() {
    if (_chartData.isEmpty) return 0;
    final minY = _chartData.map((spot) => spot.y).reduce((a, b) => a < b ? a : b);
    return minY * 0.95; // Add 5% padding
  }

  double _getMaxY() {
    if (_chartData.isEmpty) return 10000;
    final maxY = _chartData.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
    return maxY * 1.05; // Add 5% padding
  }
}
