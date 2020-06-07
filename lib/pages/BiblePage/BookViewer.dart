import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:yhwh/data/Define.dart';
import 'package:yhwh/ui_widgets/chapter_footer.dart';
import 'package:yhwh/ui_widgets/ui_verse.dart';

class BookViewer extends StatefulWidget {
  BookViewer({
    @required this.bookNumber,
    @required this.chapterNumber,
    @required this.chapterFooter,
    @required this.itemScrollController,
    @required this.verseNumber
  });
  
  final ChapterFooter chapterFooter;
  final int bookNumber;
  final int chapterNumber;
  final int verseNumber;
  final ItemScrollController itemScrollController;
  
  _BookViewerState createState() => _BookViewerState();
}

class _BookViewerState extends State<BookViewer> {
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
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
          
          content.add(
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Center(
                child: Container(
                  width: 41.0,
                  height: 41.0,
                  child: RawMaterialButton(
                    shape: CircleBorder(),
                    fillColor: Theme.of(context).bottomAppBarColor,
                    child: Icon(Icons.arrow_upward, color: Theme.of(context).iconTheme.color,),
                    onPressed: (){
                      // widget.itemScrollController.scrollTo(
                      //   index: 0,
                      //   duration: Duration(milliseconds: 350),
                      //   curve: Curves.easeOut
                      // );

                      // widget.itemScrollController.jumpTo(index: 0);
                      widget.itemScrollController.scrollTo(index: 0, duration: Duration(milliseconds: 300));
                    }
                  )
                ),
              )
            )
          );

          return Scrollbar(
            child: ScrollablePositionedList.builder(
              initialScrollIndex: widget.verseNumber - 1,
              itemScrollController: widget.itemScrollController,
              itemPositionsListener: itemPositionsListener,
              itemCount: content.length,
              itemBuilder: (context, i) => content[i]
            ),
          );
        }

        else return Center(
          child: CircularProgressIndicator()
        );
      },
    );
  }
}