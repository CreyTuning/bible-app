import 'package:flutter/material.dart';


class UiVerse extends StatefulWidget{
  final int verseNumber;
  final int chapterNumber;
  final int bookNumber;
  final String text;
  final String title;

  final String fontFamily;
  final double fontSize;
  final double height;
  final double letterSeparation;

  final Color color;
  final Color colorOfNumber;

  final double verseSeparation;
  final bool highlight;
  
  final Function(String reference) highlightVerse;
  final Function(String reference) deleteHighlightVerse;
  
  UiVerse({
    Key key,
    @required this.verseNumber,
    @required this.chapterNumber,
    @required this.bookNumber,

    @required this.text,
    @required this.title,
    @required this.highlight,

    this.fontFamily = 'Roboto',
    this.fontSize = 20.0,
    this.height  = 1.8,
    this.letterSeparation = 0,

    this.color = const Color(0xff263238),
    this.colorOfNumber = const Color(0xaf37474F),

    this.verseSeparation = 5.0,

    this.highlightVerse,
    this.deleteHighlightVerse
  }) : super(key: key);

  _UiVerseState createState() => _UiVerseState();
}

class _UiVerseState extends State<UiVerse>{

  @override
  Widget build(BuildContext context)
  {
    List<Widget> content = <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
              letterSpacing: this.widget.letterSeparation,
            ),

