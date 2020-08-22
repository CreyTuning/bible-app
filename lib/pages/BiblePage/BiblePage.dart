import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yhwh/data/Define.dart';
import 'package:yhwh/pages/BiblePage/BookSelection.dart';
import 'package:yhwh/pages/BiblePage/HighlightPage.dart';
import 'package:yhwh/pages/BiblePage/SecondaryBookSelection.dart';
import 'package:yhwh/pages/BiblePage/StylePage.dart';
import 'package:yhwh/ui_widgets/ScrollableListEdited/scrollable_positioned_list.dart';
import 'package:yhwh/ui_widgets/chapter_footer.dart';
import 'BookViewer.dart';


class BiblePage extends StatefulWidget {
  BiblePage({
    this.scrollController
  });

  final ScrollController scrollController;

  @override
  _BiblePageState createState() => _BiblePageState();
}

class _BiblePageState extends State<BiblePage> {
  
  int bookNumber = 0;
  int chapterNumber = 0;
  int verseNumber = 0;
  ItemScrollController itemScrollController = ItemScrollController();


  @override
  void initState() {
    SharedPreferences.getInstance().then((preferences){
      setState(() {
        bookNumber = preferences.getInt('bookNumber') ?? 1;
        chapterNumber = preferences.getInt('chapterNumber') ?? 1;
        verseNumber = preferences.getInt('verseNumber') ?? 1;
      });
    });
    super.initState();
  }

  List<int> getReference() => [bookNumber, chapterNumber, verseNumber];

  void setReference(int book, int chapter, int verse){
    SharedPreferences.getInstance().then((preferences){
      setState(() {
        preferences.setInt('bookNumber', book);
        preferences.setInt('chapterNumber', chapter);
        preferences.setInt('verseNumber', verse);
        
        bookNumber = book;
        chapterNumber = chapter;
        verseNumber = verse;
      
        itemScrollController.jumpTo(index: verse - 1);
      });
    });
  }

  void nextChapter(){
    widget.scrollController.jumpTo(0);
    itemScrollController.jumpTo(index: 0);
    
    SharedPreferences.getInstance().then((preferences){
      if (chapterNumber < namesAndChapters[bookNumber - 1][1]) {
        chapterNumber++;
        verseNumber = 1;
        preferences.setInt('chapterNumber', chapterNumber);
        preferences.setInt('verseNumber', verseNumber);
      }

      else if (chapterNumber == namesAndChapters[bookNumber - 1][1]) {
        if (bookNumber < 66) {
          bookNumber += 1;
          chapterNumber = 1;
          verseNumber = 1;
          preferences.setInt('bookNumber', bookNumber);
          preferences.setInt('chapterNumber', chapterNumber);
          preferences.setInt('verseNumber', verseNumber);
        }
      }
    });

    setState(() {
      
    });
  }

  void previousChapter(){
    widget.scrollController.jumpTo(0);
    itemScrollController.jumpTo(index: 0);
    // widget.scrollController.jumpTo(widget.scrollController.offset - 73);

    SharedPreferences.getInstance().then((preferences){
      if (chapterNumber > 1) {
        chapterNumber--;
        preferences.setInt('chapterNumber', chapterNumber);
      }

      else if (chapterNumber == 1)
      {
        if(bookNumber > 1)
        {
          bookNumber -= 1;
          chapterNumber = namesAndChapters[bookNumber - 1][1];
          preferences.setInt('bookNumber', bookNumber);
          preferences.setInt('chapterNumber', chapterNumber);
        }
      }
    });

    setState(() {
      
    });
  }

  void setTextFormat(double fontSize, double fontHeight, double fontLetterSpacing){
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    
    if(bookNumber == 0 && chapterNumber == 0)
      return Center(child: CircularProgressIndicator());

    return Scaffold(
      // extendBodyBehindAppBar: true,
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            (bookNumber == 1 && chapterNumber == 1) ? SizedBox() :
            Container(
              width: 41.0,
              height: 41.0,
              decoration: BoxDecoration(
                color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 2,
                    offset: Offset.fromDirection(2, 2)
                  )
                ]
              ),

              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                child: Icon(Icons.keyboard_arrow_left, color: Theme.of(context).textTheme.bodyText1.color),
                onTap: previousChapter,
              )
            ),

            Expanded(child: SizedBox.fromSize()),

            (bookNumber == 66 && chapterNumber == 22) ? SizedBox() :

            Container(
              width: 41.0,
              height: 41.0,
              decoration: BoxDecoration(
                color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 2,
                    offset: Offset.fromDirection(1, 2)
                  )
                ]
              ),

              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                child: Icon(Icons.keyboard_arrow_right, color: Theme.of(context).textTheme.bodyText1.color,),
                onTap: nextChapter,
              )
            ),

          ],
        ),
      ),

      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.color.withOpacity(0.95),
        actions: <Widget>[

          InkWell(
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Row(
                children: <Widget>[
                  Text(
                    '${intToBook[bookNumber]} $chapterNumber', style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontFamily: 'Roboto-Medium',
                      fontSize: 16.6,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down, color: Theme.of(context).iconTheme.color, size: 20,),
                ],
              ),
            ),

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookSelectionPage(
                    initialTab: 0,
                    setReference: setReference,
                    getReference: getReference,
                  )
                )
              );
            },

            onLongPress: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => SecondaryBookSelectionPage(
              //       initialTab: 0,
              //     )
              //   )
              // );

              showDialog(

                context: context,
                child: Padding(

                  padding: EdgeInsets.all(20),

                  child: SecondaryBookSelectionPage(
                    initialTab: 0,
                  ),

                )
              );
            },
            
          ),
          
          Spacer(),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: InkWell(
              child: Container(
                child: Icon(Icons.bookmark, color: Theme.of(context).iconTheme.color, size: 21,),
                width: 50,
              ),
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HighlightPage()));
              },
              onLongPress: () {},
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: InkWell(
              child: Container(
                child: Icon(Icons.settings, color: Theme.of(context).iconTheme.color, size: 21,),
                width: 50,
              ),
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => StylePage(setTextFormat: setTextFormat)));
              },
              onLongPress: () {},
            ),
          ),

          SizedBox(width: 5,)

        ],
      ),

      body: BookViewer(
        bookNumber: bookNumber,
        chapterNumber: chapterNumber,
        verseNumber: verseNumber,
        chapterFooter: ChapterFooter(),
        itemScrollController: itemScrollController,
        scrollController: widget.scrollController,
      ),
    );
  }
}