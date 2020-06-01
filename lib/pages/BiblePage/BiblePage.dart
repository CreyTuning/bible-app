import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yhwh/data/Define.dart';
import 'package:yhwh/pages/BiblePage/StylePage.dart';
import 'package:yhwh/ui_widgets/chapter_footer.dart';
import 'BookViewer.dart';


class BiblePage extends StatefulWidget {
  BiblePage();

  @override
  _BiblePageState createState() => _BiblePageState();
}

class _BiblePageState extends State<BiblePage> {
  
  int bookNumber = 0;
  int chapterNumber = 0;
  ScrollController scrollController = ScrollController(keepScrollOffset: true);


  @override
  void initState() {
    SharedPreferences.getInstance().then((preferences){
      setState(() {
        bookNumber = preferences.getInt('bookNumber') ?? 1;
        chapterNumber = preferences.getInt('chapterNumber') ?? 1;
      });
    });
    super.initState();
  }

  void nextChapter(){
    setState(() {
      SharedPreferences.getInstance().then((preferences){
        if (chapterNumber < namesAndChapters[bookNumber - 1][1]) {
          chapterNumber++;
          preferences.setInt('chapterNumber', chapterNumber);
        }

        else if (chapterNumber == namesAndChapters[bookNumber - 1][1]) {
          if (bookNumber < 66) {
            bookNumber += 1;
            chapterNumber = 1;
            preferences.setInt('bookNumber', bookNumber);
            preferences.setInt('chapterNumber', chapterNumber);
            print('$bookNumber $chapterNumber');
          }
        }
      });
    });

    scrollController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
  }

  void previousChapter(){
    setState(() {
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
            print(namesAndChapters[bookNumber - 1][1]);
            preferences.setInt('bookNumber', bookNumber);
            preferences.setInt('chapterNumber', chapterNumber);
          }
        }
      });
    });

    scrollController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
  }

  void setTextFormat(double fontSize, double fontHeight, double fontLetterSpacing){
    setState(() {
      SharedPreferences.getInstance().then((preferences){
        preferences.setDouble('fontSize', fontSize);
        preferences.setDouble('fontHeight', fontHeight);
        preferences.setDouble('fontLetterSpacing', fontLetterSpacing);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    
    if(bookNumber == 0 && chapterNumber == 0)
      return Center(child: CircularProgressIndicator());

    return Scaffold(
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
                fillColor: Theme.of(context).bottomAppBarColor,
                child: Icon(Icons.keyboard_arrow_left, color: Theme.of(context).iconTheme.color,),
                onPressed: previousChapter,
              )
            ),

            Expanded(child: SizedBox.fromSize()),

            Container(
              width: 41.0,
              height: 41.0,
              child: RawMaterialButton(
                shape: CircleBorder(),
                fillColor: Theme.of(context).bottomAppBarColor,
                child: Icon(Icons.keyboard_arrow_right, color: Theme.of(context).iconTheme.color,),
                onPressed: nextChapter,
              )
            ),
          ],
        ),
      ),

      body: Scrollbar(
        child: CustomScrollView(
          controller: scrollController,
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              forceElevated: true,
              snap: true,
              actions: <Widget>[

                FlatButton(
                  child: Row(
                    children: <Widget>[
                      Text('${intToBook[bookNumber]} $chapterNumber'),
                      Icon(Icons.arrow_drop_down, color: Theme.of(context).iconTheme.color),
                    ],
                  ),

                  onPressed: () {
                    Navigator.pushNamed(context, 'books', arguments: {
                      'scrollController' : scrollController
                    });
                  },
                ),
                
                Spacer(),

                Container(
                  width: 60.0,
                  height: 60.0,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Icon(Icons.color_lens, color: Theme.of(context).iconTheme.color),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => StylePage(setTextFormat: setTextFormat)));
                    },

                    onLongPress: (){
                      DynamicTheme.of(context).setBrightness(Theme.of(context).brightness == Brightness.dark? Brightness.light: Brightness.dark);
                      
                      SharedPreferences.getInstance().then((preferences){
                        preferences.setBool('darkMode', (DynamicTheme.of(context).brightness == Brightness.dark) ? false : true);
                      });
                    }
                  ),
                ),
              ],
            ),
          
            BookViewer(
              bookNumber: bookNumber,
              chapterNumber: chapterNumber,
              chapterFooter: ChapterFooter(),
            ),

          ],
        )
      ),
    );
  }

}