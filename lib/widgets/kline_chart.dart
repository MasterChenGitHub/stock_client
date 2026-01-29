import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/kline_model.dart';

class KLineChart extends StatelessWidget {
  final List<KLine> klines;
  KLineChart({required this.klines});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: klines.asMap().entries.map((e) => FlSpot(
                  e.key.toDouble(), e.value.close)).toList(),
              isCurved: false,
              color: Colors.blue,
              barWidth: 1,
            ),
          ],
          titlesData: FlTitlesData(show: false),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}
