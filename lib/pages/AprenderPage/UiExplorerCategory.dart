import 'package:flutter/material.dart';
import 'package:yhwh/pages/AprenderPage/Classes/Explorer.dart';
import 'dart:convert';
import 'dart:io';

class UiExplorerCategory extends StatefulWidget {
  UiExplorerCategory({
    Key key,
    this.url
  }) : super(key: key);

  final String url;

  @override
  _UiExplorerCategoryState createState() => _UiExplorerCategoryState();
}

class _UiExplorerCategoryState extends State<UiExplorerCategory> {

  String title;
  String description;
  Image background;

  @override
  void initState(){
    if(widget.url != null) {
      Explorer.getTreeFromUrl(widget.url).then((Tree folder){
        Explorer.getBlobFromUrl(folder.getTreeItemFromPath('index.json').url).then((Blob indexFile){
          Map data = json.decode(Explorer.base64ToString(indexFile.content));
          String backgroundContent;

          if(data['background'] != null && data['background'].contains('/'))
          {
            List<String> dir = data['background'].split('/');
            Tree treeTemp = folder;
            
            for(int i = 0; i < dir.length - 1; i++){
              Explorer.getTreeFromUrl(treeTemp.url).then((Tree newTree){
                treeTemp = newTree;
              });
            }

            Explorer.getBlobFromUrl(treeTemp.url).then((Blob backgroundFile){
              backgroundContent = backgroundFile.content;
            });
          }

          setState(() {
            title = data['title'];
            description = data['description'];
            background = Image.memory(base64Decode(backgroundContent));

            print(data['title']);
            print(data['description']);
            print(backgroundContent);
          });
        });
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if(widget.url == null){
      return SliverToBoxAdapter(
        child: Container(
          height: 225,
          child: Center(
            child: CircularProgressIndicator()
          ),
        ),
      );
    }

    return SliverToBoxAdapter(
      child: Container(
        child: Column(
          children: [
            title != null ? Text(title) : Text('cargando...'),
            description != null ? Text(description) : Text('cargando...'),
            // background
          ],
        ),
      ),
    );
  }
}