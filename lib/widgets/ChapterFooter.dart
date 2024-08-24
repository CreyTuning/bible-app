import 'package:flutter/material.dart';
import 'package:yhwh/data/Define.dart';

class ChapterFooter extends StatefulWidget {
  ChapterFooter({
    Key key,
    this.bibleVersion
  }) : super(key: key);

  final String bibleVersion;

  @override
  _ChapterFooterState createState() => _ChapterFooterState();
}

class _ChapterFooterState extends State<ChapterFooter> {

  @override
  Widget build(BuildContext context) {

    if(widget.bibleVersion == null){
      return Column(
        children: <Widget>[
          Divider(height: 25, color: Color(0x00)),
          
          Center(
            child: CircularProgressIndicator(),
          ),

          Container(
            height: MediaQuery.of(context).size.height / 5
          )
        ],
      );
    }

    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          Divider(height: 25, color: Color(0x00)),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RichText(
                text: TextSpan(
                  text: '${versionToName[widget.bibleVersion]} ©\nPronto el texto sera revisado y corregido para ofrecer una traducción sin errores y fiel a la Palabra de Dios.',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Baloo',
                      color: Theme.of(context).textTheme.bodyText2.color,
                      height: 1.2
                  )
                ),
                textAlign: TextAlign.center,
              )
          ),

          TextButton(
            child: Text('Más información',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Baloo',
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyText1.color
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