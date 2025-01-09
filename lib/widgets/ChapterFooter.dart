import 'package:flutter/material.dart';
import 'package:yhwh/data/Define.dart';

class ChapterFooter extends StatefulWidget {
  ChapterFooter({
    Key? key,
    required this.bibleVersion
  }) : super(key: key);

  final String bibleVersion;

  @override
  _ChapterFooterState createState() => _ChapterFooterState();
}

class _ChapterFooterState extends State<ChapterFooter> {

  @override
  Widget build(BuildContext context) {

    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          Divider(height: 25, color: Color(0x00)),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RichText(
                text: TextSpan(
                  text: 'Antiguo y Nuevo Testamento\nAntigua Versión de Casiodoro de Reina (1569)\nRevisada por Cipriano de Valera (1602)\nOtra revisiones: 1862, 1909 y 1960',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Baloo',
                      color: Theme.of(context).indicatorColor.withValues(alpha: 0.7),
                      height: 1.2
                  )
                ),
                textAlign: TextAlign.center,
              )
          ),

          TextButton(
            child: Text('${versionToName[widget.bibleVersion]} ©',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Baloo',
                fontWeight: FontWeight.bold,
                color: Theme.of(context).indicatorColor.withValues(alpha: 0.9),
              )
            ),
            onPressed: null,
          ),

          Container(
            height: MediaQuery.of(context).size.height / 5
          )
        ],
      ),
    );
  }
}