import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yhwh/classes/AppTheme.dart';
import 'package:yhwh/controllers/BiblePageController.dart';
import 'package:yhwh/controllers/ReadPreferencesController.dart';
import 'package:yhwh/data/Themes.dart';

class ReadPreferences extends StatelessWidget {
  const ReadPreferences({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(15),
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1.5
          ),
        )
      ),
      child: ClipRRect(
        // borderRadius: BorderRadius.circular(13.2),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24, tileMode: TileMode.mirror),
          child: Scaffold(
            backgroundColor: Theme.of(context).canvasColor.withValues(alpha: 0.4),
            // appBar: AppBar(
            //   elevation: 0,
            //   backgroundColor: Colors.transparent,
            //   title: Text('Ajustes visuales', 
            //     style: Theme.of(context).textTheme.bodyText1.copyWith(
            //       fontSize: 21,
            //       fontWeight: FontWeight.bold
            //     )
            //   ),
        
            //   leading: IconButton(
            //     tooltip: 'Volver',
            //     icon: Icon(Icons.arrow_back, color: Theme.of(context).textTheme.bodyText1.color),
            //     onPressed: Get.back,
            //   ),
        
            //   actions: [
            //     GetBuilder<ReadPreferencesController>(
            //           init: ReadPreferencesController(),
            //           builder: (readPreferencesController) => Tooltip(
            //         message: 'Restaurar configuraciones',
            //         child: InkWell(
            //           child: Container(
            //             child: Icon(FontAwesomeIcons.undo, color: Theme.of(context).iconTheme.color, size: 18,),
            //             width: 55,
            //             height: 55,
            //           ),
            //           borderRadius: BorderRadius.circular(30),
            //           onTap: readPreferencesController.restoreSettingOnTap
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
        
            body: GetBuilder<BiblePageController>(
              init: BiblePageController(),
              builder: (biblePageController) => GetBuilder<ReadPreferencesController>(
                init: ReadPreferencesController(),
                builder: (readPreferencesController) => Wrap(
                  children: [
                    Container(
                      height: 30,
                      child: Center(
                        child: Container(
                          height: 5,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha: 0.5)
                          ),
                        ),
                      ),
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

                            activeColor: Theme.of(context).textTheme.bodyLarge!.color,
                            inactiveColor: Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha: 0.2), //Theme.of(context).textTheme.bodyText1.color.withBlue((Theme.of(context).brightness == Brightness.light) ? 215 : 40).withGreen((Theme.of(context).brightness == Brightness.light) ? 215 : 40).withRed((Theme.of(context).brightness == Brightness.light) ? 215 : 40),
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

                            activeColor: Theme.of(context).textTheme.bodyLarge!.color,
                            inactiveColor: Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha: 0.2), //Theme.of(context).textTheme.bodyText1.color.withBlue((Theme.of(context).brightness == Brightness.light) ? 215 : 40).withGreen((Theme.of(context).brightness == Brightness.light) ? 215 : 40).withRed((Theme.of(context).brightness == Brightness.light) ? 215 : 40),
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

                            activeColor: Theme.of(context).textTheme.bodyLarge!.color,
                            inactiveColor: Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha: 0.2), //Theme.of(context).textTheme.bodyText1.color.withBlue((Theme.of(context).brightness == Brightness.light) ? 215 : 40).withGreen((Theme.of(context).brightness == Brightness.light) ? 215 : 40).withRed((Theme.of(context).brightness == Brightness.light) ? 215 : 40),
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
                          Icon(FontAwesomeIcons.palette, color: Theme.of(context).textTheme.bodyLarge!.color),
                          
                          SizedBox(width: 25),

                          Text('Temas de colores',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                                  backgroundColor: Theme.of(context).canvasColor,
                                  
                                  appBar: AppBar(
                                    backgroundColor: Theme.of(context).canvasColor,
                                    elevation: 0,
                                    title: Text('Temas de colores'),

                                    leading: IconButton(
                                      tooltip: 'Volver',
                                      icon: Icon(Icons.arrow_back, color: Theme.of(context).textTheme.bodyLarge!.color),
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
                                          child: ListView.builder(
                                            itemCount: themes.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return ListTile(
                                                title: Text('${themes.keys.elementAt(index)}'),
                                                leading: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Container(
                                                      height: 38,
                                                      width: 38,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha: 0.9),
                                                      ),
                                                    ),
                                          
                                                    IconButton(
                                                      icon: Icon(Icons.circle),
                                                      iconSize: 40,
                                                      color: AppTheme.getTheme(themes.keys.elementAt(index)).canvasColor,
                                                      onPressed: (){
                                                        // biblePageController.addToHighlighter(Color(colors[index]));
                                                        // Get.back();
                                                      },
                                                    ),
                                                  ],
                                                ),

                                                onTap: (){
                                                  readPreferencesController.setTheme(themes.keys.elementAt(index));
                                                },
                                              );
                                            },
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
                    )
                  ],
                )
              )
            ),
          ),
        ),
      ),
    );
  }
}