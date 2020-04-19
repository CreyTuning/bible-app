import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:yhwh/data/Data.dart';
import 'package:flutter/material.dart';
import 'package:yhwh/ui_widgets/chapter_footer.dart';

class BookViewer extends StatefulWidget {
  final AsyncSnapshot snapshot;
  BookViewer({this.snapshot});

  _BookViewerState createState() => _BookViewerState();
}

class _BookViewerState extends State<BookViewer> {

  @override
  Widget build(BuildContext context)
  {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, item){
          if(item + 1 == widget.snapshot.data.chapters[appData.getChapterNumber - 1].versos.length){
            return Column(
              children: <Widget>[
                widget.snapshot.data.chapters[appData.getChapterNumber - 1].versos[item],
                ChapterFooter()
              ],
            );
          }

          return widget.snapshot.data.chapters[appData.getChapterNumber - 1].versos[item];
        },
          childCount: widget.snapshot.data.chapters[appData.getChapterNumber - 1].versos.length,
      ),
    );
  }
}