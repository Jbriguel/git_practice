import 'package:intl/intl.dart';

List<Map<String, String>> daysOfWeek(DateTime ladateToday) {
  // get today's date
  List<Map<String, String>> dateList = [];
  var now = ladateToday;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  int today = now.weekday;
  var dayNr = (today + 6) % 7;

  var lundiExample = now.subtract(Duration(days: (dayNr)));
  final String lundi = formatter.format(lundiExample);
  final String mardi =
      formatter.format(lundiExample.add(const Duration(days: 1)));
  final String mercredi =
      formatter.format(lundiExample.add(const Duration(days: 2)));
  final String jeudi =
      formatter.format(lundiExample.add(const Duration(days: 3)));
  final String vendredi =
      formatter.format(lundiExample.add(const Duration(days: 4)));
  final String samedi =
      formatter.format(lundiExample.add(const Duration(days: 5)));
  final String dimanche =
      formatter.format(lundiExample.add(const Duration(days: 6)));

/*  print("Todays date: ${now}");
  print("Todays date: ${formatter.format(now)}");
  print("Lundi of this week: ${lundi}");
  print("Mardi of this week: ${mardi}");
  print("Mercredi of this week: ${mercredi}");
  print("Jeudi of this week: ${jeudi}");
  print("Vendredi of this week: ${vendredi}");
  print("Samedi of this week: ${samedi}");*/
  dateList.addAll([
    {
      "day": "Lun",
      "num": "${lundi[lundi.length - 2]}${lundi[lundi.length - 1]}"
    },
    {
      "day": "Mar",
      "num": "${mardi[mardi.length - 2]}${mardi[mardi.length - 1]}"
    },
    {
      "day": "Mer",
      "num": "${mercredi[mercredi.length - 2]}${mercredi[mercredi.length - 1]}"
    },
    {
      "day": "Jeu",
      "num": "${jeudi[jeudi.length - 2]}${jeudi[jeudi.length - 1]}"
    },
    {
      "day": "Ven",
      "num": "${vendredi[vendredi.length - 2]}${vendredi[vendredi.length - 1]}"
    },
    {
      "day": "Sam",
      "num": "${samedi[samedi.length - 2]}${samedi[samedi.length - 1]}"
    },
    {
      "day": "Dim",
      "num": "${dimanche[dimanche.length - 2]}${dimanche[dimanche.length - 1]}"
    },
  ]);
  //print(dateList);
  return dateList;
}

bool isToday(String? numDay, dateSelected) {
  var now = dateSelected;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String today = formatter.format(now);
  final String todayNum =
      "${today[today.length - 2]}${today[today.length - 1]}";
  return todayNum == numDay ? true : false;
}
 
String stringMonth(String? numMonth) {
  String mois = "";
  switch (numMonth) {
    case "1":
      mois = "Jan";
      break;
    case "2":
      mois = "Fév";
      break;
    case "3":
      mois = "Mars";
      break;
    case "4":
      mois = "Avr";
      break;
    case "5":
      mois = "Mai";
      break;
    case "6":
      mois = "Juin";
      break;
    case "7":
      mois = "Juil";
      break;
    case "8":
      mois = "Août";
      break;
    case "9":
      mois = "Sep";
      break;
    case "10":
      mois = "Oct";
      break;
    case "11":
      mois = "Nov";
      break;
    case "12":
      mois = "Dec";
      break;
    default:
  }
  return mois;
}

String? getDay(DateTime ladateToday) {
  var now = ladateToday;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String today = formatter.format(now);
  final String todayNum =
      "${today[today.length - 2]}${today[today.length - 1]}";
  List<Map<String, String>> dateList = daysOfWeek(ladateToday);
  for (Map<String, String> item in dateList) {
    if (item["num"] == todayNum) {
      return item["day"];
    }
  }
  return null;
}
