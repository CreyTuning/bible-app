import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:yhwh/data/Data.dart';
import 'package:yhwh/data/Styles.dart' as styles;
import 'package:flutter/material.dart';
import 'package:yhwh/ui_widgets/ui_verse.dart';

class BookViewer extends StatelessWidget {
  AsyncSnapshot snapshot;

  BookViewer({this.snapshot});

  @override
  Widget build(BuildContext context)
  {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, item)
        => snapshot.data.chapters[appData.getChapterNumber - 1].versos[item],
          childCount: snapshot.data.chapters[appData.getChapterNumber - 1].versos.length,
        )
    );
  }
}