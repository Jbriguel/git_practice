import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/widgets/separator.dart';
import 'package:atelier_so/widgets/stats/exemple1.dart';
import 'package:atelier_so/widgets/stats/exemple2.dart';
import 'package:atelier_so/widgets/stats/exmple3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class StatsScreen extends StatefulWidget {
  @override
  StatsScreenState createState() => StatsScreenState();
}

class StatsScreenState extends State<StatsScreen>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  Color cardColor = Colors.white;
  Color textColor = Colors.black;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                Images.logo_noBack,
                fit: BoxFit.fitWidth,
                height: 30,
                width: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    'les ',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    'bilans',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [],
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                const SizedBox(
                  height: 2,
                ),

                const SizedBox(
                  height: 5,
                ),
                // Container(height: 200.0, child: BarChartSample6()),
                // const SizedBox(
                //   height: 2,
                // ),
                // Row(
                //   children: <Widget>[
                //     const Expanded(
                //         child: Padding(
                //       padding: EdgeInsets.symmetric(horizontal: 10),
                //       child: Divider(
                //         height: 1,
                //         color: Colors.grey,
                //       ),
                //     )),
                //     Container(
                //       color: Colors.transparent,
                //       child: Padding(
                //         padding: const EdgeInsets.symmetric(
                //           horizontal: 5,
                //           vertical: 8,
                //         ),
                //         child: Text(
                //           "Données trimestrielles",
                //           textAlign: TextAlign.center,
                //           style: TextStyle(
                //             fontFamily: 'Poppins',
                //             fontSize: 11,
                //             color: Colors.blueGrey.withOpacity(0.7),
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //       ),
                //     ),
                //     const Expanded(
                //       child: Padding(
                //         padding: EdgeInsets.symmetric(horizontal: 15),
                //         child: Divider(
                //           height: 1,
                //           color: Colors.grey,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(
                  height: 5,
                ),
                // Container(child: BarChartSample2()),
                // const SizedBox(
                //   height: 2,
                // ),
                separator(
                  text: "Données Annuelles",
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(child: BarChartSample6()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }
}
