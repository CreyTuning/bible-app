import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yhwh/data/Define.dart';
import 'package:http/http.dart' as http;

class VerseOfTheDay extends StatefulWidget {
  VerseOfTheDay({Key key}) : super(key: key);

  @override
  _VerseOfTheDayState createState() => _VerseOfTheDayState();
}

class _VerseOfTheDayState extends State<VerseOfTheDay> {

  double height = 80.0;
  DateTime dateTime;
  String userName = 'Luis';
  int book = 0;
  int chapter = 0;
  int verse = 0;
  String verseReference = 'Cargando...';
  String data = '';

  Future getVerse(int book, int chapter, int verse) async {

    if(book == 0 || chapter == 0 || verse == 0)
      return 'Cargando...';
    
    else{
      Map data = json.decode(await rootBundle.loadString('lib/bibles/RVR60/${book}_$chapter.json'));
      return data['verses'][verse - 1]['text'].toString();
    }
  }

  @override
  void initState() {

    dateTime = DateTime.now();

    SharedPreferences.getInstance().then((preferences)
    {
      data = preferences.getString('dailyVerseMonthData') ?? '{"information" : {"year" : "0", "month" : "0"}}';

      // Descargar la nueva data 
      if(data == '{"information" : {"year" : "0", "month" : "0"}}' || json.decode(data)['information']['year'] != dateTime.year || json.decode(data)['information']['month'] != dateTime.month){
        http.read('https://raw.githubusercontent.com/CreyTuning/DatabaseOfYhwh/master/daily_verse/${dateTime.year}/${dateTime.month}.json').then((response){
          String text = json.decode(response)['verses']['${dateTime.year.toString().substring(2)}_${dateTime.month}_${dateTime.day}'];

          setState(() {
            book = int.parse(text.split(':')[0]);
            chapter = int.parse(text.split(':')[1]);
            verse = int.parse(text.split(':')[2]);
            verseReference = '${intToBook[book]} $chapter:$verse';
            data = response;
          });

          preferences.setString('dailyVerseMonthData', data);
        });
      }

      // Usar la data existente para mostrar el versiculo del dia
      else{
        String text = json.decode(data)['verses']['${dateTime.year.toString().substring(2)}_${dateTime.month}_${dateTime.day}'];

        setState(() {
          book = int.parse(text.split(':')[0]);
          chapter = int.parse(text.split(':')[1]);
          verse = int.parse(text.split(':')[2]);
          verseReference = '${intToBook[book]} $chapter:$verse';
        });
      }
    });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      elevation: 2,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,

          children: [
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Versículo del día',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    )
                  )
                ),

                Spacer(),

                Icon(Icons.wb_sunny, color: Colors.amber),
              ],
            ),

            SizedBox(height: 12,),

            FutureBuilder(
              future: getVerse(book, chapter, verse),
              initialData: 'Cargando...',
              builder: (context, snapshot) {
                if(snapshot.hasData)
                {
                  return RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      text: snapshot.data,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 18,
                        height: 1.2
                      )
                    )
                  );
                }

                return RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: 'Cargando...',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: 18,
                    )
                  )
                );
              },
            ),

            SizedBox(height: 10,),

            Container(
              width: double.infinity,
              child: RichText(
                textAlign: TextAlign.right,
                text: TextSpan(
                  text: verseReference,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 15,
                    height: 1,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Bookerly'
                  )
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}