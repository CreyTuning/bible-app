import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:github/github.dart';
import 'package:yhwh/pages/AprenderPage/DocViewer.dart';
import 'package:yhwh/ui_widgets/SliverFloatingBarLocal.dart';

class AprenderPage extends StatefulWidget {
  AprenderPage({Key key}) : super(key: key);

  @override
  _AprenderPageState createState() => _AprenderPageState();
}

class _AprenderPageState extends State<AprenderPage> {

  String testingData = '';

  @override
  void initState() {
    rootBundle.loadString('lib/docs/example.md').then((value){
      setState(() {
        testingData = value;
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
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120),
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(top: 8),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: SafeArea(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 1,
                            spreadRadius: 0
                          )
                        ],
                      ),

                      child: Material(
                        color: Theme.of(context).appBarTheme.color,
                        borderRadius: BorderRadius.circular(15.0),
                        elevation: 3,
                        child: ListTile(
                          dense: true,
                          trailing: IconButton(icon: Icon(Icons.cloud_download, color: Theme.of(context).textTheme.bodyText1.color), onPressed: (){}),
                          title: InkWell(
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
                          )
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ),

          body: ListView(
            children: [
              ListTile(
                title: Text('Joven conforme al corazón de Dios'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return DocViewer(
                      link: 'https://raw.githubusercontent.com/CreyTuning/DatabaseOfYhwh/master/docs/%5Bpredication%5D-joven_conforme_al_corazon_de_dios.md',
                    );
                  }));
                },
              ),

              ListTile(
                title: Text('Jesucristo'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return DocViewer(
                      link: 'https://github.com/CreyTuning/DatabaseOfYhwh/raw/master/docs/jesucristo.md',
                    );
                  }));
                },
              )
            ],
          )
        ),
      )
    );
  }
}