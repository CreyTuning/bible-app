import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yhwh/data/Define.dart';
import 'package:http/http.dart' as http;
import 'package:yhwh/pages/BiblePage/Classes/getVerse.dart';
import 'package:yhwh/ui_widgets/ui_verse.dart';

class VerseOfTheDayInformation extends StatefulWidget {
  VerseOfTheDayInformation({
    Key key,
    @required this.data
  }) : super(key: key);

  final String data;

  @override
  _VerseOfTheDayInformationState createState() => _VerseOfTheDayInformationState();
}

class _VerseOfTheDayInformationState extends State<VerseOfTheDayInformation> {

  bool updatingData = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${monthDayToString[DateTime.now().month]}',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1.color  
          )
        ),
      ),
      body: ListView(
        children: [
          VerseListOfMonth(
            data: widget.data,
          )
        ],
      ),
    );
  }
}


class VerseListOfMonth extends StatefulWidget {
  VerseListOfMonth({
    Key key,
    this.data
  }) : super(key: key);

  final String data;

  @override
  VerseListOfMonthState createState() => VerseListOfMonthState();
}

class VerseListOfMonthState extends State<VerseListOfMonth> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> verses = [];
    Map information = json.decode(widget.data);

    information['verses'].forEach((key, value) {

      if(int.parse(key.split('_')[2]) <= DateTime.now().day)
      {
        verses.insert(0,
          ListTile(
            onTap: (){
              showDialog(
                context: context,
                builder: (_) => new AlertDialog(
                  contentPadding: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 20.0),
                  insetPadding: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 20.0),
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  scrollable: true,
                  backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                  content: FutureBuilder(
                    future: getVerse(int.parse(value.split(':')[0]), int.parse(value.split(':')[1]), int.parse(value.split(':')[2])),
                    initialData: 'cargando...',
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        return UiVerse(
                          verseNumber: int.parse(value.split(':')[2]),
                          chapterNumber: int.parse(value.split(':')[1]),
                          bookNumber: int.parse(value.split(':')[0]),
                          text: snapshot.data,
                          title: '${intToBook[int.parse(value.split(':')[0])]} ${int.parse(value.split(':')[1])}:${int.parse(value.split(':')[2])}',
                          highlight: false,
                          color: Theme.of(context).textTheme.bodyText1.color,
                          colorOfNumber: Theme.of(context).textTheme.bodyText2.color,
                          deleteHighlightVerse: (data){},
                          highlightVerse: (data){},
                          height: 1.4,
                        );
                      }

                      else{
                        return UiVerse(
                          verseNumber: int.parse(value.split(':')[2]),
                          chapterNumber: int.parse(value.split(':')[1]),
                          bookNumber: int.parse(value.split(':')[0]),
                          text: 'cargando...',
                          title: '${intToBook[int.parse(value.split(':')[0])]} ${int.parse(value.split(':')[1])}:${int.parse(value.split(':')[2])}',
                          highlight: false,
                          color: Theme.of(context).textTheme.bodyText1.color,
                          colorOfNumber: Theme.of(context).textTheme.bodyText2.color,
                          deleteHighlightVerse: (data){},
                          highlightVerse: (data){},
                          height: 1.4,
                        );
                      }
                    },
                  ),
                )
              );
                
            },
            dense: true,
            leading: CircleAvatar(
              backgroundColor: int.parse(key.split('_')[2]) == DateTime.now().day ? Colors.purple : Colors.indigo,
              child: RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 16,
                    color: Colors.white
                  ),
                  text: '${key.split('_')[2]}'
                ),
              ),
            ),
            
            title: RichText(
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
                text: '${intToBook[int.parse(value.split(':')[0])]} ${int.parse(value.split(':')[1])}:${int.parse(value.split(':')[2])}'
              ),
            ),

            subtitle: FutureBuilder(
              future: getVerse(int.parse(value.split(':')[0]), int.parse(value.split(':')[1]), int.parse(value.split(':')[2])),
              initialData: 'cargando...',
              builder: (context, snapshot) {
                if(snapshot.hasData)
                  return RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 16
                      ),
                      text: snapshot.data
                    ),
                  );
                
                else return RichText(
                  overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 16
                      ),
                      text: 'cargando...'
                    ),
                  );
              },
            )
          )
        );
      }
    });

    return Container(
        child: Column(
          children: verses,
        ),
    );
  }
}