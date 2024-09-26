import 'package:atelier_so/core/functions/date_manipulation.dart';
import 'package:flutter/material.dart'; 

import 'date_column.dart';

final Color colors1 = const Color(0xEF000533);
CalendarCard(context, dateList, dateTime) => Card(
      clipBehavior: Clip.antiAlias,
      shadowColor: Colors.blueGrey,
      color: Colors.transparent,
      elevation: 4.0,
      child: SizedBox(
        height: 150,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "assets/images/bazin3.jpg",
                  ),
                ),
              ),
            ),
            Opacity(
              opacity: 0.6,
              child: Container(
                color: colors1,
              ),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      stringMonth("${dateTime.month}") + " ,${dateTime.year}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      for (Map<String, String> item in dateList)
                        DateColumn(
                            weekDay: item["day"],
                            date: item["num"],
                            dateBg: isToday(item["num"], dateTime)
                                ? Colors.white
                                : Colors.transparent,
                            dateTextColor: isToday(item["num"], dateTime)
                                ? colors1
                                : Colors.white),
                    ],
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  /*  Card(
      clipBehavior: Clip.antiAlias,
      shadowColor: Colors.lightBlueAccent.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 3.0,
      child: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              "assets/images/bazin2.jpg",
            ),
          ),
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 16),
            Center(
              child: Text(
                  stringMonth("${dateTime.month}") + " ,${dateTime.year}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 16),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  for (Map<String, String> item in dateList)
                    DateColumn(
                        weekDay: item["day"],
                        date: item["num"],
                        dateBg: isToday(item["num"], dateTime)
                            ? Colors.white
                            : Colors.transparent,
                        dateTextColor: isToday(item["num"], dateTime)
                            ? colors1
                            : Colors.white),
                ]),
            SizedBox(height: 20)
          ],
        ),
      ),
    );*/
