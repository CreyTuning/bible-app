import 'dart:convert';
import 'UiExplorerCategory.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yhwh/pages/AprenderPage/Classes/Explorer.dart';
import 'package:yhwh/pages/AprenderPage/DocViewer.dart';
import 'package:yhwh/pages/BiblePage/StylePage/fontPreference.dart';
import 'package:yhwh/ui_widgets/SliverFloatingBarLocal.dart';
import 'package:http/http.dart' as http;

import '../../ui_widgets/SliverFloatingBarLocal.dart';

class AprenderPage extends StatefulWidget {
  AprenderPage({Key key}) : super(key: key);

  @override
  _AprenderPageState createState() => _AprenderPageState();
}

class _AprenderPageState extends State<AprenderPage> {

  String testingData = '';
  String docsUrl = '';
  String categoryUrl;

  @override
  void initState() {

    // String content = 'ewogICAgInRpdGxlIiA6ICJFc3R1ZGlvcyBCaWJsaWNvcyBwb3IgQW5hIEIu\nIENvbnRyZXJhcyIsCiAgICAiZGVzY3JpcHRpb24iIDogIlVuIHNpdGlvIHBh\ncmEgZWwgZXN0dWRpbyBkZSBsYSBCaWJsaWEiLAogICAgCiAgICAiaWNvbiIg\nOiAiaW1nL2RhbmllbC5wbmciLAogICAgImJhY2tncm91bmQiIDogImltZy9k\nYW5pZWwucG5nIiwKICAgIAogICAgInR5cGUiIDogImNhdGVnb3J5Igp9\n'.replaceAll('\n', '');
    // print(latin1.decode(base64Decode(content)));
    
    // Conseguir link de la carpeta 'docs' en la base de datos online.
    // Explorer.getRepository('CreyTuning', 'DatabaseOfYhwh', 'master').then((Tree repository){
    //   setState(() {
    //     docsUrl = repository.getTreeItemFromPath('docs').url;
    //   });
    // });

    // Conseguir link de una categoria
    Explorer.getRepository('CreyTuning', 'DatabaseOfYhwh', 'master').then((Tree repository){
      Explorer.getTreeFromUrl(repository.getTreeItemFromPath('docs').url).then((Tree docs){
        setState(() {
          categoryUrl = docs.getTreeItemFromPath('Estudios Biblicos').url;
        });
      });
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark 
    )); 

    return Container(
      color: Theme.of(context).canvasColor,
      child: SafeArea(
        top: true,
        child: Scaffold(
          body: Scrollbar(
            child: CustomScrollView(
              
              slivers: [
                SliverAppBar(
                  backgroundColor: Theme.of(context).canvasColor,
                  floating: true,
                  snap: true,
                  elevation: 6,
                  titleSpacing: 0,

                  bottom: PreferredSize(
                    child: Container(
                      color: Theme.of(context).dividerColor,
                      height: 1.5
                    ),
                    
                    preferredSize: Size.fromHeight(0)
                  ),

                  title: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Container(
                            padding: EdgeInsets.only(left: 12),
                            height: 55,
                            child: Row(
                              children: [
                                Icon(Icons.search, color: Theme.of(context).textTheme.bodyText1.color),
                                SizedBox(width: 12),
                                Text('Buscar...',
                                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                                    fontSize: 17,
                                    color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.8)
                                  )
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                      Container(
                        height: 55,
                        width: 55,
                        child: PopupMenuButton(
                          tooltip: 'Mas opciones',
                          onSelected: (value) {
                            switch (value) {
                              case 1:
                                break;
                              case 2:
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => FontPreference(updateStateInBiblePage: (){})));
                                break;
                            }
                          },

                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                value: 1,
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                                      // child: Icon(Icons.folder_open),
                                    ),
                                    Text('Descargados')
                                  ],
                                )
                              ),

                              PopupMenuItem(
                                value: 2,
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                                      // child: Icon(Icons.settings),
                                    ),
                                    Text('Configuración')
                                  ],
                                )
                              ),
                            ];
                          }
                        ),
                      ),
                    ],
                  )
                ),
              
                UiExplorerCategory(url: categoryUrl)
              
              ]
            )
          )
        ),
      )
    );
  }
}