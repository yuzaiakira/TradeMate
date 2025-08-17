import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../domain/entities/trade_statistics.dart';
import '../../../../core/utils/app_theme.dart';

class AccountGrowthChart extends StatelessWidget {
  final TradeStatistics statistics;

  const AccountGrowthChart({
    Key? key,
    required this.statistics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // For now, we'll create a simple line chart showing account balance
    // In a real app, you'd want to show actual trade data over time
    final spots = _generateSampleData();
    
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 1000,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: AppTheme.borderColor,
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: AppTheme.borderColor,
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
              interval: 1,
              getTitlesWidget: (double value, TitleMeta meta) {
                const style = TextStyle(
                  color: AppTheme.textSecondaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                );
                Widget text;
                switch (value.toInt()) {
                  case 0:
                    text = const Text('Jan', style: style);
                    break;
                  case 1:
                    text = const Text('Feb', style: style);
                    break;
                  case 2:
                    text = const Text('Mar', style: style);
                    break;
                  case 3:
                    text = const Text('Apr', style: style);
                    break;
                  case 4:
                    text = const Text('May', style: style);
                    break;
                  case 5:
                    text = const Text('Jun', style: style);
                    break;
                  default:
                    text = const Text('', style: style);
                    break;
                }
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: text,
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1000,
              getTitlesWidget: (double value, TitleMeta meta) {
                const style = TextStyle(
                  color: AppTheme.textSecondaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                );
                return Text(
                  '\$${value.toInt()}',
                  style: style,
                );
              },
              reservedSize: 42,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: AppTheme.borderColor),
        ),
        minX: 0,
        maxX: 5,
        minY: 0,
        maxY: _getMaxY(spots),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            gradient: LinearGradient(
              colors: [
                AppTheme.primaryColor.withOpacity(0.8),
                AppTheme.primaryColor.withOpacity(0.3),
              ],
            ),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
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
                  AppTheme.primaryColor.withOpacity(0.3),
                  AppTheme.primaryColor.withOpacity(0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<FlSpot> _generateSampleData() {
    // Generate sample data based on current account balance
    final baseBalance = statistics.currentAccountBalance;
    final growth = statistics.totalAccountGrowth;
    
    // Create a realistic growth pattern
    final spots = <FlSpot>[];
    double currentBalance = baseBalance - growth; // Starting balance
    
    for (int i = 0; i <= 5; i++) {
      // Add some random variation to make it look realistic
      final variation = (i * growth / 5) + (i * 100 * (i % 2 == 0 ? 1 : -1));
      currentBalance = baseBalance - growth + variation;
      spots.add(FlSpot(i.toDouble(), currentBalance));
    }
    
    return spots;
  }

  double _getMaxY(List<FlSpot> spots) {
    if (spots.isEmpty) return 10000;
    final maxY = spots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
    return maxY * 1.1; // Add 10% padding
  }
}
