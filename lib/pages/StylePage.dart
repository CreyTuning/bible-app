import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:yhwh/data/Data.dart';
import 'package:yhwh/ui_widgets/ui_verse.dart';

class StylePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StylePageState();
  }
}

class _StylePageState extends State<StylePage>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Estilos')
      ),

      body: ListView(
        children: <Widget>[

          SwitchListTile(
            activeColor: Theme.of(context).accentColor,
            value: appData.darkModeEnabled,
            title: Text("Modo oscuro", style: Theme.of(context).textTheme.button),
            onChanged: (value)
            {
              appData.setDarkMode = value;
              Phoenix.rebirth(context);
            },
          ),


          // Tamaño de texto
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 0, 7, 0),
            child: Row(
              children: <Widget>[
                Text("Tamaño", style: Theme.of(context).textTheme.button),
                Spacer(),
                Container(
                  width: 60.0,
                  height: 60.0,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      elevation: 0,
                      child: Icon(Icons.remove, color: Theme.of(context).iconTheme.color),
                      onPressed: () {
                        appData.fontDecrement();
                        setState(() {});
                      }
                  ),
                ),

                Container(
                  width: 60.0,
                  height: 60.0,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      elevation: 0,
                      child: Icon(Icons.refresh, color: Theme.of(context).iconTheme.color),
                      onPressed: () {
                        appData.fontSize = 20;
                        setState(() {});
                      }
                  ),
                ),

                Container(
                  width: 60.0,
                  height: 60.0,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)
                      ),
                      elevation: 0,
                      child: Icon(Icons.add, color: Theme.of(context).iconTheme.color),
                      onPressed: () {
                        appData.fontIncrement();
                        setState(() {});
                      }
                  ),
                ),
              ],
            ),
          ),


          // Separacion de lineas
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 0, 7, 0),
            child: Row(
              children: <Widget>[
                Text("Lineas", style: Theme.of(context).textTheme.button),
                Spacer(),
                Container(
                  width: 60.0,
                  height: 60.0,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      elevation: 0,
                      child: Icon(Icons.remove, color: Theme.of(context).iconTheme.color),
                      onPressed: () {
                        appData.fontLineSpaceDecrement();
                        setState(() {});
                      }
                  ),
                ),

                Container(
                  width: 60.0,
                  height: 60.0,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      elevation: 0,
                      child: Icon(Icons.refresh, color: Theme.of(context).iconTheme.color),
                      onPressed: () {
                        appData.fontHeight = 1.8;
                        setState(() {});
                      }
                  ),
                ),

                Container(
                  width: 60.0,
                  height: 60.0,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)
                      ),
                      elevation: 0,
                      child: Icon(Icons.add, color: Theme.of(context).iconTheme.color),
                      onPressed: () {
                        appData.fontLineSpaceIncrement();
                        setState(() {});
                      }
                  ),
                ),
              ],
            ),
          ),

          // Separacion de letras
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 0, 7, 0),
            child: Row(
              children: <Widget>[
                Text("Letras", style: Theme.of(context).textTheme.button),
                Spacer(),
                Container(
                  width: 60.0,
                  height: 60.0,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      elevation: 0,
                      child: Icon(Icons.remove, color: Theme.of(context).iconTheme.color),
                      onPressed: () {
                        appData.fontLetterSpaceDecrement();
                        setState(() {});
                      }
                  ),
                ),

                Container(
                  width: 60.0,
                  height: 60.0,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      elevation: 0,
                      child: Icon(Icons.refresh, color: Theme.of(context).iconTheme.color),
                      onPressed: () {
                        appData.fontLetterSpacing = 0;
                        setState(() {});
                      }
                  ),
                ),

                Container(
                  width: 60.0,
                  height: 60.0,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)
                      ),
                      elevation: 0,
                      child: Icon(Icons.add, color: Theme.of(context).iconTheme.color),
                      onPressed: () {
                        appData.fontLetterSpaceIncrement();
                        setState(() {});
                      }
                  ),
                ),
              ],
            ),
          ),

          Divider(color: Color(0x00)),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.5,
                    color: Theme.of(context).accentColor,
                  )
              ),

              child: Column(
                children: <Widget>[
                  UiVerse(
                    text: 'Jesús le dijo: Yo soy el camino, y la verdad, y la vida; nadie viene al Padre, sino por mí.',
                    number: 6,
                    color: Theme.of(context).textTheme.body2.color,
                    colorOfNumber: Theme.of(context).textTheme.body1.color,
                    fontSize: appData.fontSize,
                    height: appData.fontHeight,
                    letterSeparation: appData.fontLetterSpacing,
                  ),
                ],
              ),
            ),
          )

        ],
      )
    );
  }
}