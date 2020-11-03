import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;

class DocViewer extends StatefulWidget {
  DocViewer({
    this.link,
    Key key
  }) : super(key: key);

  final String link;

  @override
  _DocViewerState createState() => _DocViewerState();
}

class _DocViewerState extends State<DocViewer> {

  String data = '';

  @override
  void initState() {
    http.read(widget.link).then((response){
      setState(() {
        data = response;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Lectura'),),
      body: data != '' ? Container(
        child: Scrollbar(
          child: Markdown(
            data: data,
            padding: EdgeInsets.fromLTRB(12, 12, 12, 55),
            selectable: true,
            styleSheet: MarkdownStyleSheet(
              h1: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: 28
              ),
              h2: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: 26
              ),
              h3: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: 24
              ),
              h4: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: 22
              ),
              h5: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: 20
              ),
              h6: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: 18
              ),

              p: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: 16
              ),

              listBullet: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: 16
              ),

              blockquoteDecoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.color,
                borderRadius: BorderRadius.circular(8)
              ),

              blockSpacing: 12,
              textScaleFactor: 1

            ),
          ),
        ),
      )
      
      : Padding(
        padding: EdgeInsets.symmetric(vertical: 25),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      )

    );
  }
}