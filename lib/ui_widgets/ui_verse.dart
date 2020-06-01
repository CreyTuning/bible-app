import 'package:flutter/material.dart';

class UiVerse extends StatefulWidget{
  final int number;
  final String text;
  final String title;

  final String fontFamily;
  final double fontSize;
  final double height;
  final double letterSeparation;

  final Color color;
  final Color colorOfNumber;

  final double separation;


  UiVerse({
    @required this.number,
    @required this.text,
    @required this.title,

    this.fontFamily = 'Roboto',
    this.fontSize = 20.0,
    this.height  = 1.8,
    this.letterSeparation = 0,

    this.color = const Color(0xff263238),
    this.colorOfNumber = const Color(0xaf37474F),

    this.separation = 5.0,
  });

  _UiVerseState createState() => _UiVerseState();
}

class _UiVerseState extends State<UiVerse>{
  @override
  Widget build(BuildContext context)
  {
    List<Widget> content = <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: RichText(
          softWrap: true,
          overflow: TextOverflow.visible,
          textAlign: TextAlign.start,

          text: TextSpan(
            style: TextStyle(
                fontSize: this.widget.fontSize,
                color: this.widget.color,
                fontFamily: this.widget.fontFamily,
                height: this.widget.height,
                letterSpacing: this.widget.letterSeparation
            ),

            children: [
              TextSpan( // Numero de versiculo
                  text: this.widget.number.toString(),
                  style: TextStyle(
                      color: this.widget.colorOfNumber,
                      fontSize: this.widget.fontSize - 7.0
                  )
              ),


              TextSpan( // Texto del versiculo
                  text: " ${this.widget.text}"
              )
            ]
          ),
        ),
      ),

      Divider(color: Color(0x00), height: widget.separation,)
    ];

    
    
    if(widget.title != null){
      content.insert(0,
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: ListTile(
            title: Text(
              widget.title,
              style: Theme.of(context).textTheme.headline5.copyWith(
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      );
    }

    return InkWell(
      // onDoubleTap: (){print(widget.text);},
      // radius: 40,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: content,
      ),
    );
  }
}