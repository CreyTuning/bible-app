import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yhwh/classes/AppTheme.dart';
import 'package:yhwh/controllers/BiblePageController.dart';
import 'package:yhwh/controllers/ReadPreferencesController.dart';
import 'package:yhwh/widgets/Verse.dart';

class ReadPreferences extends StatelessWidget {
  const ReadPreferences({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        title: Text('Ajustes visuales', 
          style: Theme.of(context).textTheme.bodyText1.copyWith(
            fontSize: 21,
            fontWeight: FontWeight.bold
          )
        ),

        leading: IconButton(
          tooltip: 'Volver',
          icon: Icon(Icons.arrow_back, color: Theme.of(context).textTheme.bodyText1.color),
          onPressed: Get.back,
        ),

        actions: [
          GetBuilder<ReadPreferencesController>(
                init: ReadPreferencesController(),
                builder: (readPreferencesController) => Tooltip(
              message: 'Restaurar configuraciones',
              child: InkWell(
                child: Container(
                  child: Icon(FontAwesomeIcons.undo, color: Theme.of(context).iconTheme.color, size: 18,),
                  width: 55,
                  height: 55,
                ),
                borderRadius: BorderRadius.circular(30),
                onTap: readPreferencesController.restoreSettingOnTap
              ),
            ),
          ),
        ],
      ),

      body: GetBuilder<BiblePageController>(
        init: BiblePageController(),
        builder: (biblePageController) => Container(
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
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Theme.of(context).textTheme.bodyText1.color,
                        width: 2
                      )
                    ),

                    clipBehavior: Clip.antiAlias,

                    child: Scrollbar(
                      child: ListView.builder(
                        itemBuilder: (context, index) => Verse(
                          highlight: false,
                          verseNumber: index + 1,
                          title: null,
                          text: biblePageController.versesRawList[index].text,
                          colorNumber: Theme.of(context).textTheme.bodyText2.color,
                          colorText: Theme.of(context).textTheme.bodyText1.color,
                          fontSize: biblePageController.fontSize,
                          fontHeight: biblePageController.fontHeight,
                          fontLetterSeparation: biblePageController.fontLetterSeparation,

                          onTap: (){},
                        ),

                        itemCount: biblePageController.versesRawList.length,
                      ),
                    )
                  ),
                ),
              ),

              
              GetBuilder<ReadPreferencesController>(
                init: ReadPreferencesController(),
                builder: (readPreferencesController) => Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Divider(
                        color: Colors.transparent,
                        height: 5,
                      ),
                      
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                            child: Center(
                              child: Icon(FontAwesomeIcons.textHeight),
                            ),
                          ),
                          
                          Expanded(
                            child: Slider(
                              onChangeEnd: (value){
                                readPreferencesController.onFontSizeChangeEnd(value);
                              },

                              activeColor: Theme.of(context).textTheme.bodyText1.color,
                              inactiveColor: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.2), //Theme.of(context).textTheme.bodyText1.color.withBlue((Theme.of(context).brightness == Brightness.light) ? 215 : 40).withGreen((Theme.of(context).brightness == Brightness.light) ? 215 : 40).withRed((Theme.of(context).brightness == Brightness.light) ? 215 : 40),
                              value: biblePageController.fontSize, // AQUI
                              min: 18,
                              max: 30,
                              divisions: 12,
                              // label: 'Tamaño de letra: ${fontSize.round().toString()}',
                              onChanged: (double value) {
                                readPreferencesController.onFontSizeUpdate(value);
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
                              child: Icon(FontAwesomeIcons.rulerVertical),
                            ),
                          ),
                          
                          Expanded(
                            child: Slider(
                              onChangeEnd: (value){
                                readPreferencesController.onFontHeightChangeEnd(value);
                              },

                              activeColor: Theme.of(context).textTheme.bodyText1.color,
                              inactiveColor: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.2), //Theme.of(context).textTheme.bodyText1.color.withBlue((Theme.of(context).brightness == Brightness.light) ? 215 : 40).withGreen((Theme.of(context).brightness == Brightness.light) ? 215 : 40).withRed((Theme.of(context).brightness == Brightness.light) ? 215 : 40),
                              value: biblePageController.fontHeight,
                              min: 1.05,
                              max: 3.05,
                              divisions: 8,
                              // label: 'Altura de linea: ${(height * 10).round()}',
                              onChanged: (double value) {
                                readPreferencesController.onFontHeightUpdate(value);
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
                              child: Icon(FontAwesomeIcons.rulerHorizontal),
                            ),
                          ),
                          
                          Expanded(
                            child: Slider(
                              onChangeEnd: (value){
                                readPreferencesController.onFontLetterSeparationChangeEnd(value);
                              },

                              activeColor: Theme.of(context).textTheme.bodyText1.color,
                              inactiveColor: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.2), //Theme.of(context).textTheme.bodyText1.color.withBlue((Theme.of(context).brightness == Brightness.light) ? 215 : 40).withGreen((Theme.of(context).brightness == Brightness.light) ? 215 : 40).withRed((Theme.of(context).brightness == Brightness.light) ? 215 : 40),
                              value: biblePageController.fontLetterSeparation,
                              min: -1.5,
                              max: 5,
                              divisions: 13,
                              // label: 'Separación de letras: ${(letterSeparation * 10).round()}',
                              onChanged: (double value) {
                                readPreferencesController.onFontLetterSeparationUpdate(value);
                              },
                            ),
                          ),
                        ],
                      ),

                      ListTile(
                        title: Row(
                          children: [
                            Icon(FontAwesomeIcons.palette, color: Theme.of(context).textTheme.bodyText1.color),
                            
                            SizedBox(width: 25),

                            Text('Temas de colores',
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
                                padding: const EdgeInsets.all(0),
                                child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                                    color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                                  ),
                                  
                                  child: Scaffold(
                                    backgroundColor: Colors.transparent,
                                    
                                    appBar: AppBar(
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                      title: Text('Temas de colores'),

                                      leading: IconButton(
                                        tooltip: 'Volver',
                                        icon: Icon(Icons.arrow_back, color: Theme.of(context).textTheme.bodyText1.color),
                                        onPressed: Get.back,
                                      ),

                                      bottom: PreferredSize(
                                        child: Container(
                                          color: Theme.of(context).dividerColor,
                                          height: 1.5
                                        ),
                                        
                                        preferredSize: Size.fromHeight(0)
                                      ),
                                    ),

                                    body: GetBuilder<ReadPreferencesController>(
                                      init: ReadPreferencesController(),
                                      builder: (readPreferencesController) => Column(
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
                                                    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                                                      statusBarColor: Colors.transparent,
                                                      statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark ,
                                                      systemNavigationBarIconBrightness: Brightness.dark,
                                                      systemNavigationBarColor: AppTheme.light.canvasColor
                                                    ));
                                                    
                                                    readPreferencesController.setTheme('light');
                                                  },
                                                ),

                                                ListTile(
                                                  title: Text('Oscuro',
                                                    style: Theme.of(context).textTheme.bodyText1,
                                                  ),

                                                  leading: Icon(Icons.brightness_3),
                                                  onTap: (){
                                                    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                                                      statusBarColor: Colors.transparent,
                                                      statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark ,
                                                      systemNavigationBarIconBrightness: Brightness.light,
                                                      systemNavigationBarColor: AppTheme.dark.canvasColor
                                                    ));
                                                    
                                                    readPreferencesController.setTheme('dark');
                                                  },
                                                ),

                                                ListTile(
                                                  title: Text('Negro',
                                                    style: Theme.of(context).textTheme.bodyText1,
                                                  ),

                                                  leading: Icon(Icons.brightness_1),
                                                  onTap: (){
                                                    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                                                      statusBarColor: Colors.transparent,
                                                      statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark ,
                                                      systemNavigationBarIconBrightness: Brightness.light,
                                                      systemNavigationBarColor: AppTheme.black.canvasColor
                                                    ));
                                                    
                                                    readPreferencesController.setTheme('black');
                                                  },
                                                ),

                                                Divider(
                                                  color: Theme.of(context).dividerColor,
                                                ),

                                                ListTile(
                                                  title: Text('Space Cadet',
                                                    style: Theme.of(context).textTheme.bodyText1,
                                                  ),

                                                  //leading: Icon(Icons.brightness_1, color: Color(0xff2b2d42)),
                                                  leading: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Icon(Icons.brightness_1, color: Theme.of(context).textTheme.bodyText1.color),
                                                      
                                                      Container(
                                                      width: 15,
                                                      height: 15,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle, 
                                                        color: Color(0xff2b2d42),
                                                      ),
                                                    ),
                                                    ],
                                                  ),

                                                  onTap: (){
                                                    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                                                      statusBarColor: Colors.transparent,
                                                      statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark ,
                                                      systemNavigationBarIconBrightness: Brightness.light,
                                                      systemNavigationBarColor: AppTheme.spaceCadet.canvasColor
                                                    ));
                                                    
                                                    readPreferencesController.setTheme('spaceCadet');
                                                  },
                                                ),

                                                ListTile(
                                                  title: Text('Charcoal',
                                                    style: Theme.of(context).textTheme.bodyText1,
                                                  ),

                                                  //leading: Icon(Icons.brightness_1, color: Color(0xff2b2d42)),
                                                  leading: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Icon(Icons.brightness_1, color: Theme.of(context).textTheme.bodyText1.color),
                                                      
                                                      Container(
                                                      width: 15,
                                                      height: 15,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle, 
                                                        color: Color(0xff264653),
                                                      ),
                                                    ),
                                                    ],
                                                  ),

                                                  onTap: (){
                                                    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                                                      statusBarColor: Colors.transparent,
                                                      statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark ,
                                                      systemNavigationBarIconBrightness: Brightness.light,
                                                      systemNavigationBarColor: AppTheme.charcoal.canvasColor
                                                    ));
                                                    
                                                    readPreferencesController.setTheme('charcoal');
                                                  },
                                                ),

                                                ListTile(
                                                  title: Text('Pansy Purple',
                                                    style: Theme.of(context).textTheme.bodyText1,
                                                  ),

                                                  //leading: Icon(Icons.brightness_1, color: Color(0xff2b2d42)),
                                                  leading: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Icon(Icons.brightness_1, color: Theme.of(context).textTheme.bodyText1.color),
                                                      
                                                      Container(
                                                      width: 15,
                                                      height: 15,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle, 
                                                        color: Color(0xff830b53),
                                                      ),
                                                    ),
                                                    ],
                                                  ),

                                                  onTap: (){
                                                    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                                                      statusBarColor: Colors.transparent,
                                                      statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark ,
                                                      systemNavigationBarIconBrightness: Brightness.light,
                                                      systemNavigationBarColor: AppTheme.pansyPurple.canvasColor
                                                    ));
                                                    
                                                    readPreferencesController.setTheme('pansyPurple');
                                                  },
                                                ),


                                              ],
                                            ),
                                          ),

                                          // Container(color: Colors.red,)
                                          // ThemeSelectorFooter()
                                        ],
                                      ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}