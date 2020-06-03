import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yhwh/data/Data.dart';
import 'package:yhwh/icons/custom_icons_icons.dart';
import 'package:yhwh/ui_widgets/ui_verse.dart';

class StylePage extends StatefulWidget{
  StylePage({this.setTextFormat});

  final Function(double, double, double) setTextFormat;

  @override
  State<StatefulWidget> createState() => _StylePageState();
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
            child: FlatButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              child: Icon(Icons.refresh, color: Theme.of(context).iconTheme.color),

              onPressed: () {
                setState(() {
                  widget.setTextFormat(20.0, 1.8, 0);
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
            value: DynamicTheme.of(context).brightness == Brightness.dark ? true : false,
            title: Text("Modo oscuro", style: Theme.of(context).textTheme.button),
            onChanged: (value)
            {
              DynamicTheme.of(context).setBrightness(Theme.of(context).brightness == Brightness.dark? Brightness.light: Brightness.dark);
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
                onTap: (){
                  SharedPreferences.getInstance().then((preferences){
                    if(preferences.getDouble('fontLetterSpacing') > -1){
                      double temp = preferences.getDouble('fontLetterSpacing');
                      preferences.setDouble('fontLetterSpacing', temp - 0.25);
                    }
                  });
                },

                child: Container(
                  child: Center(
                      child: Icon(CustomIcons.format_horizontal_align_center, size: 30.0,)
                  ),

                  height: 66,
                  width: 66,
                ),
              ),

              InkWell(
                onTap: (){
                  SharedPreferences.getInstance().then((preferences){
                    if(preferences.getDouble('fontLetterSpacing') < 10){
                      double temp = preferences.getDouble('fontLetterSpacing');
                      preferences.setDouble('fontLetterSpacing', temp + 0.25);
                    }
                  });
                },
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
                onTap: (){
                  SharedPreferences.getInstance().then((preferences){
                    if(preferences.getDouble('fontSize') > 16){
                      double tempFontSize = preferences.getDouble('fontSize');
                      preferences.setDouble('fontSize', tempFontSize - 1);
                    }
                  });
                },
                
                child: Container(
                  child: Center(
                      child: Icon(CustomIcons.format_font_size_decrease, size: 35.0,)
                  ),

                  height: 66,
                  width: 66,
                ),
              ),

              InkWell(
                onTap: (){
                  SharedPreferences.getInstance().then((preferences){
                    if(preferences.getDouble('fontSize') < 50){
                      double tempFontSize = preferences.getDouble('fontSize');
                      preferences.setDouble('fontSize', tempFontSize + 1);
                    }
                  });
                },

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
                  title: null,
                  text: 'Jesús le dijo: Yo soy el camino, y la verdad, y la vida; nadie viene al Padre, sino por mí.',
                  number: 6,
                  color: Theme.of(context).textTheme.bodyText1.color,
                  colorOfNumber: Theme.of(context).textTheme.bodyText2.color,
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