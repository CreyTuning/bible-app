import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:yhwh/data/Define.dart';
import 'package:flutter/material.dart';
import 'package:yhwh/data/Data.dart';
import 'package:yhwh/ui_widgets/chapter_footer.dart';

import 'BookViewer.dart';

class BiblePage extends StatefulWidget {
  @override
  _BiblePageState createState() => _BiblePageState();
}

class _BiblePageState extends State<BiblePage> {

  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController(initialScrollOffset: appData.scrollOffset);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: appData.getBook,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            color: Theme.of(context).appBarTheme.color,
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
                            child: RawMaterialButton(
                              shape: CircleBorder(),
                              fillColor: Theme.of(context).buttonColor,
                              child: Icon(Icons.keyboard_arrow_left, color: Theme.of(context).iconTheme.color,),
                              onPressed: () async {
                                await appData.previousChapter();
                                setState(() {
                                  _scrollController.animateTo(0, duration: Duration(seconds: 1), curve: Curves.ease);
                                });
                              },
                            )),
                        Expanded(child: SizedBox.fromSize()),
                        Container(
                            width: 41.0,
                            height: 41.0,
                            child: RawMaterialButton(
                              shape: CircleBorder(),
                              fillColor: Theme.of(context).buttonColor,
                              child: Icon(Icons.keyboard_arrow_right, color: Theme.of(context).iconTheme.color,),
                              onPressed: () async {
                                await appData.nextChapter();
                                setState(() {
                                  _scrollController.animateTo(0, duration: Duration(seconds: 1), curve: Curves.ease);
                                });
                              },
                            )),
                      ],
                    ),
                  ),
                  body: Scrollbar(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollNotification) {
                        if (scrollNotification is ScrollStartNotification) {
                          _onStartScroll(scrollNotification.metrics);
                        } else if (scrollNotification is ScrollUpdateNotification) {
                          _onUpdateScroll(scrollNotification.metrics);
                        } else if (scrollNotification is ScrollEndNotification) {
                          _onEndScroll(scrollNotification.metrics);
                        }
                        return true;
                      },
                      child: CustomScrollView(
                        controller: _scrollController,
                        slivers: <Widget>[
                          SliverAppBar(
                            forceElevated: false,
                            floating: true,

                            actions: <Widget>[
//                              Container(
//                                child: Row(
//                                  children: <Widget>[
//                                    RaisedButton(
//                                        elevation: 0.0,
//                                        onPressed: () {
//                                          Navigator.pushNamed(context, 'books', arguments: {
//                                            'snapshot' : snapshot,
//                                            'scrollController' : _scrollController
//                                          });
//                                        },
//                                        child: Row(
//                                          mainAxisSize: MainAxisSize.min,
//                                          crossAxisAlignment: CrossAxisAlignment.center,
//                                          children: <Widget>[
//                                            Text(
//                                                '${intToBook[appData.getBookNumber]} ${appData.getChapterNumber}',
//                                                style: Theme.of(context).textTheme.button
//                                            ),
//
//                                            Icon(Icons.arrow_drop_down, color: Theme.of(context).iconTheme.color),
//                                          ],
//                                        )
//                                    ),
//                                  ],
//                                ),
//                              ),

                              FlatButton(
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                        '${intToBook[appData.getBookNumber]} ${appData.getChapterNumber}',
                                        style: Theme.of(context).textTheme.button
                                    ),

                                    Icon(Icons.arrow_drop_down, color: Theme.of(context).iconTheme.color),

                                  ],
                                ),


                                onPressed: () {
                                  Navigator.pushNamed(context, 'books', arguments: {
                                    'snapshot' : snapshot,
                                    'scrollController' : _scrollController
                                  });
                                },
                              ),
                              Spacer(),

                              Container(
                                width: 60.0,
                                height: 60.0,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100)),
                                  elevation: 0,
                                  child: Icon(Icons.color_lens, color: Theme.of(context).iconTheme.color),
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'styles');
                                  },
                                ),
                              ),
                            ],
                          ),
                          BookViewer(snapshot: snapshot),

                          SliverToBoxAdapter(
                            child: ChapterFooter(),
                          )
                        ],
                      ),
                    )
                  )
              ),
            ),
          );
        }

        return Center(
          child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).appBarTheme.color,
            ),

            body: Center(
                child: CircularProgressIndicator()
            ),
          )
        );
      },
    );
  }

  _onStartScroll(ScrollMetrics metrics) {

  }

  _onUpdateScroll(ScrollMetrics metrics) {

  }

  _onEndScroll(ScrollMetrics metrics) {
    appData.scrollOffset = _scrollController.offset;
    appData.saveData();
  }
}