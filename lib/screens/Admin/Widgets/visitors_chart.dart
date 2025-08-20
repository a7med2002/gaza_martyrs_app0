import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/config/colors.dart';
import 'package:get/get.dart';

class VisitorsChart extends StatelessWidget {
  const VisitorsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        height: 460,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Tabs
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "visitors".tr,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 42),
                    Expanded(
                      child: TabBar(
                        labelColor: Theme.of(context).colorScheme.primary,
                        unselectedLabelColor: Theme.of(context).colorScheme.secondary,
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        indicatorColor: Theme.of(context).colorScheme.primary,
                        indicatorSize: TabBarIndicatorSize.label,
                        dividerColor: Colors.transparent,
                        labelPadding: const EdgeInsets.only(right: 2),
                        tabs: [
                          Tab(child: Text("weeks".tr)),
                          Tab(child: Text("monthly".tr)),
                          Tab(child: Text("years".tr)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 330,
                  child: TabBarView(
                    children: [
                      _buildChart(),
                      _buildChart(),
                      _buildChart(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChart() {
    return SizedBox(
      height: 330,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 12000,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 2000,
                getTitlesWidget: (value, _) {
                  if (value == 0) {
                    return const Text("0", style: TextStyle(color: lSecondaryColor));
                  }
                  if (value == 500) {
                    return const Text("0.5k", style: TextStyle(color: lSecondaryColor));
                  }
                  return Text("${(value ~/ 1000)}k", style: const TextStyle(color: lSecondaryColor));
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  const days = ["Sat", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri"];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(days[value.toInt()], style: const TextStyle(color: lSecondaryColor)),
                  );
                },
              ),
            ),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: [
            _buildBar(0, 8000, 12000),
            _buildBar(1, 6000, 12000),
            _buildBar(2, 7000, 12000),
            _buildBar(3, 2000, 12000),
            _buildBar(4, 4000, 12000),
            _buildBar(5, 9000, 12000),
            _buildBar(6, 10500, 12000),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _buildBar(int x, double current, double total) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: total,
          color: Colors.grey.withOpacity(0.2),
          width: 18,
          borderRadius: BorderRadius.circular(8),
          rodStackItems: [
            BarChartRodStackItem(0, current, lPrimaryColor.withOpacity(0.7)),
          ],
        ),
      ],
    );
  }
}