            children: [
              TextSpan( // Numero de versiculo
                text: this.widget.verseNumber.toString(),
                style: TextStyle(
                  color: this.widget.colorOfNumber,
                  fontSize: this.widget.fontSize - 7.0,
                )
              ),

              TextSpan(
                text: ' '
              ),

              TextSpan(
                text: this.widget.text.toString(),
                style: TextStyle(
                  backgroundColor: (widget.highlight) ? Colors.pink : Colors.transparent,
                  color: (widget.highlight) ? Colors.white : Theme.of(context).textTheme.bodyText1.color,
                )
              ),
            ]
          ),
        ),
      ),

      // Divider(color: Color(0x00), height: widget.height,)
    ];

    
    
    if(widget.title != null){
      content.insert(0,
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.bold,
                height: widget.height,
                fontSize: widget.fontSize,
                letterSpacing: widget.letterSeparation
              ),
            ),
          ),
        ),
      );
    }

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: content,
      ),

      onDoubleTap: (){

        // Scaffold.of(context).removeCurrentSnackBar();

        // Scaffold.of(context).showSnackBar(
        //   SnackBar(
        //     duration: Duration(seconds: 2),
        //     backgroundColor: (widget.highlight) ? Colors.red : Colors.blue,

        //     behavior: SnackBarBehavior.fixed,
            
        //     content: Row(
        //       children: <Widget>[
        //         Text(
        //           (widget.highlight) ? 'Se quito de resaltados y favoritos.' : 'Resaltado y agregado a favoritos.',
                
        //           style: Theme.of(context).textTheme.bodyText1.copyWith(
        //             fontSize: 16,
        //             fontFamily: 'Baloo',
        //             color: Colors.white
        //           )
        //         ),

        //         Spacer(),

        //         Icon(
        //           (widget.highlight) ? Icons.delete : Icons.check,
        //           color: Colors.white
        //         )
        //       ],
        //     )
        //   ),
        // );

        if(!widget.highlight){
          widget.highlightVerse('${widget.bookNumber}:${widget.chapterNumber}:${widget.verseNumber}');
        } else{
          widget.deleteHighlightVerse('${widget.bookNumber}:${widget.chapterNumber}:${widget.verseNumber}');
        }
      },
    );
  }



  List<TextSpan> textToRichText(int verseNumber, String text)
  {
    List<TextSpan> list = [];
    List<String> splitText = text.replaceAll('Jehová', 'YHWH').
                                  // replaceAll('el SEÑOR ([YHWH])', 'YHWH').
                                  // replaceAll('El SEÑOR ([YHWH])', 'YHWH').
                                  // replaceAll('Del SEÑOR', 'De YHWH').
                                  // replaceAll('del SEÑOR', 'de YHWH').
                                  // replaceAll('El SEÑOR', 'YHWH').
                                  // replaceAll('el SEÑOR', 'YHWH').
                                  // replaceAll('Al SEÑOR', 'A YHWH').
                                  // replaceAll('al SEÑOR', 'a YHWH').
                                  // replaceAll('DIOS', 'YHWH').
                                  // replaceAll('SEÑOR', 'YHWH').
                                  split(' ');

    list.add(
      TextSpan( // Numero de versiculo
        text: verseNumber.toString(),
        style: TextStyle(
            color: this.widget.colorOfNumber,
            fontSize: this.widget.fontSize - 7.0
        )
      )
    );

    list.add(
      TextSpan( // Numero de versiculo
        text: ' ',
      )
    );
    
    splitText.forEach((element) {
      
      // Verificar si se activa el IsOpen
      // if(element.contains('['))
      //   isOpen = true;


      // if(isOpen)
      // {
      //   if(element.contains('([') && element.contains('])')){
      //     if(!element.endsWith(')'))
      //     {
      //       list.add(
      //         TextSpan(
      //           text: element.substring(0, element.length - 1).replaceAll('[', '').replaceAll(']', ''),
      //           style: TextStyle(
                  
      //             fontFamily: 'Roboto-Italic',
      //           )
      //         )
      //       );

      //       list.add(
      //         TextSpan(
      //           text: element[element.length - 1] + ' ',
      //         )
      //       );
      //     }

      //     else{
      //       list.add(
      //         TextSpan(
      //           text: element.replaceAll('[', '').replaceAll(']', '') + ' ',
      //           style: TextStyle(
                  
      //             fontFamily: 'Roboto-Italic',
      //           )
      //         )
      //       );
      //     }
          
      //   }

      //   else if(element.length >= 3 && element[1] == '['){
          
      //     list.add(
      //       TextSpan(
      //         text: element[0],
      //       )
      //     );
          
      //     list.add(
      //       TextSpan(
      //         text: element.substring(1, element.length - 1).replaceAll('[', '').replaceAll(']', '') + ' ',
      //         style: TextStyle(
                
      //           fontFamily: 'Roboto-Italic',
      //         )
      //       )
      //     );
      //   }

      //   else if(element.contains(']') && !element.endsWith(']')){
      //     list.add(
      //       TextSpan(
      //         text: element.substring(0, element.length - 2).replaceAll('[', '').replaceAll(']', ''),
      //         style: TextStyle(
                
      //           fontFamily: 'Roboto-Italic',
      //           // fontSize: widget.fontSize - 2,
      //           // fontStyle: FontStyle.italic,
      //         )
      //       )
      //     );

      //     list.add(
      //       TextSpan(
      //         text: element[element.length - 1] + ' '
      //       )
      //     );
      //   }

      //   else {
      //     list.add(
      //       TextSpan(
      //         text: element.replaceAll('[', '').replaceAll(']', '') + ' ',
      //         style: TextStyle(
                
      //           fontFamily: 'Roboto-Italic',
      //           // fontSize: widget.fontSize - 2,
      //           // fontStyle: FontStyle.italic,
      //         )
      //       )
      //     );
      //   }
        
      //   if(element.contains(']'))
      //     isOpen = false;
      // }

      // else{
        
      // }


      if(element == 'YHWH'|| element == 'SEÑOR')
      { 
        list.add(
          TextSpan(
            text: element + ' ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Baloo',
              height: 0
            )
          )
        );
      }

      else if(element == 'YHWH:' || element == 'YHWH,' || element == 'YHWH;' || element == 'YHWH.' || element == 'YHWH?' ||
            element == 'SEÑOR:' || element == 'SEÑOR,' || element == 'SEÑOR;' || element == 'SEÑOR.' || element == 'SEÑOR?')
      {
        list.add(
          TextSpan(
            text: element.substring(0, element.length - 1),
            style: TextStyle(
              // color: Colors.green,
              fontWeight: FontWeight.bold,
              fontFamily: 'Baloo',
              height: 0
            )
          )
        );

        list.add(
          TextSpan(
            text: element[element.length - 1] + ' '
          )
        );
      }
      
      else{
        list.add(
          TextSpan(
            text: element + ' ',
            style: TextStyle(
            )
          )
        );
      }

    });

    return list;
  }
}