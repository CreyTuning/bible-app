import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:yhwh/data/Define.dart';


class BookSelectionPage extends StatefulWidget {
  BookSelectionPage({
    @required this.setReference,
    @required this.actualBook,
    @required this.actualChapter,
    @required this.actualVerse
  });

  final void Function(int book, int chapter, int verse) setReference;
  final int actualBook;
  final int actualChapter;
  final int actualVerse;

  @override
  _BookSelectionPageState createState() =>  _BookSelectionPageState();
}


class _BookSelectionPageState extends State<BookSelectionPage> with SingleTickerProviderStateMixin {
  _BookSelectionPageState();

  Future<int> getVersesCount(int book, int chapter) async => json.decode(await rootBundle.loadString(intToBookPath[book]))['chapters'][chapter - 1]['verses'].length;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Referencias'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Libro'),
              Tab(text: 'Capítulo'),
              Tab(text: 'Verso'),
            ]
          ),
        ),

        body: TabBarView(
          children: [
            
            FutureBuilder(
              future: getVersesCount(widget.actualBook, widget.actualChapter),
              builder: (BuildContext buildContext, AsyncSnapshot<int> asyncSnapshot)
              {
                return GridView.builder(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 150.0),
                  itemCount: asyncSnapshot.data,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1.15
                  ),

                  itemBuilder: (context, item) {
                    return GridTile(
                        child: FlatButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                          child: Text('${item + 1}', style: Theme.of(context).textTheme.button),
                          onPressed: () async{
                            widget.setReference(widget.actualBook, widget.actualChapter, item);
                            Navigator.pop(context);
                          },
                        )
                    );
                  }
                );
              }
            ),
            
            Container(),
            Container(),
          ]
        ),
      )
    );
  }
}

// widget.setReference(widget.actualBook, widget.actualChapter, index);