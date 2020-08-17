import 'package:flutter/material.dart';
import 'package:yhwh/pages/PageSelector.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[

          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 16),
            // height: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('YHWH', 
                  style: TextStyle(
                    fontFamily: 'Londrina',
                    fontSize: 25,
                    letterSpacing: 2,
                    color: Theme.of(context).iconTheme.color,
                    height: 1.2
                  ),
                ),

                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 1,
                    ),
                    Text('יהוה', 
                      style: TextStyle(
                        fontFamily: 'Tinos',
                        fontSize: 14,
                        letterSpacing: 2,
                        color: Theme.of(context).iconTheme.color,
                        height: 0.8,
                        // fontWeight: FontWeight.w900
                      ),
                    ),
                  ],
                ),
              ],
            )
          ),

          Spacer(),

          InkWell(
            child: Container(
              child: Icon(Icons.more_vert, color: Theme.of(context).iconTheme.color),
              width: 60,
            ),
            borderRadius: BorderRadius.circular(30),
            onTap: () {},
            onLongPress: () {},
          ),
        ],
      ),

      body: EnDesarrollo(title: 'Inicio'),
    );
  }
}