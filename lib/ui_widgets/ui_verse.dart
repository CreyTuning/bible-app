import 'package:flutter/material.dart';

class UiVerse extends StatelessWidget{
  final int number;
  final String text;

  final String fontFamily;
  final double fontSize;
  final double height;

  final Color color;
  final Color colorOfNumber;

  final double separation;


  UiVerse({
    @required this.number,
    @required  this.text,

    this.fontFamily = 'Roboto',
    this.fontSize = 20.0,
    this.height  = 1.8,

    this.color = const Color(0xff263238),
    this.colorOfNumber = const Color(0xaf37474F),

    this.separation = 5.0
  });

  @override
  Widget build(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: RichText(
            softWrap: true,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.start,

            text: TextSpan(
                style: TextStyle(
                    fontSize: this.fontSize,
                    color: this.color,
                    fontFamily: this.fontFamily,
                    height: this.height
                ),

                children: <InlineSpan>[
                  TextSpan( // Numero de versiculo
                      text: this.number.toString(),
                      style: TextStyle(
                          color: this.colorOfNumber,
                          fontSize: this.fontSize - 7.0
                      )
                  ),


                  TextSpan( // Texto del versiculo
                      text: " ${this.text}"
                  )
                ]
            ),
          ),
        ),

        Divider(color: Color(0x00), height: separation,)
      ],
    );
  }
}