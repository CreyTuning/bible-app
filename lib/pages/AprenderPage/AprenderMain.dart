// import 'package:flutter/cupertino.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:yhwh/data/Define.dart';
// import 'package:yhwh/pages/BiblePage/BookSelection.dart';
// import 'package:yhwh/pages/BiblePage/BookViewer.dart';
// import 'package:yhwh/pages/BiblePage/HighlightPage.dart';
// import 'package:yhwh/pages/BiblePage/StylePage.dart';
// import 'package:yhwh/ui_widgets/ScrollAppBar.dart';
// import 'package:yhwh/ui_widgets/ScrollableListEdited/scrollable_positioned_list.dart';
// import 'package:yhwh/ui_widgets/chapter_footer.dart';
// import 'package:yhwh/ui_widgets/scroll_bars_common.dart';
// import 'package:yhwh/ui_widgets/ScrollAppBarController.dart';


// class AprenderMain extends StatefulWidget {
//   AprenderMain({
//     this.scrollController
//   });

//   final ScrollController scrollController;

//   @override
//   _AprenderMainState createState() => _AprenderMainState();
// }

// class _AprenderMainState extends State<AprenderMain> {
  
//   int bookNumber = 0;
//   int chapterNumber = 0;
//   int verseNumber = 0;
//   bool isAppBarVisible = true;
//   ItemScrollController itemScrollController = ItemScrollController();
//   bool floatingActionButtonVisible = true;


//   @override
//   void initState() {
//     SharedPreferences.getInstance().then((preferences){
//       setState(() {
//         bookNumber = preferences.getInt('bookNumber') ?? 1;
//         chapterNumber = preferences.getInt('chapterNumber') ?? 1;
//         verseNumber = preferences.getInt('verseNumber') ?? 1;
//       });
//     });

//     super.initState();
//   }

//   List<int> getReference() => [bookNumber, chapterNumber, verseNumber];

//   void setReference(int book, int chapter, int verse){
//     SharedPreferences.getInstance().then((preferences){
//       setState(() {
//         preferences.setInt('bookNumber', book);
//         preferences.setInt('chapterNumber', chapter);
//         preferences.setInt('verseNumber', verse);
        
//         bookNumber = book;
//         chapterNumber = chapter;
//         verseNumber = verse;
      
//         itemScrollController.jumpTo(index: verse);
//         widget.scrollController.jumpTo(widget.scrollController.offset - 56);
//       });
//     });
//   }

//   void nextChapter(){
//     widget.scrollController.jumpTo(0);
//     itemScrollController.jumpTo(index: 1);
//     widget.scrollController.jumpTo(widget.scrollController.offset - 56);
    
//     SharedPreferences.getInstance().then((preferences){
//       if (chapterNumber < namesAndChapters[bookNumber - 1][1]) {
//         chapterNumber++;
//         verseNumber = 1;
//         preferences.setInt('chapterNumber', chapterNumber);
//         preferences.setInt('verseNumber', verseNumber);
//       }

//       else if (chapterNumber == namesAndChapters[bookNumber - 1][1]) {
//         if (bookNumber < 66) {
//           bookNumber += 1;
//           chapterNumber = 1;
//           verseNumber = 1;
//           preferences.setInt('bookNumber', bookNumber);
//           preferences.setInt('chapterNumber', chapterNumber);
//           preferences.setInt('verseNumber', verseNumber);
//         }
//       }
//     });

//     setState(() {
      
//     });
//   }

//   void previousChapter(){
//     widget.scrollController.jumpTo(0);
//     itemScrollController.jumpTo(index: 1);
//     widget.scrollController.jumpTo(widget.scrollController.offset - 56);

//     SharedPreferences.getInstance().then((preferences){
//       if (chapterNumber > 1) {
//         chapterNumber--;
//         preferences.setInt('chapterNumber', chapterNumber);
//       }

//       else if (chapterNumber == 1)
//       {
//         if(bookNumber > 1)
//         {
//           bookNumber -= 1;
//           chapterNumber = namesAndChapters[bookNumber - 1][1];
//           preferences.setInt('bookNumber', bookNumber);
//           preferences.setInt('chapterNumber', chapterNumber);
//         }
//       }
//     });

//     setState(() {
      
//     });
//   }

//   void setTextFormat(double fontSize, double fontHeight, double fontLetterSpacing){
//     setState(() {
//     });
//   }



//   @override
//   Widget build(BuildContext context) {

//     if(bookNumber == 0 || chapterNumber == 0)
//       return Center(child: CircularProgressIndicator());

//     else return Scaffold(
//       appBar: PreferredSize(
//         child: Container(
//           color: Theme.of(context).appBarTheme.color,
//         ),
//         preferredSize: Size.fromHeight(0),
//       ),

