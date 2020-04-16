import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:yhwh/data/Data.dart';
import 'package:yhwh/data/Styles.dart' as styles;
import 'package:flutter/material.dart';

class BookViewer extends StatefulWidget
{
  BookViewer({Key key}) : super(key: key);

  @override
  _BookViewerState createState() => _BookViewerState();
}

class _BookViewerState extends State<BookViewer>
{
  @override
  Widget build(BuildContext context)
  {
    return FutureBuilder(
      future: appData.getBookMap(),
      builder: (BuildContext context, AsyncSnapshot snapshot)
      {
        if(snapshot.hasData) {
          return SliverList(
//              padding: EdgeInsets.fromLTRB(0, 10, 0, 300.0),
//              itemCount: appData.versesCountList[appData.chapter - 1],
              delegate: SliverChildBuilderDelegate((context, item) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: RichText(
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.start,
                        text: TextSpan(
                            style: TextStyle(fontSize: 20, color: Color(0xff263238), fontFamily: 'Roboto', height: 1.8),
                            children: <InlineSpan>[
                              TextSpan(
                                  text: "${item + 1} ",
                                  style: TextStyle(
                                      color: Color(0xaf37474F), fontSize: 13.0)
                              ),

                              TextSpan(
                                  text: "${snapshot.data['chapters'][appData.chapter - 1]['verses'][item]['text']}"
                              )
                            ]
                        ),
                      ),
                    ),

                    Divider(color: Color(0x00), height: 5.0,)
                  ],
                );
              },
                  childCount: appData.versesCountList[appData.chapter - 1],
              )
          );
        }
        else {
          return SliverList(
            delegate: SliverChildBuilderDelegate((context, index) => Center(child: CircularProgressIndicator()),
              childCount: 1,
            ),
          );
        }
      }
    );
  }
}