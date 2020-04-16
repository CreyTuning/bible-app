import 'package:yhwh/data/Define.dart';
import 'package:yhwh/pages/BookViewer.dart';
import 'package:flutter/material.dart';
import 'package:yhwh/data/Data.dart';

class HomePage extends StatefulWidget
{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int versesCount = 1;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        backgroundColor: Colors.white,
        title: Text('YHWH', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        
        actions: <Widget>
        [
          Container(
            width: 60.0,
            height: 60.0,
            child: RaisedButton
            (
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              color: Colors.white,
              elevation: 0,
              child: Icon(Icons.text_fields),
              onPressed: (){},
            ),
          ),

          // Container(width: 10), //Separador

        ],
      ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row
        (
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: <Widget>
          [
            Container
            (
              width: 41.0,
              height: 41.0,
              child: new RawMaterialButton
              (
                shape: new CircleBorder(),
                fillColor: Colors.white,
                child: Icon(Icons.keyboard_arrow_left),
                onPressed: ()
                {
                  setState((){
                    appData.previousChapter();
                  });
                },
              )
            ),

            Spacer(),

            RaisedButton
            (
              color: Colors.white,
              
              shape: RoundedRectangleBorder
              (
                borderRadius: BorderRadius.circular(20)
              ),
              
              child: Row
                (
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>
                  [
                    RichText
                    (
                      text: TextSpan
                      (
                        children:
                        [
                          TextSpan
                          (
                            text: '${intToBook[appData.book]}',
                            style: TextStyle
                            (
                              color: Colors.black,
                              // fontWeight: FontWeight.bold
                            )
                          ),

                          TextSpan
                          (
                            text: ' ${appData.chapter}',
                            style: TextStyle
                            (
                              color: Colors.pink,
                              fontWeight: FontWeight.bold
                            )
                          )
                        ]
                      ),
                    ),
                    Container(width: 5, height: 41), // Separador
                    Icon(Icons.menu),
                  ],
                ),
              
              onPressed: ()
              {
                Navigator.pushNamed(context, 'books');
              }
            ),

            Spacer(),

            Container
            (
              width: 41.0,
              height: 41.0,
              child: new RawMaterialButton
              (
                shape: new CircleBorder(),
                fillColor: Colors.white,
                child: Icon(Icons.keyboard_arrow_right),
                onPressed: ()
                {
                  setState(()
                  {
                    appData.nextChapter();
                  });
                },
              )
            ),
          ],
        ),
      ),

      body: BookViewer()
    );
  }
}