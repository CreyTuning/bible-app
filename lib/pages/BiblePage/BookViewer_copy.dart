// import 'dart:convert';
// import 'dart:math';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/material.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:yhwh/data/Define.dart';
// import 'package:yhwh/data/Titles.dart';
// import 'package:yhwh/ui_widgets/chapter_footer.dart';
// import 'package:yhwh/ui_widgets/ui_verse.dart';

// class BookViewerSliver extends StatefulWidget {
//   BookViewerSliver({
//     @required this.bookNumber,
//     @required this.chapterNumber,
//     @required this.chapterFooter,
//     @required this.scrollController,
//     @required this.verseNumber
//   });
  
//   final ChapterFooter chapterFooter;
//   final int bookNumber;
//   final int chapterNumber;
//   final int verseNumber;
//   final ScrollController scrollController;
  
//   _BookViewerSliverState createState() => _BookViewerSliverState();
// }

// class _BookViewerSliverState extends State<BookViewerSliver> {
//   List<Widget> content = List<Widget>();

//   void _scrollListener(){
//     print('algo');
//   }

//   @override
//   void initState() {
//     widget.scrollController.addListener(_scrollListener);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {

//     content.clear();

//     for(int i = 0; i < 12; i++){
//       content.add(
//         Container(
//           height: Random().nextInt(120).toDouble() + 55,
//           color: Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255), Random().nextInt(255)),
//         )
//       );
//     }
    
//     return NotificationListener(
//       onNotification: (Notification notification){
//         if(notification is ScrollStartNotification){
//           print('se movio algo');
//         }

//         return true;
//       },
//       child: SliverList(
//         delegate: SliverChildBuilderDelegate(
//           (context, item){
//             return content[item];
//           },

//           childCount: content.length
//         )
//       )
//     );
//   }
// }