import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yhwh/data/Define.dart';
import 'package:http/http.dart' as http;
import 'package:yhwh/pages/BiblePage/Classes/getVerse.dart';
import 'package:yhwh/ui_widgets/ui_verse.dart';

class VerseOfTheDayInformation extends StatefulWidget {
  VerseOfTheDayInformation({
    Key key,
    @required this.data,
    @required this.updateData
  }) : super(key: key);

  final String data;
  final Function(String newData) updateData;

  @override
  _VerseOfTheDayInformationState createState() => _VerseOfTheDayInformationState();
}

class _VerseOfTheDayInformationState extends State<VerseOfTheDayInformation> {

  String data = '{"information" : {"year" : "0", "month" : "0"}, "verses" : {"0_0_0" : "0:0:0"}}';
  bool enabledRefreshButton = true;

  @override
  void initState() {
    
    setState(() {
      data = widget.data;
    });

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

        actions: [
          Builder(
            builder: (context) {
              if(enabledRefreshButton){
                return IconButton(
                  icon: Icon(Icons.refresh, color: enabledRefreshButton ? Theme.of(context).textTheme.bodyText1.color : Theme.of(context).textTheme.bodyText2.color),
                  tooltip: 'Actualizar',
                  onPressed: enabledRefreshButton ? () {
                    SharedPreferences.getInstance().then((preferences)
                    {
                      // Descargar la nueva data 
                      Connectivity().checkConnectivity().then((connectivityResult) {
                        if (connectivityResult == ConnectivityResult.none) {
                          // Mobile is not Connected to Internet

                          setState(() {
                            enabledRefreshButton = false;
                          });

                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 2),
                              content: Text('Sin acceso a Internet', style: TextStyle(
                                color: Colors.white
                              )),
                              backgroundColor: Colors.red,
                            )
                          );

                          Timer(Duration(seconds: 2), (){
                            setState(() {
                              enabledRefreshButton = true;
                            });
                          });

                        }
                        else if (connectivityResult == ConnectivityResult.mobile) {
                          // I am connected to a mobile network.

                          setState(() {
                            enabledRefreshButton = false;
                          });

                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 2),
                              content: Text('Actualizando...', style: TextStyle(
                                color: Colors.white
                              )),
                              backgroundColor: Colors.blue,
                            )
                          );

                          try {
                            http.read('https://raw.githubusercontent.com/CreyTuning/DatabaseOfYhwh/master/daily_verse/${DateTime.now().year}/${DateTime.now().month}.json').then((response)
                            {
                              setState(() {
                                data = response;
                                enabledRefreshButton = true;
                              });

                              widget.updateData(data);
                              preferences.setString('dailyVerseMonthData', data);

                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(seconds: 2),
                                  content: Text('Información actualizada', style: TextStyle(
                                    color: Colors.white
                                  )),
                                  backgroundColor: Colors.green,
                                )
                              );
                            });
                          } catch (e) {
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 2),
                                content: Text('Mala conexión a internet', style: TextStyle(
                                  color: Colors.white
                                )),
                                backgroundColor: Colors.red,
                              )
                            );

                            setState(() {
                              enabledRefreshButton = true;
                            });
                          }
                        }
                        else if (connectivityResult == ConnectivityResult.wifi) {
                          // I am connected to a wifi network.

                          setState(() {
                            enabledRefreshButton = false;
                          });

                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 2),
                              content: Text('Actualizando...', style: TextStyle(
                                color: Colors.white
                              )),
                              backgroundColor: Colors.blue,
                            )
                          );

                          try {
                            http.read('https://raw.githubusercontent.com/CreyTuning/DatabaseOfYhwh/master/daily_verse/${DateTime.now().year}/${DateTime.now().month}.json').then((response)
                            {
                              setState(() {
                                data = response;
                                enabledRefreshButton = true;
                              });

                              widget.updateData(data);
                              preferences.setString('dailyVerseMonthData', data);

                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(seconds: 2),
                                  content: Text('Información actualizada', style: TextStyle(
                                    color: Colors.white
                                  )),
                                  backgroundColor: Colors.green,
                                )
                              );
                            });
                          } catch (e) {
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 2),
                                content: Text('Mala conexión a internet', style: TextStyle(
                                  color: Colors.white
                                )),
                                backgroundColor: Colors.red,
                              )
                            );

                            setState(() {
                              enabledRefreshButton = true;
                            });
                          }
                        }
                      });

                    });
                  } : null
                );
              }

              else{
                return Container(
                  width: 55,
                  height: 55,
                  padding: EdgeInsets.all(18),
                  child: CircularProgressIndicator(),
                );
              }
              
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          VerseListOfMonth(
            data: data,
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
      
      if(int.parse(key.split('_')[0]) == 0 && int.parse(key.split('_')[1]) == 0 && int.parse(key.split('_')[2]) == 0){
        verses.insert(0,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: CircularProgressIndicator(),
          )
        );
      }

      else if(int.parse(key.split('_')[2]) == DateTime.now().day){
        verses.insert(0,
          Card(
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
                    future: getVerse(int.parse(value.split(':')[0]), int.parse(value.split(':')[1]), int.parse(value.split(':')[2])),
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
                        text: '${intToBook[int.parse(value.split(':')[0])]} ${int.parse(value.split(':')[1])}:${int.parse(value.split(':')[2])}',
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
          )
        );
      }

      else if(int.parse(key.split('_')[2]) <= DateTime.now().day)
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
              backgroundColor: Colors.purple[400],
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