import 'package:bbnew/data/Define.dart';
import 'package:bbnew/pages/BookViewer.dart';
import 'package:flutter/material.dart';
import 'package:bbnew/data/Data.dart';

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
        title: Text('YHWH', style: TextStyle(color: Colors.black)),
        
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
                    Icon(Icons.book),
                    Container(width: 5, height: 41), // Separador
                    Text('${intToBook[appData.book]} ${appData.chapter}'),
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