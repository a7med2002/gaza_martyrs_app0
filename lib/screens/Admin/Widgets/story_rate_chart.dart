import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/config/colors.dart';
import 'package:get/get.dart';

class StoryRateChart extends StatelessWidget {
  const StoryRateChart({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 460,
      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 48),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("storyRate".tr,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Row(
                children: [
                  Indicator(color: Colors.green, text: "successStory".tr),
                  SizedBox(width: 24),
                  Indicator(color: Colors.red, text: "declineStory".tr),
                ],
              )
            ],
          ),
          SizedBox(height: 32),
          SizedBox(
            height: 300,
            child: LineChart(
              LineChartData(
                borderData: FlBorderData(
                    border: Border.all(color: Colors.grey.withOpacity(0.3))),
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  drawVerticalLine: true, // إذا بدك تبقي الخطوط العمودية
                  verticalInterval: 1, // ✅ خلي بين كل خط وخط قيمة 1 (كل نقطة)
                  getDrawingVerticalLine: (value) => FlLine(
                    color: Colors.grey.withOpacity(0.2),
                    strokeWidth: 1,
                  ),
                  horizontalInterval: 150,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey.withOpacity(0.2),
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 150,
                      getTitlesWidget: (value, _) => Text(
                        value.toInt().toString(),
                        style: TextStyle(color: lSecondaryColor, fontSize: 12),
                      ),
                    ),
                  ),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const months = [
                          '',
                          'Jan',
                          'Feb',
                          'Mar',
                          'Apr',
                          'May',
                          'Jun',
                          'Jul',
                          'Aug',
                          'Sep',
                          'Oct',
                          'Nov',
                          'Dec'
                        ];
                        return Text(months[value.toInt()], style: TextStyle(color: lSecondaryColor));
                      },
                      interval: 1,
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 500),
                      FlSpot(1, 300),
                      FlSpot(2, 500),
                      FlSpot(3, 400),
                      FlSpot(4, 500),
                      FlSpot(5, 200),
                      FlSpot(6, 600),
                      FlSpot(7, 0),
                      FlSpot(8, 750),
                      FlSpot(9, 450),
                      FlSpot(10, 600),
                      FlSpot(11, 400),
                    ],
                    isCurved: false,
                    color: Colors.green,
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(show: false),
                  ),
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 900),
                      FlSpot(1, 500),
                      FlSpot(2, 600),
                      FlSpot(3, 550),
                      FlSpot(4, 500),
                      FlSpot(5, 300),
                      FlSpot(6, 400),
                      FlSpot(7, 100),
                      FlSpot(8, 500),
                      FlSpot(9, 300),
                      FlSpot(10, 500),
                      FlSpot(11, 800),
                    ],
                    isCurved: false,
                    color: Colors.red,
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  const Indicator({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 6, backgroundColor: color),
        SizedBox(width: 8),
        Text(text, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}