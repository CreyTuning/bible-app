import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yhwh/data/Titles.dart';
import 'package:yhwh/pages/BiblePage/Classes/Highlight.dart';
import 'package:yhwh/ui_widgets/ui_verse.dart';

class BookViewer extends StatefulWidget {
  BookViewer({
    @required this.bookNumber,
    @required this.chapterNumber,
    @required this.chapterFooter,
    @required this.verseNumber,
    @required this.autoScrollController,
  });
  
  final Widget chapterFooter;
  final int bookNumber;
  final int chapterNumber;
  final int verseNumber;
  final AutoScrollController autoScrollController;
  
  _BookViewerState createState() => _BookViewerState();
}

class _BookViewerState extends State<BookViewer> {
  
  List<Widget> content = List<Widget>();
  double fontSize = 20.0;
  double height = 1.8;
  double letterSeparation = 0.0;
  Map highlight = {};


  Future getChapter(int book, int chapter) async {
    return json.decode(await rootBundle.loadString('lib/bibles/RVR60/${book}_$chapter.json'))['verses'];
  }

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
  void didUpdateWidget(BookViewer oldWidget) {
    SharedPreferences.getInstance().then((preferences){
      setState(() {
        fontSize = preferences.getDouble('fontSize') ?? 20.0;
        height = preferences.getDouble('height') ?? 1.8;
        letterSeparation = preferences.getDouble('letterSeparation') ?? 0.0;
      });
    });

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

          return Scrollbar(
            child: ListView.builder(
              itemCount: content.length,
              controller: widget.autoScrollController,
              itemBuilder: (context, index) {
                return AutoScrollTag(
                  key: ValueKey(index),
                  controller: widget.autoScrollController,
                  index: index,
                  child: content[index]
                );
              },
            ),
          );

          // return NewScrollablePositionedList.builder(
          //   initialScrollIndex: 0,
          //   itemScrollController: widget.itemScrollController,
          //   itemPositionsListener: itemPositionsListener,
          //   itemCount: content.length,
          //   itemBuilder: (context, i) => content[i],
          //   myScrollController: widget.scrollController,
          // );
        }

        else return Center(
          child: CircularProgressIndicator()
        );
      },
    );
  }
}