//       body: Scaffold(
//         extendBodyBehindAppBar: true,
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         floatingActionButton: 
        
//         ValueListenableBuilder(
//           valueListenable: widget.scrollController.appBar.heightNotifier,
//           builder: (context, value, child){
//             return Visibility(
              
//               visible: (value > 0) ? true : false,
              
//               replacement: Container(
//                 height: 34.0,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).canvasColor,
//                   border: Border(
//                     top: BorderSide(
//                       color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.4)
//                     )
//                   ),
//                 ),

//                 child: Center(
//                   child: Text(
//                     '${intToBook[bookNumber]} $chapterNumber',
//                     style: Theme.of(context).textTheme.bodyText1.copyWith(
//                       fontFamily: 'Roboto-Medium',
//                       fontSize: 15,
//                       color: Theme.of(context).textTheme.bodyText1.color,
//                     ),
//                   ),
//                 ),
//               ),
              
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(16, 0, 16 , 16),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[

//                         (bookNumber == 1 && chapterNumber == 1) ? SizedBox() :
//                         Container(
//                           width: 41.0,
//                           height: 41.0,
//                           decoration: BoxDecoration(
//                             color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
//                             borderRadius: BorderRadius.circular(100),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.6),
//                                 blurRadius: 2,
//                                 offset: Offset.fromDirection(2, 2)
//                               )
//                             ]
//                           ),

//                           child: InkWell(
//                             borderRadius: BorderRadius.circular(100),
//                             child: Icon(Icons.keyboard_arrow_left, color: Theme.of(context).iconTheme.color.withOpacity(0.8)),
//                             onTap: previousChapter,
//                           )
//                         ),

//                         Expanded(child: SizedBox.fromSize()),

//                         (bookNumber == 66 && chapterNumber == 22) ? SizedBox() :

//                         Container(
//                           width: 41.0,
//                           height: 41.0,
//                           decoration: BoxDecoration(
//                             color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
//                             borderRadius: BorderRadius.circular(100),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.6),
//                                 blurRadius: 2,
//                                 offset: Offset.fromDirection(1, 2)
//                               )
//                             ]
//                           ),

//                           child: InkWell(
//                             borderRadius: BorderRadius.circular(100),
//                             child: Icon(Icons.keyboard_arrow_right, color: Theme.of(context).iconTheme.color.withOpacity(0.8)),
//                             onTap: nextChapter,
//                           )
//                         ),

//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//         ),
        
        

//         appBar: FloatingAppBar(
//           controller: widget.scrollController,
//           actions: <Widget>[

//             InkWell(
//               child: Padding(
//                 padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
//                 child: Row(
//                   children: <Widget>[
//                     Text(
//                       '${intToBook[bookNumber]} $chapterNumber', style: Theme.of(context).textTheme.bodyText1.copyWith(
//                         fontFamily: 'Roboto-Medium',
//                         fontSize: 16.6,
//                       ),
//                     ),
//                     Icon(Icons.arrow_drop_down, color: Theme.of(context).iconTheme.color, size: 20,),
//                   ],
//                 ),
//               ),

//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => BookSelectionPage(
//                       initialTab: 0,
//                       setReference: setReference,
//                       getReference: getReference,
//                     )
//                   )
//                 );
//               },

//               onLongPress: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => BookSelectionPage(
//                       initialTab: 1,
//                       setReference: setReference,
//                       getReference: getReference,
//                     )
//                   )
//                 );
//               },
              
//             ),
            
//             Spacer(),

//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 5),
//               child: InkWell(
//                 child: Container(
//                   child: Icon(Icons.folder_open, color: Theme.of(context).iconTheme.color, size: 21,),
//                   width: 50,
//                 ),
//                 borderRadius: BorderRadius.circular(30),
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => HighlightPage()));
//                 },
//                 onLongPress: () {},
//               ),
//             ),

//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 5),
//               child: InkWell(
//                 child: Container(
//                   child: Icon(Icons.tune, color: Theme.of(context).iconTheme.color, size: 21,),
//                   width: 50,
//                 ),
//                 borderRadius: BorderRadius.circular(30),
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => StylePage(setTextFormat: setTextFormat)));
//                 },
//                 onLongPress: () {},
//               ),
//             ),

//             SizedBox(width: 5,)

//           ],
//         ),

//         body: Snap(
//           controller: widget.scrollController.appBar,
//           child: BookViewer(
//             bookNumber: bookNumber,
//             chapterNumber: chapterNumber,
//             verseNumber: verseNumber,
//             chapterFooter: ChapterFooter(),
//             itemScrollController: itemScrollController,
//             scrollController: widget.scrollController,
//           ),
//         )
//       ),
      
//     );
//   }
// }