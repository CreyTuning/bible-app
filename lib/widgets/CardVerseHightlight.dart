import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yhwh/controllers/BiblePageController.dart';
import 'package:yhwh/data/Define.dart';
import 'package:yhwh/models/highlighterItem.dart';
import 'dart:convert';

class CardVerseHightlight extends StatefulWidget {
  CardVerseHightlight({
    Key key,
    @required this.highlighterItem,
  }) : super(key: key);

  final HighlighterItem highlighterItem;

  @override
  _CardVerseHightlightState createState() => _CardVerseHightlightState();
}

class _CardVerseHightlightState extends State<CardVerseHightlight> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BiblePageController>(
      init: BiblePageController(),
      builder: (biblePageController) => Container(
        child: InkWell(
          onTap: (){},
          
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(widget.highlighterItem.color),
            ),

            trailing: RichText(
              textAlign: TextAlign.right,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontSize: 15,
                  // fontWeight: FontWeight.bold
                ),
                children: [
                  DateTime.now().day == widget.highlighterItem.dateTime.day ? TextSpan(text: 'Hoy, '): TextSpan(
                    text: '${weekNumberToString[widget.highlighterItem.dateTime.weekday]}, '
                  ),

                  TextSpan(
                    text: '${widget.highlighterItem.dateTime.day}'
                  ),

                  TextSpan(
                    text: ' ${monthDayToString[widget.highlighterItem.dateTime.month]}'.substring(0, 4) + '.'
                  ),

                  DateTime.now().year == widget.highlighterItem.dateTime.year ? TextSpan(text: '') :
                    TextSpan(
                      text: ' ${widget.highlighterItem.dateTime.year}'
                    )

                ]
              ),
            ),

            subtitle: widget.highlighterItem.verses.length == 1
            ? FutureBuilder(
              future: getVerse(
                version: biblePageController.bibleVersion,
                book: widget.highlighterItem.book,
                chapter: widget.highlighterItem.chapter,
                verse: widget.highlighterItem.verses.first
              ),
              initialData: '...',
              builder: (context, rootBundleSnapshot){
                if(rootBundleSnapshot.hasData){
                  return RichText(
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontSize: 15,
                      ),

                      children: [
                        TextSpan(
                          text: rootBundleSnapshot.data
                        )
                      ]
                    )
                  );

                } else {
                  return Text(
                    '...', 
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: 15,
                    )
                  );
                }
              }
            )
          
            : RichText(
              overflow: TextOverflow.fade,
              softWrap: false,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontSize: 15,
                ),

                children: [
                  TextSpan(
                    text: versesToFormatedString(widget.highlighterItem.verses)
                  )
                ]
              )
            ),

            title: Row(
              children: <Widget>[

                Flexible(
                  fit: FlexFit.loose,
                  child: RichText(
                    overflow: TextOverflow.fade,
                    softWrap: false,

                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: '${intToBook[widget.highlighterItem.book]} ${widget.highlighterItem.chapter}',
                        ),

                        widget.highlighterItem.verses.length != 1 ? TextSpan(text: '') : TextSpan(
                          text: ':${widget.highlighterItem.verses.first}',
                        ),
                      ]
                    ),
                  ),
                ),

                SizedBox(
                  width: 30,
                ),

                
              ],
            ),
          )
        ),
      )
    );
  }

  String versesToFormatedString(List<int> verses){
    List<List<int>> groups = [];
    String formatedOutput = '';

    // Crear grupo de versiculos
    for(int i in verses){
      
      // Si group esta vacio
      if(groups.length == 0){
        groups.add([i]);
        continue;
      }

      // Es consecutivo
      if(i == groups.last.last + 1){
        groups.last.add(i);
      }
      
      // No es consecutivo
      else { 
        groups.add([i]);
      }

    }

    // crear formatedOuput conforme a las listas
    for(List<int> list in groups){
      // Agregar separador ','
      if(formatedOutput != ''){
        formatedOutput += ', ';
      }

      // Agregar listas con length mayores a uno
      if(list.length > 1){
        formatedOutput += '${list.first}-${list.last}';
      }
      
      // Agregar listas con solo un valor
      else {
        formatedOutput += '${list.first}';
      }
    }

    return formatedOutput;
  }


  Future<String> getVerse({String version, int book, int chapter, int verse}) async {
    List dataChapter = await jsonDecode(await rootBundle.loadString('lib/bibles/$version/${book}_$chapter.json'))['verses'];
    return dataChapter[verse - 1]["text"];
  }
}