import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:yhwh/data/Data.dart';
import 'package:flutter/material.dart';

class BookViewer extends StatefulWidget {
  final AsyncSnapshot snapshot;
  BookViewer({this.snapshot});

  _BookViewerState createState() => _BookViewerState();
}

class _BookViewerState extends State<BookViewer> {

  @override
  Widget build(BuildContext context)
  {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, item){
          if(item + 1 == widget.snapshot.data.chapters[appData.getChapterNumber - 1].versos.length){
            return Column(
              children: <Widget>[
                widget.snapshot.data.chapters[appData.getChapterNumber - 1].versos[item],
                Divider(height: 50, color: Color(0x00)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: RichText(
                    text: TextSpan(text: 'La Valera 1602 Purificada es la obra de la Iglesia Bautista Bíblica de la Gracia en Monterrey.',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Baloo',
                        letterSpacing: 1.3,
                        color: Colors.black54,
                        height: 1
                      )
                    ),
                    textAlign: TextAlign.center,
                  )
                ),

                FlatButton(
                  splashColor: Colors.white,
                  child: Text('Quiero saber mas',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Baloo',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: Colors.green,
                  )),
                  onPressed: (){},
                ),

                Container(height: 250)
              ],
            );
          }

          return widget.snapshot.data.chapters[appData.getChapterNumber - 1].versos[item];
        },
          childCount: widget.snapshot.data.chapters[appData.getChapterNumber - 1].versos.length,
      ),
    );
  }
}