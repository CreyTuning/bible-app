import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:yhwh/data/Data.dart';
import 'package:yhwh/icons/custom_icons_icons.dart';
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
        title: Text('Estilos'),
        actions: <Widget>[
          Container(
            width: 60.0,
            height: 60.0,
            child: RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              elevation: 0,
              child: Icon(Icons.refresh, color: Theme.of(context).iconTheme.color),

              onPressed: () {
                appData.fontSize = 20.0;
                appData.fontHeight = 1.8;
                appData.fontLetterSpacing = 0;
                appData.saveData();
                setState(() {
                });
              },
            ),
          ),
        ],
      ),

      body: ListView(
        children: <Widget>[

          SwitchListTile(
            activeColor: Theme.of(context).accentColor,
            value: appData.darkModeEnabled,
            title: Text("Modo oscuro", style: Theme.of(context).textTheme.button),
            subtitle: Text("Reinicio requerido", style: TextStyle(fontSize: 15)),
            onChanged: (value)
            {
              showDialog(context: context, builder: (_) => AlertDialog(
                title: Text('Modo oscuro', style: TextStyle(fontWeight: FontWeight.bold)),
                content: Text('Para cambiar el modo de colores se debe reiniciar la aplicación. ¿Reinicar ahora?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Cancelar', style: TextStyle(color: Theme.of(context).textTheme.button.color),),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                  ),

                  RaisedButton(
                    child: Text('Aceptar', style: TextStyle(color: Colors.white)),
                    onPressed: (){
                      appData.setDarkMode = value;
                      Phoenix.rebirth(context);
                    },
                    color: Theme.of(context).accentColor,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                  ),
                ],
              ));
            },
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: (){appData.fontLineSpaceDecrement(); setState(() {});},
                child: Container(
                  child: Center(
                      child: Icon(CustomIcons.arrow_collapse_vertical, size: 30.0,)
                  ),

                  height: 66,
                  width: 66,
                ),
              ),

              InkWell(
                onTap: (){appData.fontLineSpaceIncrement(); setState(() {});},
                child: Container(
                  child: Center(
                      child: Icon(CustomIcons.arrow_expand_vertical, size: 30.0,)
                  ),

                  height: 66,
                  width: 66,
                ),
              ),

              InkWell(
                onTap: (){appData.fontLetterSpaceDecrement();setState(() {});},
                child: Container(
                  child: Center(
                      child: Icon(CustomIcons.format_horizontal_align_center, size: 30.0,)
                  ),

                  height: 66,
                  width: 66,
                ),
              ),

              InkWell(
                onTap: (){appData.fontLetterSpaceIncrement();setState(() {});},
                child: Container(
                  child: Center(
                      child: Icon(CustomIcons.format_horizontal_align_center_expand, size: 30.0,)
                  ),

                  height: 66,
                  width: 66,
                ),
              ),

            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              InkWell(
                onTap: (){appData.fontDecrement();setState(() {});},
                child: Container(
                  child: Center(
                      child: Icon(CustomIcons.format_font_size_decrease, size: 35.0,)
                  ),

                  height: 66,
                  width: 66,
                ),
              ),

              InkWell(
                onTap: (){appData.fontIncrement();setState(() {});},
                child: Container(
                  child: Center(
                      child: Icon(CustomIcons.format_font_size_increase, size: 35.0,)
                  ),

                  height: 66,
                  width: 66,
                ),
              ),

            ],
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

              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: UiVerse(
                  text: 'Jesús le dijo: Yo soy el camino, y la verdad, y la vida; nadie viene al Padre, sino por mí.',
                  number: 6,
                  color: Theme.of(context).textTheme.body2.color,
                  colorOfNumber: Theme.of(context).textTheme.body1.color,
                  fontSize: appData.fontSize,
                  height: appData.fontHeight,
                  letterSeparation: appData.fontLetterSpacing,
                ),
              )
            ),
          )

        ],
      )
    );
  }
}