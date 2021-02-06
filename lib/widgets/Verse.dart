import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class Verse extends StatelessWidget {
  
  final int verseNumber;
  
  final String title;
  final String text;  

  final String fontFamily;
  final double fontSize;
  final double fontHeight;
  final double fontLetterSeparation;

  final Color colorText;
  final Color colorNumber;
  final Color colorHighlight;

  final bool highlight;
  final bool selected;

  final Callback onTap;
  final Callback onLongPress;
  
  const Verse({
    Key key,
    @required this.verseNumber,
    @required this.text,
    @required this.title,
    @required this.highlight,

    this.fontFamily = 'Roboto',
    this.fontSize = 20.0,
    this.fontHeight  = 1.8,
    this.fontLetterSeparation = 0,

    this.colorText = const Color(0xff263238),
    this.colorNumber = const Color(0xaf37474F),
    this.colorHighlight = Colors.pink,
    this.selected = false,

    this.onTap,
    this.onLongPress
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return InkWell(
      onTap: this.onTap,
      onLongPress: this.onLongPress,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [

          Positioned.fill(
            child: AnimatedPadding(
              duration: Duration(milliseconds: 150),
              padding: EdgeInsets.only(right: (this.selected) ? Get.size.width - 5 : Get.size.width),
              child: Container(
                color: Theme.of(context).textTheme.bodyText2.color,
              ),
            ),
          ),

          AnimatedPadding(
            duration: Duration(milliseconds: 150),
            padding: EdgeInsets.fromLTRB((this.selected) ? 17 : 12, 0, 12, 0),
            child: RichText(
              softWrap: true,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.start,

              text: TextSpan(
                style: TextStyle(
                  fontSize: this.fontSize,
                  color: this.colorText,
                  fontFamily: this.fontFamily,
                  height: this.fontHeight,
                  letterSpacing: this.fontLetterSeparation,
                ),

                children: [
                  TextSpan( // Numero de versiculo
                    text: this.verseNumber.toString(),
                    style: TextStyle(
                      fontWeight: (this.selected) ? FontWeight.bold : FontWeight.normal,
                      color: this.colorNumber,
                      fontSize: this.fontSize - 7.0,
                    )
                  ),

                  TextSpan(
                    text: ' '
                  ),

                  TextSpan(
                    text: this.text.toString(),
                    style: TextStyle(
                      fontWeight: (this.selected) ? FontWeight.bold : FontWeight.normal,
                      backgroundColor: (this.highlight)
                        ? Theme.of(context).brightness == Brightness.dark
                          ? Color(0xff00af9c).withOpacity(0.5)
                          : Colors.pink
                        : Colors.transparent,
                      color: (this.highlight)
                        ? Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).textTheme.bodyText1.color
                          : Colors.white
                        : Theme.of(context).textTheme.bodyText1.color,
                      // decorationColor: Colors.pink
                    )
                  ),
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}