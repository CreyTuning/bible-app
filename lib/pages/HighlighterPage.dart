import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yhwh/controllers/HighlighterPageController.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:yhwh/pages/HighlighterViewerPage.dart';
import 'package:yhwh/widgets/CardVerseHightlight.dart';

class HighlighterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        
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

      floatingActionButton: GetBuilder<HighlighterPageController>(
        init: HighlighterPageController(),
        builder: (highlighterPageController) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
          child: Scrollbar(
            child: ListView.separated(
              itemCount: highlighterPageController.data.length,
              padding: EdgeInsets.only(bottom: 75),
              
              separatorBuilder: (context, index) => Divider(
                color: Theme.of(context).dividerColor,
                height: 0,
                thickness: 0,
                indent: 12,
                endIndent: 12,
              ),
              
              itemBuilder: (context, index){
                return CardVerseHightlight(
                  highlighterItem: highlighterPageController.data[index],
                  onTap: (){
                    Get.to(()=> HighlighterViewerPage(), arguments: highlighterPageController.data[index]);
                  },
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}