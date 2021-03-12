import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yhwh/controllers/VerseExplorerController.dart';

class VerseExplorer extends StatelessWidget {
  const VerseExplorer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerseExplorerController>(
      init: VerseExplorerController(),
      builder: (verseExplorerController) => Scaffold(
        appBar: AppBar(
          title: Text(verseExplorerController.title),
          elevation: 0,
          
          leading: IconButton(
            tooltip: 'Volver',
            icon: Icon(Icons.arrow_back, color: Theme.of(context).appBarTheme.iconTheme.color),
            onPressed: Get.back,
          ),

          actions: [
            
          ],

          bottom: PreferredSize(
            child: Container(
              color: Theme.of(context).dividerColor,
              height: 1.5
            ),
          
            preferredSize: Size.fromHeight(0)
          ),
        ),


        body: ListView.separated(
          itemCount: verseExplorerController.content.length,
          separatorBuilder: (context, index) => Divider(color: Theme.of(context).dividerColor, height: 0),
          itemBuilder: (context, index) => verseExplorerController.content[index],
        )
      )
    );
  }
}