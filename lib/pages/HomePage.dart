import 'package:yhwh/data/Define.dart';
import 'package:flutter/material.dart';
import 'package:yhwh/data/Data.dart';

import 'BookViewer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int versesCount = 1;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: appData.getBook,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
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
                          onPressed: () {
                            setState(() {
                              appData.previousChapter().then((data){});
                            });
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
                          onPressed: () {
                            setState(() {
                              appData.nextChapter();
                            });
                          },
                        )),
                  ],
                ),
              ),
              body: Scrollbar(
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: <Widget>[
                    SliverAppBar(
                      forceElevated: true,
                      floating: true,
                      backgroundColor: Colors.white,
                      title: Container(
                        child: Row(
                          children: <Widget>[
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, 'books', arguments: snapshot);
                                },
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      '${intToBook[appData.getBookNumber]} ${appData.getChapterNumber}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Roboto',
                                          color: Color(0xff263238)),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(0xff263238),
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),
                      actions: <Widget>[
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
                    BookViewer(snapshot: snapshot,)
                  ],
                ),
              )
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
