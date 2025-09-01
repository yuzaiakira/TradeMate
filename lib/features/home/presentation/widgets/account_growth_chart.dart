import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../domain/entities/trade_statistics.dart';
import '../../../../core/utils/app_theme.dart';

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
  final PageController _pageController = PageController();
  int _currentYearIndex = 0;
  
  // Fake data for different years
  final List<Map<String, dynamic>> _yearlyData = [
    {
      'year': 2025,
      'data': [
        {'month': 'Jan', 'balance': 10000.0},
        {'month': 'Feb', 'balance': 10500.0},
        {'month': 'Mar', 'balance': 11200.0},
        {'month': 'Apr', 'balance': 10800.0},
        {'month': 'May', 'balance': 11800.0},
        {'month': 'Jun', 'balance': 12500.0},
        {'month': 'Jul', 'balance': 13200.0},
        {'month': 'Aug', 'balance': 12800.0},
        {'month': 'Sep', 'balance': 13500.0},
        {'month': 'Oct', 'balance': 14200.0},
        {'month': 'Nov', 'balance': 14800.0},
        {'month': 'Dec', 'balance': 15500.0},
      ],
    },
    {
      'year': 2024,
      'data': [
        {'month': 'Jan', 'balance': 15500.0},
        {'month': 'Feb', 'balance': 16200.0},
        {'month': 'Mar', 'balance': 15800.0},
        {'month': 'Apr', 'balance': 16500.0},
        {'month': 'May', 'balance': 17200.0},
        {'month': 'Jun', 'balance': 17800.0},
        {'month': 'Jul', 'balance': 18500.0},
        {'month': 'Aug', 'balance': 19200.0},
        {'month': 'Sep', 'balance': 19800.0},
        {'month': 'Oct', 'balance': 20500.0},
        {'month': 'Nov', 'balance': 21200.0},
        {'month': 'Dec', 'balance': 19200.0},
      ],
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<FlSpot> _generateChartData(int yearIndex) {
    final yearData = _yearlyData[yearIndex]['data'] as List<Map<String, dynamic>>;
    final spots = <FlSpot>[];
    
    for (int i = 0; i < yearData.length; i++) {
      spots.add(FlSpot(i.toDouble(), yearData[i]['balance'] as double));
    }
    
    return spots;
  }

  String _getMonthLabel(int index) {
    final yearData = _yearlyData[_currentYearIndex]['data'] as List<Map<String, dynamic>>;
    if (index >= 0 && index < yearData.length) {
      return yearData[index]['month'] as String;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Chart Header with Year Navigation
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Account Growth',
              style: AppTheme.subheadingStyle,
            ),
            Row(
              children: [
                // Year indicator
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.borderColor),
                  ),
                  child: Text(
                    '${_yearlyData[_currentYearIndex]['year']}',
                    style: AppTheme.captionStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Navigation arrows
                Row(
                  children: [
                    IconButton(
                      onPressed: _currentYearIndex > 0
                          ? () {
                              setState(() {
                                _currentYearIndex--;
                              });
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          : null,
                      icon: Icon(
                        Icons.chevron_left,
                        color: _currentYearIndex > 0
                            ? AppTheme.primaryColor
                            : AppTheme.textSecondaryColor,
                      ),
                      tooltip: 'Previous Year',
                    ),
                    IconButton(
                      onPressed: _currentYearIndex < _yearlyData.length - 1
                          ? () {
                              setState(() {
                                _currentYearIndex++;
                              });
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          : null,
                      icon: Icon(
                        Icons.chevron_right,
                        color: _currentYearIndex < _yearlyData.length - 1
                            ? AppTheme.primaryColor
                            : AppTheme.textSecondaryColor,
                      ),
                      tooltip: 'Next Year',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Chart Content with PageView - Responsive height
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentYearIndex = index;
              });
            },
            itemCount: _yearlyData.length,
            itemBuilder: (context, index) {
              return _buildChartPage(index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildChartPage(int yearIndex) {
    final chartData = _generateChartData(yearIndex);
    final year = _yearlyData[yearIndex]['year'] as int;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Year title
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            'Account Growth - $year',
            style: AppTheme.labelStyle.copyWith(
              color: AppTheme.textSecondaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        // Chart
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 200,
                maxHeight: 350,
              ),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: _getHorizontalInterval(chartData),
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: AppTheme.borderColor.withValues(alpha: 0.2),
                      strokeWidth: 0.5,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: AppTheme.borderColor.withValues(alpha: 0.1),
                      strokeWidth: 0.5,
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
                        if (value.toInt() >= 0 && value.toInt() < 12) {
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                _getMonthLabel(value.toInt()),
                                style: TextStyle(
                                  color: AppTheme.textSecondaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: _getVerticalInterval(chartData),
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Text(
                              '\$${value.toInt()}',
                              style: TextStyle(
                                color: AppTheme.textSecondaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        );
                      },
                      reservedSize: 80, // Increased reserved size for better spacing
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                minX: 0,
                maxX: 11,
                minY: _getMinY(chartData),
                maxY: _getMaxY(chartData),
                lineBarsData: [
                  LineChartBarData(
                    spots: chartData,
                    isCurved: true,
                    curveSmoothness: 0.35,
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.primaryColor,
                        AppTheme.primaryColor.withValues(alpha: 0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    barWidth: 2.5,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: false, // No dots for TradingView style
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primaryColor.withValues(alpha: 0.15),
                          AppTheme.primaryColor.withValues(alpha: 0.05),
                          Colors.transparent,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(
                  enabled: true,
                  touchSpotThreshold: 20,
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: AppTheme.cardColor,
                    tooltipRoundedRadius: 8,
                    tooltipPadding: const EdgeInsets.all(12),
                    tooltipMargin: 8,
                    tooltipBorder: BorderSide(
                      color: AppTheme.borderColor.withValues(alpha: 0.3),
                      width: 1,
                    ),
                    getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                      return touchedBarSpots.map((barSpot) {
                        final month = _getMonthLabel(barSpot.x.toInt());
                        return LineTooltipItem(
                          '$month: \$${barSpot.y.toStringAsFixed(0)}',
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
            ),
          ),
        ),
        )],
    );
  }

  double _getHorizontalInterval(List<FlSpot> chartData) {
    if (chartData.isEmpty) return 1000;
    final maxY = chartData.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
    final minY = chartData.map((spot) => spot.y).reduce((a, b) => a < b ? a : b);
    final range = maxY - minY;
    
    // Improved horizontal grid spacing for better readability
    if (range <= 2000) return 500;
    if (range <= 5000) return 1000;
    if (range <= 10000) return 2000;
    if (range <= 20000) return 3000;
    return 5000;
  }

  double _getVerticalInterval(List<FlSpot> chartData) {
    if (chartData.isEmpty) return 1000;
    final maxY = chartData.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
    final minY = chartData.map((spot) => spot.y).reduce((a, b) => a < b ? a : b);
    final range = maxY - minY;
    
    // Improved spacing for better readability
    if (range <= 2000) return 500;
    if (range <= 5000) return 1000;
    if (range <= 10000) return 2000;
    if (range <= 20000) return 3000;
    return 5000;
  }

  double _getMinY(List<FlSpot> chartData) {
    if (chartData.isEmpty) return 0;
    final minY = chartData.map((spot) => spot.y).reduce((a, b) => a < b ? a : b);
    return minY * 0.9; // Add 10% padding for better spacing
  }

  double _getMaxY(List<FlSpot> chartData) {
    if (chartData.isEmpty) return 10000;
    final maxY = chartData.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
    return maxY * 1.1; // Add 10% padding for better spacing
  }
}
