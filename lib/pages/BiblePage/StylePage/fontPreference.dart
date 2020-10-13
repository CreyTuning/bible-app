import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yhwh/icons/custom_icons_icons.dart';
import 'package:yhwh/ui_widgets/ThemeSelectorFooter.dart';
import 'package:yhwh/ui_widgets/chapter_footer.dart';

import '../../../themes.dart';
import '../BookViewerForStylePage.dart';

class FontPreference extends StatefulWidget {
  FontPreference({
    Key key,
    this.updateStateInBiblePage
  }) : super(key: key);

  final Function updateStateInBiblePage;

  @override
  _FontPreferenceState createState() => _FontPreferenceState();
}

class _FontPreferenceState extends State<FontPreference> {
  double fontSize = 20.0;
  double height = 1.80;
  double letterSeparation = 0;
  bool blackThemeEnabled = false;
  bool highlightVersePreview = false; 


  void saveAndUpdateValues(){
    SharedPreferences.getInstance().then((preferences){
      preferences.setDouble('fontSize', fontSize);
      preferences.setDouble('height', height);
      preferences.setDouble('letterSeparation', letterSeparation);
    });

    widget.updateStateInBiblePage();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        title: Text('Ajustes de fuentes'),
        actions: [
          InkWell(
            child: Container(
              child: Icon(Icons.settings_backup_restore, color: Theme.of(context).iconTheme.color, size: 21,),
              width: 55,
              height: 55,
            ),
            borderRadius: BorderRadius.circular(30),
            onTap: () {
              setState(() {
                fontSize = 20.0;
                height = 1.80;
                letterSeparation = 0;
                
                saveAndUpdateValues();
              });
            },
            onLongPress: () {},
          ),
        ],
      ),

      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            // TopLabel(text: 'Vista previa de lectura'),
            Divider(
              color: Colors.transparent,
              height: 5,
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Theme.of(context).textTheme.bodyText1.color,
                      width: 2
                    )
                  ),

                  clipBehavior: Clip.antiAlias,

                  child: BookViewerForStylePage(
                    bookNumber: 1,
                    chapterNumber: 1,
                    chapterFooter: SizedBox(height: 20),
                    verseNumber: 1,
                    autoScrollController: AutoScrollController(),
                    fontSize: fontSize,
                    height: height,
                    letterSeparation: letterSeparation,
                  )
                ),
              ),
            ),

            
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  // TopLabel(text: 'Preferencias de caracteres'),

                  Divider(
                    color: Colors.transparent,
                    height: 5,
                  ),
                  
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: Center(
                          child: Icon(Icons.format_size),
                        ),
                      ),
                      
                      Expanded(
                        child: Slider(
                          onChangeEnd: (value){
                            saveAndUpdateValues();
                          },

                          activeColor: Theme.of(context).textTheme.bodyText1.color,
                          inactiveColor: Theme.of(context).textTheme.bodyText1.color.withBlue((Theme.of(context).brightness == Brightness.light) ? 215 : 40).withGreen((Theme.of(context).brightness == Brightness.light) ? 215 : 40).withRed((Theme.of(context).brightness == Brightness.light) ? 215 : 40),
                          value: fontSize,
                          min: 18,
                          max: 30,
                          divisions: 12,
                          // label: 'Tamaño de letra: ${fontSize.round().toString()}',
                          onChanged: (double value) {
                            setState(() {
                              fontSize = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: Center(
                          child: Icon(Icons.format_line_spacing),
                        ),
                      ),
                      
                      Expanded(
                        child: Slider(
                          onChangeEnd: (value){
                            saveAndUpdateValues();
                          },

                          activeColor: Theme.of(context).textTheme.bodyText1.color,
                          inactiveColor: Theme.of(context).textTheme.bodyText1.color.withBlue((Theme.of(context).brightness == Brightness.light) ? 215 : 40).withGreen((Theme.of(context).brightness == Brightness.light) ? 215 : 40).withRed((Theme.of(context).brightness == Brightness.light) ? 215 : 40),
                          value: height,
                          min: 1.05,
                          max: 3.05,
                          divisions: 8,
                          // label: 'Altura de linea: ${(height * 10).round()}',
                          onChanged: (double value) {
                            setState(() {
                              height = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),


                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: Center(
                          child: Icon(CustomIcons.format_horizontal_align_center_expand),
                        ),
                      ),
                      
                      Expanded(
                        child: Slider(
                          onChangeEnd: (value){
                            saveAndUpdateValues();
                          },

                          activeColor: Theme.of(context).textTheme.bodyText1.color,
                          inactiveColor: Theme.of(context).textTheme.bodyText1.color.withBlue((Theme.of(context).brightness == Brightness.light) ? 215 : 40).withGreen((Theme.of(context).brightness == Brightness.light) ? 215 : 40).withRed((Theme.of(context).brightness == Brightness.light) ? 215 : 40),
                          value: letterSeparation,
                          min: -1.5,
                          max: 5,
                          divisions: 13,
                          // label: 'Separación de letras: ${(letterSeparation * 10).round()}',
                          onChanged: (double value) {
                            setState(() {
                              letterSeparation = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.brightness_6, color: Theme.of(context).textTheme.bodyText1.color),
                        
                        SizedBox(width: 25),

                        Text('Tema de colores',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            // fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto-Medium',
                          ),
                        ),
                      ]
                      
                      
                      
                    ),

                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(25),
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                              ),
                              
                              child: Scaffold(
                                backgroundColor: Colors.transparent,
                                
                                appBar: AppBar(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  title: Text('Tema de colores'),
                                ),

                                body: Column(
                                  children: [
                                    Expanded(
                                      child: ListView(
                                        children: [
                                          ListTile(
                                            title: Text('Claro',
                                              style: Theme.of(context).textTheme.bodyText1,
                                            ),

                                            leading: Icon(Icons.brightness_5),
                                            onTap: (){

                                              blackThemeEnabled = false;

                                              DynamicTheme.of(context).setBrightness(Brightness.light);
                                              DynamicTheme.of(context).setThemeData(AppThemes.getTheme(Brightness.light, false));

                                              SharedPreferences.getInstance().then((preferences){
                                                preferences.setBool('darkMode', false);
                                                preferences.setBool('blackThemeEnabled', false);
                                              });

                                              Navigator.pop(context);
                                            },
                                          ),

                                          ListTile(
                                            title: Text('Oscuro',
                                              style: Theme.of(context).textTheme.bodyText1,
                                            ),

                                            leading: Icon(Icons.brightness_3),
                                            onTap: (){

                                              blackThemeEnabled = false;

                                              DynamicTheme.of(context).setBrightness(Brightness.dark);
                                              DynamicTheme.of(context).setThemeData(AppThemes.getTheme(Brightness.dark, false));

                                              SharedPreferences.getInstance().then((preferences){
                                                preferences.setBool('darkMode', true);
                                                preferences.setBool('blackThemeEnabled', false);
                                              });
                                              
                                              Navigator.pop(context);
                                            },
                                          ),

                                          ListTile(
                                            title: Text('Negro',
                                              style: Theme.of(context).textTheme.bodyText1,
                                            ),

                                            leading: Icon(Icons.brightness_1),
                                            onTap: (){

                                              blackThemeEnabled = true;

                                              DynamicTheme.of(context).setBrightness(Brightness.dark);
                                              DynamicTheme.of(context).setThemeData(AppThemes.getTheme(Brightness.dark, true));

                                              SharedPreferences.getInstance().then((preferences){
                                                preferences.setBool('darkMode', true);
                                                preferences.setBool('blackThemeEnabled', true);
                                              });

                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),

                                    ThemeSelectorFooter()
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}