import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:yhwh/data/Define.dart';
import 'package:yhwh/ui_widgets/chapter_footer.dart';
import 'package:yhwh/ui_widgets/ui_verse.dart';

class BookViewer extends StatefulWidget {
  BookViewer({
    @required this.bookNumber,
    @required this.chapterNumber,
    @required this.chapterFooter,
  });
  
  final ChapterFooter chapterFooter;
  final int bookNumber;
  final int chapterNumber;

  _BookViewerState createState() => _BookViewerState();
}

class _BookViewerState extends State<BookViewer> {

  List<Widget> content = List<Widget>();
  Future getChapter(int book, int chapter) async => json.decode(await rootBundle.loadString(intToBookPath[book]))['chapters'][chapter - 1]['verses'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getChapter(widget.bookNumber, widget.chapterNumber),
      builder: (BuildContext buildContext, AsyncSnapshot asyncSnapshot)
      {
        if(asyncSnapshot.hasData)
        {
          content = [];

          // Cargar versiculos
          asyncSnapshot.data.forEach((verso) {
            
            content.add(
              UiVerse(
                title: titles[widget.bookNumber][widget.chapterNumber].containsKey(int.tryParse(verso['id'].split(':')[1])) == true ? titles[widget.bookNumber][widget.chapterNumber][int.tryParse(verso['id'].split(':')[1])] : null,
                number: int.tryParse(verso['id'].split(':')[1]),
                text: verso['text'].replaceAll('\n', ''),
                color: Theme.of(context).textTheme.bodyText1.color,
                colorOfNumber: Theme.of(context).textTheme.bodyText2.color,
                fontSize: 20.0,
                height: 1.8,
                letterSeparation: 0,
              )
            );
          });


          
          
          // Agregar pie de pagina
          content.add(widget.chapterFooter);
          return SliverList(delegate: SliverChildListDelegate(content));
        }

        else return SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(top: 100),
            child: Center(
              child: CircularProgressIndicator()
            ),
          ),
        );
      },
    );
  }
}