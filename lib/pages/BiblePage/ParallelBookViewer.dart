import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yhwh/data/Define.dart';
import 'package:yhwh/data/Titles.dart';
import 'package:yhwh/pages/BiblePage/Classes/Highlight.dart';
import 'package:yhwh/ui_widgets/ScrollableListEdited/item_positions_listener.dart';
import 'package:yhwh/ui_widgets/ScrollableListEdited/scrollable_positioned_list.dart';
import 'package:yhwh/ui_widgets/chapter_footer.dart';
import 'package:yhwh/ui_widgets/ui_verse.dart';

class ParallelBookViewer extends StatefulWidget {
  ParallelBookViewer({
    @required this.bookNumber,
    @required this.chapterNumber,
    @required this.chapterFooter,
    @required this.itemScrollController,
    @required this.verseNumber,
    @required this.scrollController,
  });
  
  final ChapterFooter chapterFooter;
  final int bookNumber;
  final int chapterNumber;
  final int verseNumber;
  final ItemScrollController itemScrollController;
  final ScrollController scrollController;
  
  _ParallelBookViewerState createState() => _ParallelBookViewerState();
}

class _ParallelBookViewerState extends State<ParallelBookViewer> {
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  List<Widget> content = List<Widget>();
  Future getChapter(int book, int chapter) async => json.decode(await rootBundle.loadString(intToBookPath[book]))['chapters'][chapter - 1]['verses'];

  double fontSize = 20.0;
  double height = 1.8;
  double letterSeparation = 0.0;
  Map highlight = {};

  Widget body = Center(child: CircularProgressIndicator());


  void highlightVerse(String reference){
    setState(() {
      highlight[reference] = DateTime.now().toString();
    });

    Highlight.writeHighlight(json.encode(highlight));
  }

  void deleteHighlightVerse(String reference){
    setState(() {
      highlight.remove(reference);
    });

    Highlight.writeHighlight(json.encode(highlight));
  }

  @override
  void didUpdateWidget(ParallelBookViewer oldWidget) {
    SharedPreferences.getInstance().then((preferences){
      setState(() {
        fontSize = preferences.getDouble('fontSize') ?? 20.0;
        height = preferences.getDouble('height') ?? 1.8;
        letterSeparation = preferences.getDouble('letterSeparation') ?? 0.0;
      });
    });

    widget.itemScrollController.jumpTo(index: widget.verseNumber - 1);

    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {

    SharedPreferences.getInstance().then((preferences){
      setState(() {
        fontSize = preferences.getDouble('fontSize') ?? 20.0;
        height = preferences.getDouble('height') ?? 1.8;
        letterSeparation = preferences.getDouble('letterSeparation') ?? 0.0;
      });
    });

    Highlight.readHighlight().then((value){
      
      highlight = json.decode(value);
      
      setState(() {
      });
    });

    // widget.scrollController.jumpTo(widget.scrollController.offset + 55);
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      appBar: AppBar(
        title: Text(
          '${intToBook[widget.bookNumber]} ${widget.chapterNumber}'
        ),
      ),

      body: FutureBuilder(
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
                  verseNumber: int.tryParse(verso['id'].split(':')[1]),
                  chapterNumber: widget.chapterNumber,
                  bookNumber: widget.bookNumber,
                  text: verso['text'].replaceAll('\n', ''),
                  color: Theme.of(context).textTheme.bodyText1.color,
                  colorOfNumber: Theme.of(context).textTheme.bodyText2.color,
                  fontSize: fontSize,
                  height: height,
                  letterSeparation: letterSeparation,
                  highlight: highlight.containsKey("${widget.bookNumber}:${verso['id']}") == true ? true : false,
                  highlightVerse: highlightVerse,
                  deleteHighlightVerse: deleteHighlightVerse,
                )
              );
            });
            
            
            // Agregar pie de pagina
            content.add(widget.chapterFooter);

            

            body = NewScrollablePositionedList.builder(
              initialScrollIndex: widget.verseNumber - 1,
              itemScrollController: widget.itemScrollController,
              itemPositionsListener: itemPositionsListener,
              itemCount: content.length,
              itemBuilder: (context, i) => content[i],
              myScrollController: widget.scrollController,
            );

            return body;
          }

          else return Center(
            child: CircularProgressIndicator()
          );
        },
      ),
    );
  }
}