import 'package:flutter/material.dart';
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
    
    return IntrinsicHeight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
          this.title == null ? SizedBox() : textToTitle(
            context: context,
            fontSize: this.fontSize,
            height: this.fontHeight,
            letterSeparation: this.fontLetterSeparation,
            text: this.title
          ),

          IntrinsicHeight(
            child: Row(
              children: [
                AnimatedContainer(
                  color: Theme.of(context).textTheme.bodyText2.color,
                  height: double.infinity,
                  width: this.selected ? 5 : 0,
                  duration: Duration(milliseconds: 150),
                ),

                Flexible(
                  child: InkWell(
                    onTap: this.onTap,
                    onLongPress: this.onLongPress,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
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
                                fontWeight: FontWeight.normal,
                                backgroundColor: (this.highlight)
                                  ? colorHighlight
                                  : Colors.transparent,
                                color: (this.highlight)
                                  ? Theme.of(context).brightness == Brightness.light
                                    ? Theme.of(context).textTheme.bodyText1.color
                                    : Theme.of(context).canvasColor
                                  : Theme.of(context).textTheme.bodyText1.color,
                                // decorationColor: Colors.pink
                              )
                            ),
                          ]
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget textToTitle({BuildContext context, String text, double height, double fontSize, double letterSeparation}){
    List<String> split = text.split('\n');
    List<Widget> widgets = [];


    split.forEach((element)
    {
      if(element.split(' ')[0] == '#title_big') 
      {
        widgets.add(
          Container(
            width: double.infinity,
            child: RichText(
              text: TextSpan(
                text: element.replaceAll('#title_big ', ''),
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.bold,
                  height: height,
                  fontSize: fontSize + 5,
                  letterSpacing: letterSeparation
                ),
              ),
            ),
          ),
        );
      }

      else if(element.split(' ')[0] == '#subtitle')
      {
        widgets.add(
          Container(
            width: double.infinity,
            child: RichText(
              text: TextSpan(
                text: element.replaceAll('#subtitle ', ''),
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontFamily: 'Roboto-Italic',
                  fontStyle: FontStyle.italic,
                  height: height,
                  fontSize: fontSize,
                  letterSpacing: letterSeparation,
                ),
              ),
            ),
          ),
        );

        widgets.add(
          Container(height: height * 10)
        );
      }

      else if(element.split(' ')[0] == '#center')
      {
        widgets.add(
          Container(
            width: double.infinity,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: element.replaceAll('#center ', ''),
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.bold,
                  height: height,
                  fontSize: fontSize,
                  letterSpacing: letterSeparation
                ),
              ),
            ),
          )
        );
      }

      else{
        widgets.add(
          RichText(
            text: TextSpan(
              text: element,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.bold,
                height: height,
                fontSize: fontSize,
                letterSpacing: letterSeparation
              ),
            ),
          ),
        );
      }
    });

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 6.0, 0, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgets
        ),
      ),
    );
  }
}