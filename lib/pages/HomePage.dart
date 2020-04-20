import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:yhwh/data/Define.dart';
import 'package:flutter/material.dart';
import 'package:yhwh/data/Data.dart';

import 'BookViewer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: appData.getBook,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            color: Colors.white,
            child: SafeArea(
              child: Scaffold(
                  floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            width: 41.0,
                            height: 41.0,
                            child: new RawMaterialButton(
                              shape: new CircleBorder(),
                              fillColor: Colors.white,
                              child: Icon(Icons.keyboard_arrow_left),
                              onPressed: () async {
                                await appData.previousChapter();
                                setState(() {});
                              },
                            )),
                        Expanded(child: SizedBox.fromSize()),
                        Container(
                            width: 41.0,
                            height: 41.0,
                            child: new RawMaterialButton(
                              shape: new CircleBorder(),
                              fillColor: Colors.white,
                              child: Icon(Icons.keyboard_arrow_right),
                              onPressed: () async {
                                await appData.nextChapter();
                                setState(() {
                                });
                              },
                            )),
                      ],
                    ),
                  ),
                  body: Scrollbar(
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverAppBar(
                          forceElevated: true,
                          floating: true,
                          backgroundColor: Colors.white,

                          actions: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  RaisedButton(
                                      color: Colors.white,
                                      elevation: 0.0,
                                      onPressed: () {
                                        Navigator.pushNamed(context, 'books', arguments: snapshot);
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            '${intToBook[appData.getBookNumber]} ${appData.getChapterNumber}',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'Roboto',
//                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff263238),
//                                              fontWeight: FontWeight.bold
                                            ),
                                          ),

                                          Icon(
                                            Icons.arrow_drop_down,
                                            color: Color(0xff263238),
                                          ),
                                        ],
                                      )
                                  ),
                                ],
                              ),
                            ),

                            Spacer(),

                            Container(
                              width: 60.0,
                              height: 60.0,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                color: Colors.white,
                                elevation: 0,
                                child: Icon(Icons.text_fields,
                                    color: Color(0xff37474F)),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                        BookViewer(snapshot: snapshot)
                      ],
                    ),
                  )
              ),
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
