import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:github/github.dart';
import 'package:yhwh/pages/AprenderPage/DocViewer.dart';
import 'package:yhwh/pages/BiblePage/StylePage/fontPreference.dart';
import 'package:yhwh/ui_widgets/SliverFloatingBarLocal.dart';
import 'package:http/http.dart' as http;

class AprenderPage extends StatefulWidget {
  AprenderPage({Key key}) : super(key: key);

  @override
  _AprenderPageState createState() => _AprenderPageState();
}

class _AprenderPageState extends State<AprenderPage> {

  String testingData = '';
  String docs_url = '';
  String estudios_biblicos_url = '';

  @override
  void initState() {
    
    // Conseguir link de la carpeta 'docs' en la base de datos online.
    http.read('https://api.github.com/repos/CreyTuning/DatabaseOfYhwh/git/trees/master').then((value) async {
      if(value.contains('"docs"'))
      {
        await json.decode(value)['tree'].forEach((item){
          if(item['path'] == 'docs'){
            setState(() {
              docs_url = item['url'];
            });
          }
        });
      }

      else print('La base de datos no contiene la carpeta "docs".');

    });

    http.read('https://api.github.com/repos/CreyTuning/DatabaseOfYhwh/git/trees/master').then((value) async {
      if(value.contains('"docs"'))
      {
        await json.decode(value)['tree'].forEach((item){
          if(item['path'] == 'Estudios Biblicos'){
            setState(() {
              estudios_biblicos_url = item['url'];
            });
          }
        });
      }

      else print('La base de datos no contiene la carpeta "Estudios Biblicos".');

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
          body: docs_url == ''
          
          ? Container(
            child: Center(
              child: CircularProgressIndicator()
            )
          )
          
          : Scrollbar(
            child: CustomScrollView(
              // controller: widget.autoScrollController,
              slivers: [
                SliverFloatingBarLocal(
                  backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                  floating: true,
                  snap: true,
                  elevation: 4,

                  title: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(100),
                            onTap: (){},
                            child: Container(
                              height: 40,
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

                          onTap: () {},
                          onLongPress: () {},
                          
                        ),
                      ),
                      
                      Container(
                        height: 40,
                        width: 40,
                        child: PopupMenuButton(
                          tooltip: 'Mas opciones',
                          onSelected: (value) {
                            switch (value) {
                              case 1:
                                break;
                              case 2:
                                Navigator.push(context, MaterialPageRoute(builder: (context) => FontPreference(updateStateInBiblePage: (){})));
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

                FutureBuilder(
                  future: http.read(docs_url),
                  builder: (context, snapshot)
                  {
                    if(snapshot.hasData)
                    {
                      Map data = json.decode(snapshot.data);
                
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            // Si es un documento simple sin imagenes ni indice
                            if(data['tree'][index]['type'] == 'blob')
                            {
                              return ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DocViewer(
                                        link: 'https://raw.githubusercontent.com/CreyTuning/DatabaseOfYhwh/master/docs/${data['tree'][index]['path']}',
                                        title: data['tree'][index]['path']
                                      )
                                    )
                                  );
                                },

                                leading: Icon(Icons.description),
                                title: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    text: data['tree'][index]['path'],
                                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                                      fontSize: 18
                                    )
                                  ),
                                ),

                                subtitle: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    text: '${data['tree'][index]['size'] / 1000} Kb',
                                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                                      fontSize: 16
                                    )
                                  ),
                                ),
                              );
                            }

                            // Si es una carpeta con imagenes e indice
                            else if(data['tree'][index]['type'] == 'tree'){

                              return FutureBuilder(
                                initialData: '',
                                future: http.read('https://raw.githubusercontent.com/CreyTuning/DatabaseOfYhwh/master/docs/${data['tree'][index]['path']}/index.json'),
                                builder: (context, snapshot)
                                {
                                  if(snapshot.hasData && snapshot.data != '') 
                                  {
                                    return ListTile(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DocViewer(
                                              link: 'https://raw.githubusercontent.com/CreyTuning/DatabaseOfYhwh/master/docs/${data['tree'][index]['path']}/document.md',
                                              background_link: 'https://raw.githubusercontent.com/CreyTuning/DatabaseOfYhwh/master/docs/${data['tree'][index]['path']}/background.jpg',
                                              title: jsonDecode(snapshot.data)['title']
                                            )
                                          )
                                        );
                                      },

                                      leading: jsonDecode(snapshot.data)['icon'] == true
                                      ? Container(
                                        height: 40,
                                        width: 40,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: Image.network('https://raw.githubusercontent.com/CreyTuning/DatabaseOfYhwh/master/docs/${data['tree'][index]['path']}/icon.jpg',),
                                        ),
                                      )
                                      : Icon(Icons.description),


                                      title: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(
                                          text: jsonDecode(snapshot.data)['title'],
                                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                            fontSize: 18
                                          )
                                        ),
                                      ),

                                      subtitle: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(
                                          text: jsonDecode(snapshot.data)['description'],
                                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                            fontSize: 16
                                          )
                                        ),
                                      ),
                                    );
                                  }

                                  else
                                  {
                                    return ListTile(
                                      onTap: null,
                                      // dense: true,
                                      leading: Container(
                                        height: 25,
                                        width: 25,
                                        child: CircularProgressIndicator(),
                                      ),
                                      title: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(
                                          text: 'Cargando...',
                                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                            fontSize: 18
                                          )
                                        ),
                                      )
                                    );
                                  }
                                },
                              ); 
                            }
                          },

                          childCount: data['tree'].length,
                        ),
                      );
                    }

                    else{
                      return SliverToBoxAdapter(
                        child: Center(
                          child: CircularProgressIndicator()
                        )
                      );
                    }
                  },
                )
              ]
            )
          )
        ),
      )
    );
  }
}