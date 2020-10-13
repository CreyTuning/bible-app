import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yhwh/icons/custom_icons_icons.dart';
import 'package:yhwh/pages/BiblePage/BookViewerForStylePage.dart';
import '../../../themes.dart';


class StylePage extends StatefulWidget{
  StylePage({this.updateStateInBiblePage});

  final Function updateStateInBiblePage;

  @override
  State<StatefulWidget> createState() => _StylePageState();
}

class _StylePageState extends State<StylePage>{
  TabController tabController;

  double fontSize = 20.0;
  double height = 1.80;
  double letterSeparation = 0;
  bool blackThemeEnabled = false;
  bool highlightVersePreview = false; 


  @override
  void initState() {
    SharedPreferences.getInstance().then((preferences){
      setState(() {
        fontSize = preferences.getDouble('fontSize') ?? 20.0;
        height = preferences.getDouble('height') ?? 1.80;
        letterSeparation = preferences.getDouble('letterSeparation') ?? 0.0;
        blackThemeEnabled = preferences.getBool('blackThemeEnabled') ?? false;
      });
    });
    super.initState();
  }


  void saveAndUpdateValues(){
    SharedPreferences.getInstance().then((preferences){
      preferences.setDouble('fontSize', fontSize);
      preferences.setDouble('height', height);
      preferences.setDouble('letterSeparation', letterSeparation);
    });

    widget.updateStateInBiblePage();
  }

  void plusFontSize(){
    setState(() {
      if(fontSize < 50)
        fontSize += 1;
    });

    saveAndUpdateValues();
  }

  void lessFontSize(){
    setState(() {
      if(fontSize > 12)
        fontSize -= 1;
    });

    saveAndUpdateValues();
  }

  void plusHeight(){
    setState(() {
      if(height < 3.05)
      height += 0.25;
    });

    saveAndUpdateValues();
  }

  void lessHeight(){
    setState(() {
      if(height > 1.05)
        height -= 0.25;
    });

    saveAndUpdateValues();
  }

  void plusLetterSeparation(){
    setState(() {
      if(letterSeparation < 5)
        letterSeparation += 0.5;
    });

    saveAndUpdateValues();
  }

  void lessLetterSeparation(){
    setState(() {
      if(letterSeparation > -1.5)
        letterSeparation -= 0.5;
    });

    saveAndUpdateValues();
  }


  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Preferencias'),
          actions: <Widget>[
            Container(
              width: 60.0,
              height: 60.0,
              child: FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                child: Icon(Icons.settings_backup_restore, color: Theme.of(context).iconTheme.color),

                onPressed: () {
                  setState(() {
                    fontSize = 20.0;
                    height = 1.80;
                    letterSeparation = 0;
                    
                    saveAndUpdateValues();
                  });
                },
              ),
            ),
          ],

          bottom: TabBar(
            indicatorColor: Theme.of(context).textTheme.bodyText1.color,
            controller: tabController,
            tabs: [
              Tab(icon: Icon(Icons.format_size)),
              Tab(icon: Icon(Icons.color_lens)),
            ]
          ),
        ),

        body: TabBarView(
          children: [
            
            //Ajustes de lectura
            Container(),

            
            // Colores personalizados
            Scrollbar(
              child: ListView(
                padding: EdgeInsets.only(bottom: 55),
                children: <Widget>[

                  TopLabel(text: 'Combinación de colores'),

                  SwitchListTile(
                    activeColor: Theme.of(context).textTheme.bodyText1.color,
                    value: DynamicTheme.of(context).brightness == Brightness.dark ? true : false,
                    title: Text("Lectura nocturna", style: Theme.of(context).textTheme.button),
                    subtitle: Text("Colores oscuros",
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 16,
                          color: Theme.of(context).textTheme.bodyText2.color
                      )
                    ),

                    onChanged: (value)
                    {
                      DynamicTheme.of(context).setBrightness(Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark);
                      DynamicTheme.of(context).setThemeData(AppThemes.getTheme(Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark, blackThemeEnabled));

                      SharedPreferences.getInstance().then((preferences){
                        preferences.setBool('darkMode', (DynamicTheme.of(context).brightness == Brightness.dark) ? false : true);
                      });
                    },
                  ),

                  (DynamicTheme.of(context).brightness == Brightness.dark) ? SwitchListTile(
                    activeColor: Theme.of(context).textTheme.bodyText1.color,
                    value: blackThemeEnabled,
                    title: Text("Fondo negro", style: Theme.of(context).textTheme.button),
                    subtitle: Text("Diseñado para pantallas Oled",
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 16,
                          color: Theme.of(context).textTheme.bodyText2.color
                      )
                    ),

                    onChanged: (value)
                    {
                      // DynamicTheme.of(context).setBrightness(Theme.of(context).brightness == Brightness.dark? Brightness.light: Brightness.dark);
                      
                      blackThemeEnabled = value;

                      SharedPreferences.getInstance().then((preferences){
                        setState(() {
                          preferences.setBool('blackThemeEnabled', value);
                        });
                      });

                      DynamicTheme.of(context).setThemeData(AppThemes.getTheme(Theme.of(context).brightness, blackThemeEnabled));

                    },
                  ) : SizedBox(),

                ],
              ),
            ),
          
          ],
        )
      )
    );
  }
}


