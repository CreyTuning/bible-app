import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yhwh/data/Define.dart';
import 'package:yhwh/pages/BiblePage/BookSelection.dart';
import 'package:yhwh/pages/BiblePage/HighlightPage.dart';
import 'package:yhwh/pages/BiblePage/StylePage/StylePage.dart';
import 'package:yhwh/pages/BiblePage/StylePage/fontPreference.dart';
import 'package:yhwh/ui_widgets/SliverFloatingBarLocal.dart';
import 'package:yhwh/ui_widgets/chapter_footer.dart';
import 'BookViewer.dart';


class BiblePage extends StatefulWidget {
  BiblePage({
    this.autoScrollController
  });

  final AutoScrollController autoScrollController;

  @override
  _BiblePageState createState() => _BiblePageState();
}

class _BiblePageState extends State<BiblePage> {
  
  List<int> getReference() => [bookNumber, chapterNumber, verseNumber];
  int bookNumber = 0;
  int chapterNumber = 0;
  int verseNumber = 0;


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

  void setReference(int book, int chapter, int verse){
    SharedPreferences.getInstance().then((preferences){
      setState(() {
        preferences.setInt('bookNumber', book);
        preferences.setInt('chapterNumber', chapter);
        preferences.setInt('verseNumber', verse);
        
        bookNumber = book;
        chapterNumber = chapter;
        verseNumber = verse;

        if(verse != 1)
          widget.autoScrollController.scrollToIndex(verse - 1, preferPosition: AutoScrollPosition.begin);
        else{
          widget.autoScrollController.animateTo(0, duration: Duration(milliseconds: 700), curve: Curves.easeOut);
        }
      });
    });
  }

  void nextChapter(){
    widget.autoScrollController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    
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
    widget.autoScrollController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.easeOut);

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

  void updateState() => setState((){});

