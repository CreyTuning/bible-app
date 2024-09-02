import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:yhwh/classes/BibleManager.dart';
import 'package:yhwh/controllers/BiblePageController.dart';
import 'package:yhwh/data/Define.dart';

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

    this.fontFamily = 'Nunito',
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

                        text: HTML.toTextSpan(
                          context,
                          '<vn>$verseNumber&nbsp;</vn><ctn>${this.text.toString()}</ctn>'.replaceAll('<p style="text-align:center;">', '').replaceAll('</p>', '').replaceAll('<p style="text-align:right;">', '').replaceAll('<br />', '').replaceAll('*', ''),//.replaceAll('Jehová', 'Yahweh'),
                          defaultTextStyle: TextStyle(
                            fontSize: this.fontSize,
                            color: this.colorText,
                            fontFamily: this.fontFamily,
                            height: this.fontHeight,
                            letterSpacing: this.fontLetterSeparation,
                          ),

                          overrideStyle: {

                            'red' : TextStyle(
                              color: (this.highlight)
                                ? Theme.of(context).brightness == Brightness.light
                                  ? Theme.of(context).textTheme.bodyText1.color
                                  : Theme.of(context).canvasColor
                                : Theme.of(context).brightness == Brightness.light ? Color(0xffe75649) : Color(0xffe06c75)
                            ),

                            'vn' : TextStyle(
                              fontWeight: (this.selected) ? FontWeight.bold : FontWeight.normal,
                              color: this.colorNumber,
                              fontSize: this.fontSize - 7.0,
                            ),

                            'ctn' : TextStyle(
                              fontWeight: FontWeight.normal,
                              backgroundColor: (this.highlight)
                                ? colorHighlight
                                : Colors.transparent,
                              color: (this.highlight)
                                ? Theme.of(context).brightness == Brightness.light
                                  ? Theme.of(context).textTheme.bodyText1.color
                                  : Theme.of(context).canvasColor
                                : Theme.of(context).textTheme.bodyText1.color,
                            ),

                            'i' : TextStyle(
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic,
                              // fontFamily: 'Times',
                              fontSize: this.fontSize,
                              backgroundColor: (this.highlight)
                                ? colorHighlight
                                : Colors.transparent,
                              color: (this.highlight)
                                ? Theme.of(context).brightness == Brightness.light
                                  ? Theme.of(context).textTheme.bodyText1.color
                                  : Theme.of(context).canvasColor
                                : Theme.of(context).brightness == Brightness.light ? Color(0xffae7123) : Color(0xffe5c064)
                            )
                          }
                        )
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
              textAlign: TextAlign.center,
              text: TextSpan(
                text: element.replaceAll('#title_big ', ''),
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontFamily: "Nunito",
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
              textAlign: TextAlign.center,
              text: TextSpan(
                text: element.replaceAll('#subtitle ', ''),
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontFamily: 'Nunito',
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

      else if(element.split(' ')[0] == '#reference')
      {
        List<String> references = [];
        String temp = element;

        // encontrar referencias y guardar en una lista
        while(temp.contains('<x>')){
          int start = temp.indexOf('<x>');
          int end = temp.indexOf('</x>');

          references.add(temp.substring(start + 3, end));
          temp = temp.substring(end + 1);
        }

        // remplazar numero por nombre del libro
        for(var ref in references){
          List<String> split = ref.split(':');
          element = element.replaceFirst('<x>$ref', '<x>${intToAbreviatura[int.parse(split[0])]} ${ref.substring(ref.indexOf(':') + 1)}');
        }

        // remplazar etiquetas <x> por <a> que son links html
        for(var ref in references){
          element = element.replaceFirst('<x>', '<a href="$ref">');
          element = element.replaceFirst('</x>', '</a>');
        }

        print(element);

        widgets.add(
          Container(
            width: double.infinity,
            child: RichText(
              textAlign: TextAlign.center,
              text: HTML.toTextSpan(
                context,
                element.replaceAll('#reference ', ''),
                defaultTextStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontFamily: 'Nunito',
                  // fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.normal,
                  height: height,
                  fontSize: fontSize - 2,
                  letterSpacing: letterSeparation,
                ),

                overrideStyle: {
                  'a' : Theme.of(context).textTheme.bodyText1.copyWith(
                    fontFamily: 'Nunito',
                    // fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.normal,
                    height: height,
                    fontSize: fontSize - 2,
                    letterSpacing: letterSeparation,
                    color: Color(0xff8ab4f8)
                  ),
                },

                // CUANDO SE HACE CLICK EN LA REFERENCIA DE LOS SUBTITULOS
                linksCallback: (link) {
                  BiblePageController _biblePageController = Get.find();

                  List<String> split = link.toString().split(':');
                  int book = int.parse(split[0]);
                  int chapter = (split.length >= 2) ? int.parse(split[1]) : 1;
                  int verse = (split.length >= 3) ? int.parse(split[2].split('-')[0]) : 1;
                  // se hace una doble busqueda para evitar que el scroll no alcance el objetivo
                  _biblePageController.setReference(book, chapter, verse);
                  _biblePageController.update();
                  _biblePageController.setReference(book, chapter, verse);
                  _biblePageController.update();
                },
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
          Container(
            width: double.infinity,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: element,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.bold,
                  height: height,
                  fontSize: fontSize + 2,
                  letterSpacing: letterSeparation
                ),
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