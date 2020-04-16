import 'package:yhwh/data/Define.dart';
import 'package:yhwh/pages/BookSelection.dart';
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
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: <Widget>[
            Container(
              width: 41.0,
              height: 41.0,
              child: new RawMaterialButton(
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

//            RaisedButton
//            (
//              color: Colors.white,
//
//              shape: RoundedRectangleBorder
//              (
//                borderRadius: BorderRadius.circular(20)
//              ),
//
//              child: Row
//                (
//                  mainAxisSize: MainAxisSize.min,
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>
//                  [
//                    RichText
//                    (
//                      text: TextSpan
//                      (
//                        children:
//                        [
//                          TextSpan
//                          (
//                            text: '${intToBook[appData.book]}',
//                            style: TextStyle
//                            (
//                              color: Colors.black,
//                              // fontWeight: FontWeight.bold
//                            )
//                          ),
//
//                          TextSpan
//                          (
//                            text: ' ${appData.chapter}',
//                            style: TextStyle
//                            (
//                              color: Colors.black,
////                              fontWeight: FontWeight.bold
//                            )
//                          )
//                        ]
//                      ),
//                    ),
////                    Container(width: 5, height: 41), // Separador
////                    Icon(Icons.menu),
//                  ],
//                ),
//
//              onPressed: ()
//              {
//                Navigator.pushNamed(context, 'books');
//              }
//            ),
            Expanded(child: SizedBox.fromSize(),),

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

      body: Scrollbar(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              forceElevated: true,
              floating: true,
//            elevation: 8,
              backgroundColor: Colors.white,

              title: Container(
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                        onTap: (){Navigator.pushNamed(context, 'books');},
//                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: <Widget>[
                            Text('${intToBook[appData.book]} ${appData.chapter}', style: TextStyle(fontSize: 18, fontFamily: 'Roboto', color: Color(0xff263238)),),
                            Icon(Icons.arrow_drop_down, color: Color(0xff263238),)
                          ],
                        )
                    ),
                  ],
                ),
              ),

              actions: <Widget>[
                Container(
                  width: 60.0,
                  height: 60.0,
                  child: RaisedButton
                    (
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                    color: Colors.white,
                    elevation: 0,
                    child: Icon(Icons.text_fields, color: Color(0xff37474F)),
                    onPressed: (){},
                  ),
                ),
              ],
            ),
            BookViewer()
          ],
        ),
      )
    );
  }
}