  @override
  Widget build(BuildContext context) {
    
    if(bookNumber == 0 && chapterNumber == 0)
      return Center(child: CircularProgressIndicator());

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark 
    ));

    
    return Container(
      color: Theme.of(context).canvasColor,
      child: SafeArea(
        top: true,
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                AnimatedOpacity(
                  opacity: (bookNumber == 1 && chapterNumber == 1) ? 0.0 : 1.0,
                  duration: Duration(milliseconds: 300),
                  child: Container(
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
                        ),
                        
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 1,
                          spreadRadius: 0
                        )
                      ]
                    ),

                    child: MaterialButton(
                      elevation: 0,
                      onPressed: previousChapter,
                      color: Theme.of(context).floatingActionButtonTheme.backgroundColor,

                      child: Icon(
                        Icons.keyboard_arrow_left,
                        color: Theme.of(context).textTheme.bodyText1.color,
                        size: 24,
                      ),
                      padding: EdgeInsets.all(0),
                      shape: CircleBorder(),
                    ),
                  ),
                ),

                Expanded(child: SizedBox.fromSize()),

                AnimatedOpacity(
                  opacity: (bookNumber == 66 && chapterNumber == 22) ? 0.0 : 1.0,
                  duration: Duration(milliseconds: 300),
                  child: Container(
                    width: 41.0,
                    height: 41.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 2,
                          offset: Offset.fromDirection(1, 2)
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 1,
                          spreadRadius: 0
                        )
                      ]
                    ),

                    child: MaterialButton(
                      elevation: 0,
                      onPressed: nextChapter,
                      color: Theme.of(context).floatingActionButtonTheme.backgroundColor,

                      child: Icon(
                        Icons.keyboard_arrow_right,
                        color: Theme.of(context).textTheme.bodyText1.color,
                        size: 24,
                      ),
                      padding: EdgeInsets.all(0),
                      shape: CircleBorder(),
                    ),
                  )
                ),

              ],
            ),
          ),

          body: Scrollbar(
            child: CustomScrollView(
              controller: widget.autoScrollController,
              slivers: [
                SliverFloatingBarLocal(
                  backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                  floating: true,
                  snap: true,
                  elevation: 4,



                  title: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                            child: Container(
                              height: 40,//double.infinity,
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  text: '${intToBook[bookNumber]} $chapterNumber',
                                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                                    fontFamily: 'Roboto-Medium',
                                    fontSize: 16.6,
                                    height: 1.4
                                  ),
                                )
                              ),
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

                          onLongPress: () {},
                          
                        ),
                      ),
                      
                      // Spacer(),

                      InkWell(
                        child: Container(
                          child: Icon(Icons.folder, color: Theme.of(context).iconTheme.color, size: 21),
                          width: 40,
                          height: 40,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HighlightPage(setReference: setReference)));
                        },
                      ),

                      InkWell(
                        child: Container(
                          // child: Icon(Icons.font_download, color: Theme.of(context).iconTheme.color, size: 21,),
                          child: Center(
                            child: Text('Aa',
                              style: Theme.of(context).textTheme.bodyText1.copyWith(
                                fontSize: 17
                              )
                            ),
                          ),
                          width: 40,
                          height: 40,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FontPreference(updateStateInBiblePage: updateState))); //StylePage(updateStateInBiblePage: updateState)));
                        },
                      ),
                    ],
                  )
                ),

                BookViewer(
                  bookNumber: bookNumber,
                  chapterNumber: chapterNumber,
                  verseNumber: verseNumber,
                  chapterFooter: ChapterFooter(),
                  autoScrollController: widget.autoScrollController,
                ),

              ],
            ),
          ),
        ),
      ),
    );




    
    // return Scaffold(
    //   extendBody: true,
    //   floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    //   floatingActionButton: Padding(
    //     padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: <Widget>[
    //         AnimatedOpacity(
    //           opacity: (bookNumber == 1 && chapterNumber == 1) ? 0.0 : 1.0,
    //           duration: Duration(milliseconds: 300),
    //           child: Container(
    //             width: 41.0,
    //             height: 41.0,
    //             decoration: BoxDecoration(
    //               color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
    //               borderRadius: BorderRadius.circular(100),
    //               boxShadow: [
    //                 BoxShadow(
    //                   color: Colors.black.withOpacity(0.5),
    //                   blurRadius: 2,
    //                   offset: Offset.fromDirection(2, 2)
    //                 )
    //               ]
    //             ),

    //             child: MaterialButton(
    //               elevation: 0,
    //               onPressed: previousChapter,
    //               color: Theme.of(context).floatingActionButtonTheme.backgroundColor,

    //               child: Icon(
    //                 Icons.keyboard_arrow_left,
    //                 color: Theme.of(context).textTheme.bodyText1.color,
    //                 size: 24,
    //               ),
    //               padding: EdgeInsets.all(0),
    //               shape: CircleBorder(),
    //             ),
    //           ),
    //         ),

    //         Expanded(child: SizedBox.fromSize()),

    //         AnimatedOpacity(
    //           opacity: (bookNumber == 66 && chapterNumber == 22) ? 0.0 : 1.0,
    //           duration: Duration(milliseconds: 300),
    //           child: Container(
    //             width: 41.0,
    //             height: 41.0,
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(100),
    //               boxShadow: [
    //                 BoxShadow(
    //                   color: Colors.black.withOpacity(0.5),
    //                   blurRadius: 2,
    //                   offset: Offset.fromDirection(1, 2)
    //                 )
    //               ]
    //             ),

    //             child: MaterialButton(
    //               elevation: 0,
    //               onPressed: nextChapter,
    //               color: Theme.of(context).floatingActionButtonTheme.backgroundColor,

    //               child: Icon(
    //                 Icons.keyboard_arrow_right,
    //                 color: Theme.of(context).textTheme.bodyText1.color,
    //                 size: 24,
    //               ),
    //               padding: EdgeInsets.all(0),
    //               shape: CircleBorder(),
    //             ),
    //           )
    //         ),

    //       ],
    //     ),
    //   ),

    //   appBar: AppBar(
    //     backgroundColor: Theme.of(context).appBarTheme.color,
    //     actions: <Widget>[

    //       InkWell(
    //         borderRadius: BorderRadius.circular(10),
    //         child: Padding(
    //           padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
    //           child: Row(
    //             children: <Widget>[

    //               RichText(
    //                 overflow: TextOverflow.ellipsis,
    //                 text: TextSpan(
    //                   text: '${intToBook[bookNumber]} $chapterNumber',
    //                   style: Theme.of(context).textTheme.bodyText1.copyWith(
    //                     fontFamily: 'Roboto-Medium',
    //                     fontSize: 16.6,
    //                   ),
    //                 )
    //               ),

    //               Icon(Icons.arrow_drop_down, color: Theme.of(context).iconTheme.color, size: 20,),
    //             ],
    //           ),
    //         ),

    //         onTap: () {
    //           Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => BookSelectionPage(
    //                 initialTab: 0,
    //                 setReference: setReference,
    //                 getReference: getReference,
    //               )
    //             )
    //           );
    //         },

    //         onLongPress: () {

    //           // showDialog(

    //           //   context: context,
    //           //   child: Padding(

    //           //     padding: EdgeInsets.all(20),

    //           //     child: SecondaryBookSelectionPage(
    //           //       initialTab: 0,
    //           //     )
    //           //   )
    //           // );
    //         },
            
    //       ),
          
    //       Spacer(),

    //       Padding(
    //         padding: EdgeInsets.symmetric(vertical: 3),
    //         child: InkWell(
    //           child: Container(
    //             child: Icon(Icons.bookmark, color: Theme.of(context).iconTheme.color, size: 21,),
    //             width: 50
    //           ),
    //           borderRadius: BorderRadius.circular(30),
    //           onTap: () {
    //             Navigator.push(context, MaterialPageRoute(builder: (context) => HighlightPage()));
    //           },
    //           onLongPress: () {},
    //         ),
    //       ),

    //       Padding(
    //         padding: EdgeInsets.symmetric(vertical: 3),
    //         child: InkWell(
    //           child: Container(
    //             child: Icon(Icons.tune, color: Theme.of(context).iconTheme.color, size: 21,),
    //             width: 50
    //           ),
    //           borderRadius: BorderRadius.circular(30),
    //           onTap: () {
    //             Navigator.push(context, MaterialPageRoute(builder: (context) => StylePage(setTextFormat: setTextFormat)));
    //           },
    //           onLongPress: () {},
    //         ),
    //       ),

    //       SizedBox(width: 5),

    //     ],
    //   ),

    //   body: BookViewer(
    //     bookNumber: bookNumber,
    //     chapterNumber: chapterNumber,
    //     verseNumber: verseNumber,
    //     chapterFooter: ChapterFooter(),
    //     autoScrollController: widget.autoScrollController,
    //   ),
    // );
  }
}