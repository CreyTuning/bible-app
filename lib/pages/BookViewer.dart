import 'dart:ui';

import 'package:bbnew/data/Data.dart';
import 'package:bbnew/data/Styles.dart' as styles;
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
    return FutureBuilder
    (
      future: appData.getBookMap(),
      builder: (BuildContext context, AsyncSnapshot snapshot)
      {
        if(snapshot.hasData)
          return ListView.builder
          (
            padding: EdgeInsets.fromLTRB(0, 10, 0, 300.0),
            itemCount: appData.versesCountList[appData.chapter - 1],
            itemBuilder: (BuildContext context, int item)
            {
              return Column
              (
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RichText
                    (
                      text: TextSpan
                      (
                        style: styles.verseText,
                        children: <InlineSpan>
                        [
                          TextSpan
                          (
                            text: "${item + 1} ",
                            style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold)
                          ),

                          TextSpan
                          (
                            text: "${snapshot.data['chapters'][appData.chapter - 1]['verses'][item]['text']}",
                            style: TextStyle(height: 1.5, letterSpacing: 0.6)
                          )
                        ]
                      ),
                      // textAlign: TextAlign.justify,

                    ),
                  ),

                  Divider(color: Color(0x00), height: 20.0,)
                ],
              );
            }
          );
        else
          return Center
          (
            child: CircularProgressIndicator(),
          );
      }
    );
  }
}