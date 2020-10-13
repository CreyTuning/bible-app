import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yhwh/data/Define.dart';

class ScheduleAllDays extends StatefulWidget {
  ScheduleAllDays({Key key}) : super(key: key);

  @override
  _ScheduleAllDaysState createState() => _ScheduleAllDaysState();
}

class _ScheduleAllDaysState extends State<ScheduleAllDays> {
  
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 150,
      child: ListView(
        controller: ScrollController(initialScrollOffset: 96.0 * (DateTime.now().weekday - 1)),
        padding: EdgeInsets.fromLTRB(0, 0, 6, 0),
        scrollDirection: Axis.horizontal,
        children: [
          DayCard(
            day: weekNumberToString[1],
            title: 'Libre',
            color: Colors.blue,
            icon: Icons.airline_seat_individual_suite,
            time: 'Todo el dia',
            isToday: DateTime.now().weekday == 1 ? true : false
          ),
          
          DayCard(
            day: weekNumberToString[2],
            title: 'Niños',
            color: Colors.pink,
            icon: Icons.child_care,
            time: '4:00 P.M.',
            isToday: DateTime.now().weekday == 2 ? true : false
          ),

          DayCard(
            day: weekNumberToString[3],
            title: 'Servicio',
            color: Colors.green,
            icon: Icons.people,
            time: '7:00 P.M.',
            isToday: DateTime.now().weekday == 3 ? true : false
          ),

          DayCard(
            day: weekNumberToString[4],
            title: 'Intercesión',
            color: Colors.purple,
            icon: Icons.power,
            time: '2:00 P.M.',
            isToday: DateTime.now().weekday == 4 ? true : false
          ),

          DayCard(
            day: weekNumberToString[5],
            title: 'Estudios',
            color: Colors.red,
            icon: CupertinoIcons.pen,
            time: '2:00 P.M.',
            isToday: DateTime.now().weekday == 5 ? true : false
          ),

          DayCard(
            day: weekNumberToString[6],
            title: 'Ensayos',
            color: Colors.teal,
            icon: CupertinoIcons.music_note,
            time: '10 AM / 2 PM',
            isToday: DateTime.now().weekday == 6 ? true : false
          ),

          DayCard(
            day: weekNumberToString[7],
            title: 'Servicio',
            color: Colors.green,
            icon: Icons.people,
            time: '9:00 A.M.',
            isToday: DateTime.now().weekday == 7 ? true : false
          ),
        ],
      ),
    );
  }
}


class DayCard extends StatelessWidget {
  const DayCard({
    Key key,
    this.color,
    this.day,
    this.title,
    this.icon,
    this.activitys,
    this.time,
    @required this.isToday

  }) : super(key: key);

  final String day;
  final String time;
  final String title;
  final IconData icon;
  final Color color;
  final bool isToday;
  final List<List> activitys;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(4, 6, 2, 6),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).cardColor,
        child: Container(
          width: 90,
          height: 138,

          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                  color: color//Colors.green.withGreen(120).withGreen(50)
                ),
                alignment: Alignment.center,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                    text: day
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      Spacer(),

                      Icon(icon, size: 40, color: Theme.of(context).textTheme.bodyText1.color),

                      Spacer(),

                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize: 12
                          ),
                          text: title
                        ),
                      ),

                      // Spacer(),

                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                            fontSize: 12
                          ),
                          text: time
                        ),
                      ),

                      Spacer(),

                      !isToday ? SizedBox() : Container(
                        width: double.infinity,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
                          color: color
                        ),
                        alignment: Alignment.center,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                            text: 'Hoy'
                          ),
                        ),
                      ),

                    ],
                  )
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}