import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

import 'legend_widget.dart';

// Credit: https://dribbble.com/shots/10072126-Heeded-Dashboard

class BarChartSample6 extends StatefulWidget {
  const BarChartSample6({super.key});

  @override
  State<BarChartSample6> createState() => _BarChartSample6State();
}

class _BarChartSample6State extends State<BarChartSample6> {
  static const pilateColor = Color(0xff632af2);
  static const cyclingColor = Color(0xffffb3ba);
  static const quickWorkoutColor = Color(0xff578eff);
  static const betweenSpace = 0.2;
  DateTime dateTime = DateTime.now();
  SelectDate() async {
    DateTime? newDateTime = await showRoundedDatePicker(
      initialDatePickerMode: DatePickerMode.year,
      era: EraMode.CHRIST_YEAR,
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      borderRadius: 16,
      /*imageHeader: const AssetImage(
                              "assets/images/bazin4.jpg",
                            ),*/
      height: 300,
      context: context,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      description: "Selectionner l'année'",
    );
    if (newDateTime != null) {
      dateTime = newDateTime;
    }
  }

  BarChartGroupData generateGroupData(
      int x, double pilates, double quickWorkout, double cycling) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: pilates,
          color: pilateColor,
          width: 5,
        ),
        BarChartRodData(
          fromY: pilates + betweenSpace,
          toY: pilates + betweenSpace + quickWorkout,
          color: quickWorkoutColor,
          width: 5,
        ),
        BarChartRodData(
          fromY: pilates + betweenSpace + quickWorkout + betweenSpace,
          toY: pilates + betweenSpace + quickWorkout + betweenSpace + cycling,
          color: cyclingColor,
          width: 5,
        ),
      ],
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff787694),
      fontSize: 10,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = "JAN";
        break;
      case 1:
        text = "FEB";
        break;
      case 2:
        text = "MAR";
        break;
      case 3:
        text = "APR";
        break;
      case 4:
        text = "MAY";
        break;
      case 5:
        text = "JUN";
        break;
      case 6:
        text = "JUL";
        break;
      case 7:
        text = "AUG";
        break;
      case 8:
        text = "SEP";
        break;
      case 9:
        text = "OCT";
        break;
      case 10:
        text = "NOV";
        break;
      case 11:
        text = "DEC";
        break;
      default:
        text = "";
    }
    return Padding(
      child: Text(text, style: style),
      padding: const EdgeInsets.only(
        top: 4,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Activités de 2022',
                    style: TextStyle(
                      color: Color(0xff171547),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FloatingActionButton.extended(
                  backgroundColor: Colors.white,
                  onPressed: () => SelectDate(),
                  label: Text(
                    "select année",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LegendsListWidget(
              legends: [
                Legend("<25", pilateColor),
                Legend("<50", quickWorkoutColor),
                Legend("<100", cyclingColor),
              ],
            ),
            const SizedBox(height: 14),
            AspectRatio(
              aspectRatio: 2,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceBetween,
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(),
                    rightTitles: AxisTitles(),
                    topTitles: AxisTitles(),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: bottomTitles,
                        reservedSize: 16,
                      ),
                    ),
                  ),
                  barTouchData: BarTouchData(enabled: false),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  barGroups: [
                    generateGroupData(0, 2, 3, 0),
                    generateGroupData(1, 2, 0, 0),
                    generateGroupData(2, 2, 3.1, 2.8),
                    generateGroupData(3, 2, 4, 3.1),
                    generateGroupData(4, 2, 3.3, 3.4),
                    generateGroupData(5, 2, 5.6, 1.8),
                    generateGroupData(6, 2, 3.2, 2),
                    generateGroupData(7, 2, 3.2, 3),
                    generateGroupData(8, 2, 4.8, 2.5),
                    generateGroupData(9, 2, 3.2, 2.5),
                    generateGroupData(10, 2, 4.8, 3),
                    generateGroupData(11, 2, 4.4, 2.8),
                  ],
                  maxY: 10 + (betweenSpace * 3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
