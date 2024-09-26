import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  // SelectDate() async {
  //   DateTime? newDateTime = await showRoundedDatePicker(
  //     initialDatePickerMode: DatePickerMode.year,
  //     era: EraMode.CHRIST_YEAR,
  //     firstDate: DateTime(2018),
  //     lastDate: DateTime(2030),
  //     borderRadius: 16,
  //     /*imageHeader: const AssetImage(
  //                             "assets/images/bazin4.jpg",
  //                           ),*/
  //     height: 300,
  //     context: context,
  //     theme: ThemeData(
  //       primaryColor: Colors.white,
  //     ),
  //     description: "Selectionner l'année'",
  //   );
  //   if (newDateTime != null) {
  //     dateTime = newDateTime;
  //   }
  // }

  BarChartGroupData generateBar(
    int x,
    double value,
  ) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: value,
          color: ThemeColors.blue,
          width: 5,
        ),
      ],
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.w500,
        fontFamily: "Aller");
    String text;
    if (value % 10 == 0) {
      text = '${value.round()}';
    } else {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 2),
      // margin: const EdgeInsets.symmetric(horizontal: 5),
      child: AutoSizeText(
        text,
        maxLines: 1,
        maxFontSize: 10,
        minFontSize: 5,
        style: style,
      ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff787694),
      fontFamily: "Aller",
      fontSize: 8,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = "Jan";
        break;
      case 1:
        text = "Fev";
        break;
      case 2:
        text = "Mar";
        break;
      case 3:
        text = "Avr";
        break;
      case 4:
        text = "Mai";
        break;
      case 5:
        text = "Jun";
        break;
      case 6:
        text = "Jul";
        break;
      case 7:
        text = "Aoû";
        break;
      case 8:
        text = "Sep";
        break;
      case 9:
        text = "Oct";
        break;
      case 10:
        text = "Nov";
        break;
      case 11:
        text = "Dec";
        break;
      default:
        text = "";
    }
    return Padding(
      padding: const EdgeInsets.only(
        top: 5,
      ),
      child: Text(text, style: style),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      child: AspectRatio(
        aspectRatio: 1.7,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceBetween,
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 25,
                  interval: 2,
                  getTitlesWidget: leftTitles,
                ),
              ),
              rightTitles: const AxisTitles(),
              topTitles: const AxisTitles(),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: bottomTitles,
                  interval: 1,
                  reservedSize: 16,
                ),
              ),
            ),
            barTouchData: BarTouchData(enabled: false),
            borderData: FlBorderData(show: false),
            gridData: const FlGridData(show: false),
            barGroups: [
              generateBar(0, 10),
              generateBar(1, 9),
              generateBar(2, 20),
              generateBar(3, 41),
              generateBar(4, 50),
              generateBar(5, 62),
              generateBar(6, 28),
              generateBar(7, 90),
              generateBar(8, 80),
              generateBar(9, 70),
              generateBar(10, 15),
              generateBar(11, 26),
            ],
            maxY: 100,
          ),
        ),
      ),
    );
  }
}
