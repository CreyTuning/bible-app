import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yhwh/controllers/HighlighterPageController.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class HighlighterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resaltados'),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        // titleSpacing: 0,
        bottom: PreferredSize(
          child: Container(
            color: Theme.of(context).dividerColor,
            height: 1.5
          ),
          
          preferredSize: Size.fromHeight(0)
        ),
      ),

      floatingActionButton: GetBuilder<HighlighterPageController>(
        init: HighlighterPageController(),
        builder: (highlighterPageController) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
              child: Icon(Icons.add, color: Theme.of(context).textTheme.bodyText1.color),
              onPressed: (){}
            ),

            SizedBox(height: 15),

            MaterialButton(
              height: 57,
              elevation: 8,
              color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
              child: Icon(Icons.remove, color: Theme.of(context).textTheme.bodyText1.color),
              shape: CircleBorder(),
              onPressed: highlighterPageController.removeToList
            ),

            SizedBox(height: 15),

            MaterialButton(
              height: 57,
              elevation: 8,
              color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
              child: Icon(Icons.delete, color: Theme.of(context).textTheme.bodyText1.color),
              shape: CircleBorder(),
              onPressed: highlighterPageController.clearList
            ),
          ],
        )
      ),

      body: GetBuilder<HighlighterPageController>(
        init: HighlighterPageController(),
        builder: (highlighterPageController) => LazyLoadScrollView(
          onEndOfPage: highlighterPageController.lazyAddMoreData,
          isLoading: true,
          child: ListView.builder(
            itemCount: highlighterPageController.data.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Text('${highlighterPageController.data[index]}'),
              );
            }
          ),
        ),
      ),
    );
  }
}