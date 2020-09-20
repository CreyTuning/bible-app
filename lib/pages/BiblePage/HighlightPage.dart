import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:yhwh/data/Define.dart';
import 'package:yhwh/pages/BiblePage/Classes/Highlight.dart';

class HighlightPage extends StatefulWidget {
  HighlightPage();
  
  _HighlightPageState createState() => _HighlightPageState();
}

class _HighlightPageState extends State<HighlightPage> {

  Map highlight = {};
  List content = [];

  Future getVerse(int book, int chapter, int verse) async {
    Map data = json.decode(await rootBundle.loadString('lib/bibles/RVR60/${book}_$chapter.json'));
    return data['verses'][verse - 1]['text'].toString();
  }

  void highlightVerse(String reference){
    setState(() {
      highlight[reference] = DateTime.now().toString();
    });

    Highlight.writeHighlight(json.encode(highlight));
  }

  void deleteHighlightVerse(String reference){
    setState(() {
      highlight.remove(reference);
    });

    Highlight.writeHighlight(json.encode(highlight));
  }

  @override
  void initState() {    
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Resaltados'),
      ),

      body: FutureBuilder(
        future: Highlight.readHighlight(),
        initialData: '',
        builder: (BuildContext buildContext, AsyncSnapshot<dynamic> asyncSnapshot){

          if(asyncSnapshot.hasData)
          {
            highlight = json.decode(asyncSnapshot.data);

            highlight.forEach((key, value) {
              content.add(
                CardVerseHightlight(
                  date: '${value.toString().substring(0, 16)}',
                  reference: '${intToAbreviatura[int.parse(key.toString().split(':')[0])]} ${key.toString().split(':')[1]}:${key.toString().split(':')[2]}',
                  text: FutureBuilder(
                    initialData: 'Cargando...',
                    future: getVerse(int.parse(key.split(':')[0]), int.parse(key.split(':')[1]), int.parse(key.split(':')[2])),
                    builder: (BuildContext context, AsyncSnapshot asyncSnapshot){
                      if(asyncSnapshot.hasData){
                        return RichText(
                          maxLines: 3,

                          text: TextSpan(
                            text: '${asyncSnapshot.data}',
                            style: Theme.of(context).textTheme.bodyText2
                          ),

                          overflow: TextOverflow.fade,
                        );
                      }

                      else{
                        return RichText(
                          maxLines: 3,

                          text: TextSpan(
                            text: 'Cargando...',
                            style: Theme.of(context).textTheme.bodyText2
                          ),

                          overflow: TextOverflow.fade,
                        );
                      }
                    }
                  ),
                )
              );
            });

            content = content.reversed.toList();

            return Scrollbar(
              child: ListView.builder(
                itemExtent: 140,
                padding: EdgeInsets.fromLTRB(0, 5, 0, 55),
                itemBuilder: (BuildContext context, int item){
                  return content[item];
                },

                itemCount: content.length,
              )
            );
          }

          else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          
        }
      )
    );
  }
}



class CardVerseHightlight extends StatefulWidget {
  CardVerseHightlight({
    Key key,
    @required this.reference,
    @required this.text,
    @required this.date,
  }) : super(key: key);

  final String reference;
  final Widget text;
  final String date;

  @override
  _CardVerseHightlightState createState() => _CardVerseHightlightState();
}

class _CardVerseHightlightState extends State<CardVerseHightlight> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Card(
        color: Theme.of(context).bottomAppBarColor,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            height: 110,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Row(
                  children: <Widget>[

                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyText1,
                        children: [
                          TextSpan(
                            text: '${widget.reference}',
                          )
                        ]
                      ),
                    ),

                    Spacer(),

                    RichText(
                      textAlign: TextAlign.right,
                      textWidthBasis: TextWidthBasis.parent,
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize: 15
                        ),
                        children: [
                          TextSpan(
                            // text: '${intToBook[int.parse(key.toString().split(':')[0])]} ${key.toString().split(':')[1]}:${key.toString().split(':')[2]}',
                            text: '${widget.date}'
                          )
                        ]
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: Center(
                    child: widget.text,
                  ),
                )
              ],
            ),
          )
        )
      )
    );
  }
}