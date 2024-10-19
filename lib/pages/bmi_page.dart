import 'dart:developer' as developer;
import 'package:ibmi_app/utils/calculator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibmi_app/Widgets/info_card.dart';

class BmiPage extends StatefulWidget {
  const BmiPage({super.key});

  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  double? deviceHeight, deviceWidth;
  int age = 25;
  int weight = 160;
  int height = 70;
  int gender = 0;

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Center(
      child: CupertinoPageScaffold(
        child: SizedBox(
            height: deviceHeight! * 0.85,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ageSelectContainer(),
                    weightSelectContainer(),
                  ],
                ),
                heightSelectContainer(),
                genderSelectContainer(),
                bmiButton(),
              ],
            )),
      ),
    );
  }

  Widget ageSelectContainer() {
    return InfoCard(
      width: deviceWidth! * 0.45,
      height: deviceHeight! * 0.20,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Age yr',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            age.toString(),
            style: const TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                  key: const Key('age_minus'),
                  onPressed: () {
                    setState(() {
                      age--;
                    });
                  },
                  textStyle: const TextStyle(
                    fontSize: 25,
                    color: Colors.red,
                  ),
                  child: const Text('-'),
                ),
              ),
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                  key: const Key('age_plus'),
                  onPressed: () {
                    setState(() {
                      age++;
                    });
                  },
                  textStyle: const TextStyle(
                    fontSize: 25,
                    color: Colors.blue,
                  ),
                  child: const Text('+'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget weightSelectContainer() {
    return InfoCard(
      width: deviceWidth! * 0.45,
      height: deviceHeight! * 0.20,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Weight lbs',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            weight.toString(),
            style: const TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                  key: const Key('weight minus'),
                  onPressed: () {
                    setState(() {
                      weight--;
                    });
                  },
                  textStyle: const TextStyle(
                    fontSize: 25,
                    color: Colors.red,
                  ),
                  child: const Text('-'),
                ),
              ),
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                  key: const Key('weight plus'),
                  onPressed: () {
                    setState(() {
                      weight++;
                    });
                  },
                  textStyle: const TextStyle(
                    fontSize: 25,
                    color: Colors.blue,
                  ),
                  child: const Text('+'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget heightSelectContainer() {
    return InfoCard(
      width: deviceWidth! * 0.90,
      height: deviceHeight! * 0.18,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text(
            'Height in',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            height.toString(),
            style: const TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            width: deviceWidth! * 0.80,
            child: CupertinoSlider(
              min: 0,
              max: 96,
              divisions: 96,
              value: height.toDouble(),
              onChanged: (value) {
                setState(() {
                  height = value.toInt();
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget genderSelectContainer() {
    return InfoCard(
      width: deviceWidth! * 0.90,
      height: deviceHeight! * 0.11,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text(
            'Gender',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          CupertinoSlidingSegmentedControl(
            groupValue: gender,
            children: const {
              0: Text('Male'),
              1: Text('Female'),
            },
            onValueChanged: (value) {
              setState(() {
                gender = value as int;
              });
            },
          )
        ],
      ),
    );
  }

  Widget bmiButton() {
    return SizedBox(
      height: deviceHeight! * 0.07,
      child: CupertinoButton.filled(
        child: const Text(
          'Calculate BMI',
        ),
        onPressed: () {
          if (height > 0 && weight > 0 && age > 0) {
            double bmi = calculateBmi(height, weight);
            showResultDialog(bmi);
          }
        },
      ),
    );
  }

  void showResultDialog(double bmi) {
    String? status;
    if (bmi < 18.5) {
      status = "UnderWeight";
    } else if (bmi >= 18.5 && bmi < 25) {
      status = "Normal";
    } else if (bmi >= 25 && bmi < 30) {
      status = "OverWeight";
    } else if (bmi >= 30) {
      status = "Obese";
    }
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(status!),
          content: Text(bmi.toStringAsFixed(2)),
          actions: [
            CupertinoDialogAction(
              child: const Text('Ok'),
              onPressed: () {
                saveResult(bmi.toString(), status!);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void saveResult(String bmi, String status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'bmi_date',
      DateTime.now().toString(),
    );
    await prefs.setStringList(
      'bmi_data',
      <String>[
        bmi,
        status,
      ],
    );
    //print('BMI Result Saved!');
    developer.log("\x1B[32mBMI Result Saved!\x1B[0m");
  }
}