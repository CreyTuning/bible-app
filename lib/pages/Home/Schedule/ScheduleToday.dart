import 'package:flutter/material.dart';
import 'package:yhwh/data/Define.dart';

class ScheduleToday extends StatefulWidget {
  ScheduleToday({Key key}) : super(key: key);

  @override
  _ScheduleTodayState createState() => _ScheduleTodayState();
}

class _ScheduleTodayState extends State<ScheduleToday> {

  double height = 80.0;
  DateTime dateTime;
  String userName = 'Luis';

  @override
  void initState() {

    dateTime = DateTime.now();

    // var github = GitHub();

    // github.getJSON('https://raw.githubusercontent.com/CreyTuning/TextosBiblicos/master/V1602P_JSON/8_Rt.json').then((value){
    //   print(value['description']);
    // });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
        width: double.infinity,
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: '${weekNumberToString[dateTime.weekday]}, ${dateTime.day.toString()} de ${monthDayToString[dateTime.month]}',
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontSize: 16,
                )
              )
            ),

            RichText(
              text: TextSpan(
                text: dateTime.hour >= 0 && dateTime.hour < 12 ? 'Buenos dias.' : 
                  dateTime.hour >= 12 && dateTime.hour < 19 ? 'Buenas tardes.' :
                    'Buenas noches.',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1.3
                )
              )
            ),
          ],
        ),
      ),
    );
  }
}