import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ibmi_app/Widgets/info_card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  double? deviceHeight, deviceWidth;

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return CupertinoPageScaffold(
      child: Center(
        child: dataCard(),
      ),
    );
  }

  Widget dataCard() {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final prefs = snapshot.data as SharedPreferences;
          final date = prefs.getString('bmi_date');
          final data = prefs.getStringList('bmi_data');
          return InfoCard(
            width: deviceWidth! * 0.75,
            height: deviceHeight! * 0.25,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                statusText(data![1]),
                dateText(date!),
                bmiText(data[0]),
              ],
            ),
          );
        } else {
          return const Center(
            child: CupertinoActivityIndicator(
              color: Colors.blue,
            ),
          );
        }
      },
    );
  }

  Widget statusText(String status) {
    return Text(
      status,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget dateText(String date) {
    DateTime parseDate = DateTime.parse(date);
    return Text(
      '${parseDate.day} / ${parseDate.month} / ${parseDate.year}',
      style: const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 15,
      ),
    );
  }

  Widget bmiText(String bmi) {
    return Text(
      double.parse(bmi).toStringAsFixed(2),
      style: const TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
