import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:yhwh/data/Data.dart';
import 'package:yhwh/data/Styles.dart' as styles;
import 'package:flutter/material.dart';
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
        => widget.snapshot.data.chapters[appData.getChapterNumber - 1].versos[item],
          childCount: widget.snapshot.data.chapters[appData.getChapterNumber - 1].versos.length,
        )
    );
  }
}