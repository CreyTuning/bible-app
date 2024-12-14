import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yhwh/controllers/BiblePageController.dart';
import 'package:yhwh/controllers/HighlighterViewerController.dart';
import 'package:yhwh/data/Define.dart';
import 'package:yhwh/data/Titles.dart';
import 'package:yhwh/widgets/Verse.dart';

class HighlighterViewerPage extends StatelessWidget {
  const HighlighterViewerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HighlighterViewerController>(
      init: HighlighterViewerController(),
      builder: (highlighterViewerController) => Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0,
          title: RichText(
            overflow: TextOverflow.fade,
            softWrap: false,

            text: TextSpan(
              // style: Theme.of(context).appBarTheme.textTheme.headline6,

              children: [
                TextSpan(
                  text: '${intToBook[highlighterViewerController.highlighterItem!.book]} ${highlighterViewerController.highlighterItem!.chapter}',
                ),

                highlighterViewerController.highlighterItem!.verses.length != 1 ? TextSpan(text: '') : TextSpan(
                  text: ':${highlighterViewerController.highlighterItem!.verses.first}',
                ),
              ]
            ),
          ), 

          leading: IconButton(
            tooltip: 'Volver',
            icon: Icon(Icons.arrow_back, color: Theme.of(context).textTheme.bodyLarge!.color),
            onPressed: Get.back,
          ),

          actions: [
            IconButton(
              tooltip: 'Abrir en la biblia',
              onPressed: highlighterViewerController.showInBible,
              icon: Icon(Icons.open_in_new_rounded),
              // iconSize: 25,
            ),
          ],

          bottom: PreferredSize(
            child: Container(
              color: Theme.of(context).dividerColor,
              height: 1.5
            ),
            
            preferredSize: Size.fromHeight(0)
          ),
        ),

        body: GetBuilder<BiblePageController>(
          init: BiblePageController(),
          builder: (biblePageController) => Scrollbar(
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: 75),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(top: (index > 0) ? highlighterViewerController.verses[index][0] != highlighterViewerController.verses[index - 1][0] + 1 ? 12.0 : 0.0 : 0.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Verse(
                    highlight: false,
                    verseNumber: highlighterViewerController.verses[index][0],
                    text: highlighterViewerController.verses[index][1],
                    title: titles[highlighterViewerController.highlighterItem!.book][highlighterViewerController.highlighterItem!.chapter].containsKey(highlighterViewerController.verses[index][0]) == true ? titles[highlighterViewerController.highlighterItem!.book][highlighterViewerController.highlighterItem!.chapter][highlighterViewerController.verses[index][0]] : "",
                    colorNumber: Theme.of(context).textTheme.bodyMedium!.color!,
                    colorText: Theme.of(context).textTheme.bodyLarge!.color!,
                    fontSize: biblePageController.fontSize,
                    fontHeight: biblePageController.fontHeight,
                    fontLetterSeparation: biblePageController.fontLetterSeparation,
                    fontFamily: biblePageController.fontFamily,
                    isFirstVerseShowed: (index == 0) ? true : false,
                  ),
                ),
              ),
        
              itemCount: highlighterViewerController.verses.length,
            )
          ),
        )
      ),
    );
  }
}