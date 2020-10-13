import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:yhwh/data/Define.dart';
import 'package:yhwh/pages/BiblePage/Classes/Highlight.dart';

class HighlightPage extends StatefulWidget {
  HighlightPage({
    Key key,
    this.setReference
  });
  
  final Function(int, int, int) setReference;

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
        initialData: '{}',
        builder: (BuildContext buildContext, AsyncSnapshot<dynamic> asyncSnapshot){

          if(asyncSnapshot.hasData)
          {

            if(asyncSnapshot.data == '{}'){
              return Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.touch_app, size: 70),
                    SizedBox.fromSize(size: Size.fromHeight(10)),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Toca dos veces un versículo\npara resaltarlo.',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 14
                        )
                      ),
                    )
                  ],
                ),
              );
            }

            highlight = json.decode(asyncSnapshot.data);

            highlight.forEach((key, value) {
              content.add(
                CardVerseHightlight(
                  setReferenceFunction: widget.setReference,
                  date: '${value.toString().substring(0, 16)}',
                  reference: '${intToAbreviatura[int.parse(key.toString().split(':')[0])]} ${key.toString().split(':')[1]}:${key.toString().split(':')[2]}',
                  referenceList: [int.parse(key.toString().split(':')[0]), int.parse(key.toString().split(':')[1]), int.parse(key.toString().split(':')[2])],
                  text: FutureBuilder(
                    initialData: 'Cargando...',
                    future: getVerse(int.parse(key.split(':')[0]), int.parse(key.split(':')[1]), int.parse(key.split(':')[2])),
                    builder: (BuildContext context, AsyncSnapshot asyncSnapshot){
                      if(asyncSnapshot.hasData){
                        return RichText(
                          maxLines: 3,

                          text: TextSpan(
                            text: '${asyncSnapshot.data}',
                            style: Theme.of(context).textTheme.bodyText1
                          ),

                          overflow: TextOverflow.fade,
                        );
                      }

                      else{
                        return RichText(
                          maxLines: 3,

                          text: TextSpan(
                            text: 'Cargando...',
                            style: Theme.of(context).textTheme.bodyText1
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

            return Container(
              color: Theme.of(context).canvasColor,
              child: Scrollbar(
                child: ListView.builder(
                  itemExtent: 140,
                  cacheExtent: 20,
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 55),
                  itemBuilder: (BuildContext context, int item){
                    return content[item];
                  },

                  itemCount: content.length,
                )
              ),
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
    @required this.referenceList,
    @required this.setReferenceFunction
  }) : super(key: key);

  final Function(int, int, int) setReferenceFunction;
  final String reference;
  final Widget text;
  final String date;
  final List<int> referenceList;

  @override
  _CardVerseHightlightState createState() => _CardVerseHightlightState();
}

class _CardVerseHightlightState extends State<CardVerseHightlight> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: (){
          // widget.setReferenceFunction(widget.referenceList[0], widget.referenceList[1], widget.referenceList[2]);
          // Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 2,
                  spreadRadius: 1,
                  offset: Offset(0, 1.5)
                )
              ],

              borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 110,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Row(
                      children: <Widget>[

                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              style: Theme.of(context).textTheme.bodyText1.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: '${widget.reference}',
                                )
                              ]
                            ),
                          ),
                        ),

                        Spacer(),

                        RichText(
                          textAlign: TextAlign.right,
                          textWidthBasis: TextWidthBasis.parent,
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
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
          ),
        )
      ),
    );
  }
}