class ValueChanger extends StatefulWidget {
  ValueChanger({
    Key key,
    @required this.title,
    @required this.value,
    @required this.plusFuction,
    @required this.lessFuction
  });

  final String title;
  final String value;
  final Function() plusFuction;
  final Function() lessFuction;

  @override
  _ValueChangerState createState() => _ValueChangerState();
}

class _ValueChangerState extends State<ValueChanger>
{
  @override
  Widget build(BuildContext context)
  {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 10, 20, 0),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.title,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: 17
                ),
                textAlign: TextAlign.left
              ),
              
              Text(
                widget.value,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: 17,
                  color: Theme.of(context).textTheme.bodyText2.color
                ),
                textAlign: TextAlign.left
              ),
            ],
          ),

          Spacer(),

          Container(
            width: 43,
            height: 55,
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              child: Icon(Icons.remove),
              onTap: widget.lessFuction
            ),
          ),

          Container(
            width: 43,
            height: 55,
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              child: Icon(Icons.add),
              onTap: widget.plusFuction,
            ),
          ),
        ]
      )
    );
  }
}

class TopLabel extends StatelessWidget {
  const TopLabel({Key key, this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 25, 20, 0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.bold
        )
      ),
    );
  }
}


class ColorSelector extends StatefulWidget {
  ColorSelector({Key key}) : super(key: key);

  final double radius = 35;
  final colors = [
    Colors.green,
    Colors.blueAccent,
    Colors.purpleAccent,
    Colors.amber,
    Colors.pink
  ];

  @override
  _ColorSelectorState createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  
  int index = 0;
  
  setColor(int value)
  {
    setState(() {
      index = value;
    });

    // SharedPreferences.getInstance().then((preferences){
    //   preferences.setInt('colorAccent', value);
    // });

    // DynamicTheme.of(context).setThemeData(
    //   DynamicTheme.of(context).data.copyWith(
    //     accentColor: widget.colors[value],
    //     primaryColor: widget.colors[value]
    //   )
    // );
  }

  @override
  void initState() {
    SharedPreferences.getInstance().then((preferences){
      setState(() {
        index = preferences.getInt('colorAccent') ?? 0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 10, 20, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          InkWell(
            onTap: (){
              setColor(0);
            },

            borderRadius: BorderRadius.circular(30),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: widget.radius,
              width: widget.radius,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular((index == 0) ? 3 : 30),
                color: widget.colors[0]
              ),
            ),
          ),

          InkWell(
            onTap: (){
              setColor(1);
            },

            borderRadius: BorderRadius.circular(30),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: widget.radius,
              width: widget.radius,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular((index == 1) ? 3 : 30),
                color: widget.colors[1]
              ),
            ),
          ),

          InkWell(
            onTap: (){
              setColor(2);
            },

            borderRadius: BorderRadius.circular(30),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: widget.radius,
              width: widget.radius,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular((index == 2) ? 3 : 30),
               color: widget.colors[2]
              ),
            ),
          ),

          InkWell(
            onTap: (){
              setColor(3);
            },

            borderRadius: BorderRadius.circular(30),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: widget.radius,
              width: widget.radius,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular((index == 3) ? 3 : 30),
                color: widget.colors[3]
              ),
            ),
          ),

          InkWell(
            onTap: (){
              setColor(4);
            },

            borderRadius: BorderRadius.circular(30),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: widget.radius,
              width: widget.radius,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular((index == 4) ? 3 : 30),
                color: widget.colors[4]
              ),
            ),
          ),

        ]
      )
    );
  }
}