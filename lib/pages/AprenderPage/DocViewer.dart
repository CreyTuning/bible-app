import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;

class DocViewer extends StatefulWidget {
  DocViewer({
    this.link,
    this.title,
    this.background_link,
    Key key
  }) : super(key: key);

  final String link;
  final String background_link;
  final String title;

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

    print(widget.background_link);

    return Scaffold(

      appBar: AppBar(title: Text('${widget.title}', style: TextStyle(
        color: Theme.of(context).textTheme.bodyText1.color
      ))),
      
      body: data != '' ? Container(
        child: Stack(
          children: [
            Opacity(
              opacity: 0.15,
              child: Container(
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.background_link),
                    fit: BoxFit.cover,
                  )
                )
              ),
            ),

            Scrollbar(
              child: Markdown(
                data: data,
                padding: EdgeInsets.fromLTRB(12, 12, 12, 55),
                selectable: true,
                styleSheet: MarkdownStyleSheet(
                  h1: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 24,
                    height: 1.5
                  ),
                  h2: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 22,
                    height: 1.5
                  ),
                  h3: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 20,
                    height: 1.5
                  ),
                  h4: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 18,
                    height: 1.5
                  ),
                  h5: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 16,
                    height: 1.5
                  ),
                  h6: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 14,
                    height: 1.5
                  ),

                  p: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 18,
                    height: 1.5
                  ),

                  blockquoteDecoration: BoxDecoration(
                    color: Theme.of(context).textTheme.bodyText2.color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),

                  blockquote: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 18,
                    height: 1.5
                  ),

                  listBullet: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 18,
                  ),

                  listIndent: 25,

                  blockquotePadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  blockSpacing: 15,
                  textScaleFactor: 1,

                ),
              ),
            ),
          ],
        )
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