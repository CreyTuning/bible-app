import 'package:flutter/cupertino.dart';
import 'package:yhwh/data/Data.dart';
import 'package:flutter/material.dart';
import 'package:yhwh/ui_widgets/chapter_footer.dart';
import 'package:yhwh/ui_widgets/ui_verse.dart';

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
        delegate: SliverChildBuilderDelegate((context, item)
        {
            return UiVerse(
              number: widget.snapshot.data.chapters[appData.getChapterNumber - 1].versos[item][0],
              text: widget.snapshot.data.chapters[appData.getChapterNumber - 1].versos[item][1],
              color: Theme.of(context).textTheme.body2.color,
              colorOfNumber: Theme.of(context).textTheme.body1.color,
              fontSize: appData.fontSize,
              height: appData.fontHeight,
              letterSeparation: appData.fontLetterSpacing,
            );
        },
          childCount: widget.snapshot.data.chapters[appData.getChapterNumber - 1].versos.length,
      ),
    );


  }
}