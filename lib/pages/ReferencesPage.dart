import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:yhwh/controllers/BiblePageController.dart';
import 'package:yhwh/controllers/ReferencesPageController.dart';
import 'package:yhwh/data/Define.dart';
import 'package:yhwh/data/valuesOfBooks.dart';

class ReferencesPage extends StatelessWidget {
  const ReferencesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Theme.of(context).canvasColor,
      child: Stack(
        children: [

          // Referencias
          Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).canvasColor,
              elevation: 0,
              title: Text("Referencias", style: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: 21,
                fontWeight: FontWeight.bold
              )),

              leading: IconButton(
                tooltip: 'Volver',
                icon: Icon(Icons.arrow_back, color: Theme.of(context).appBarTheme.iconTheme.color),
                onPressed: Get.back,
              ), 

              actions: [
                GetBuilder<ReferencesPageController>(
                  init: ReferencesPageController(),
                  builder: (ReferencesPageController referencesPageController) => IconButton(
                    tooltip: 'Buscar referencias',
                    onPressed: (){
                      showDialog(
                        context: context,
                        builder: (context) {
                          return GetBuilder<ReferencesPageController>(
                            init: ReferencesPageController(),
                            builder: (ReferencesPageController referencesPageController) => Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                                color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                              ),
                              
                              child: Scaffold(
                                appBar: AppBar(
                                  backgroundColor: Theme.of(context).canvasColor,
                                  elevation: 0,
                                  title: TextField(
                                    style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 21),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Buscar',
                                      hintStyle: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 21),
                                    ),

                                    cursorColor: Theme.of(context).textTheme.bodyText1.color,
                                    autofocus: true,

                                    controller: referencesPageController.textEditingController,
                                    onChanged: referencesPageController.searchTextFieldOnChange,
                                  ),

                                  leading: IconButton(
                                    tooltip: 'Volver',
                                    icon: Icon(Icons.arrow_back, color: Theme.of(context).appBarTheme.iconTheme.color),
                                    onPressed: Get.back
                                  ),

                                  actions: [
                                    IconButton(
                                      tooltip: 'Limpiar',
                                      icon: Icon(Icons.clear, color: Theme.of(context).appBarTheme.iconTheme.color),
                                      onPressed: referencesPageController.clearSearchTextField
                                    ),
                                  ],

                                  bottom: PreferredSize(
                                    child: Container(
                                      color: Theme.of(context).dividerColor,
                                      height: 1.5
                                    ),
                                    
                                    preferredSize: Size.fromHeight(0)
                                  ),
                                ),

                                body: ListView.builder(
                                  controller: referencesPageController.searchListScrollController,
                                  itemBuilder: (context, index) => ListTile(
                                    title: Text(
                                      '${intToBook[referencesPageController.searchList[index][0]]} ${referencesPageController.searchList[index][1]}:${referencesPageController.searchList[index][2]}', 
                                      style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 18)
                                    ),

                                    onTap: (){
                                      referencesPageController.searchListItemOnTap(index);
                                    },
                                  ),
                                  
                                  itemCount: referencesPageController.searchList.length,
                                )
                              ),
                            ),
                          );
                        }
                      );
                    },
                    icon: Icon(Icons.search),
                  ),
                )
              ],

              bottom: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).dividerColor
                      )
                    )
                  ),

                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: kToolbarHeight,
                          // color: Color(0xff4285f4),
                          child: Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Text("Libro", style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.center),
                          ),
                        ),
                      ),

                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: kToolbarHeight,
                          // color: Color(0xffEA4335),
                          child: Text("Capitulo", style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.center),
                        ),
                      ),

                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: kToolbarHeight,
                          // color: Color(0xff34A853),
                          child: Text("Verso", style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.center),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            body: GetBuilder<BiblePageController>(
              init: BiblePageController(),
              builder: (controller) => Container(
                child: Row(
                  children: [
                    Expanded(
                      flex: 200,
                      child: Scrollbar(
                        child: GetBuilder<ReferencesPageController>(
                          init: ReferencesPageController(),
                          builder: (referencesPageController)=> ListView.builder(
                            itemExtent: 60,
                            controller: referencesPageController.bookAutoScrollController,
                            padding: EdgeInsets.fromLTRB(6, 8, 0, 80),
                            itemBuilder: (context, index) {
                              return AutoScrollTag(
                                key: ValueKey(index),
                                controller: referencesPageController.bookAutoScrollController,
                                index: index,

                                child: InkWell(
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30), bottomLeft: Radius.circular(6), topLeft: Radius.circular(6)),
                                  onTap: (){
                                    controller.setReference(index + 1, 1, 1);
                                    referencesPageController.bookListOnSelect(index);
                                    referencesPageController.chapterListOnSelect(0);
                                    referencesPageController.verseListOnSelect(0);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(left: 6),
                                    decoration: BoxDecoration(
                                      color: index == controller.bookNumber - 1 ? Theme.of(context).textTheme.bodyText1.color: Colors.transparent,
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30), bottomLeft: Radius.circular(6), topLeft: Radius.circular(6)),
                                    ),
                                    // padding: EdgeInsets.only(left: 15),
                                    alignment: Alignment.centerLeft,
                                    height: 60,
                                    child: Text(
                                      '${intToBook[index + 1]}',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                                        color: index == controller.bookNumber - 1 ? Theme.of(context).canvasColor : Theme.of(context).textTheme.bodyText1.color,
                                      ),
                                    )
                                  ),
                                ),
                              );
                            },

                            itemCount: 66,
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 100,
                      child: Scrollbar(
                        child: GetBuilder<ReferencesPageController>(
                          init: ReferencesPageController(),
                          builder: (referencesPageController)=> ListView.builder(
                            itemExtent: 60,
                            controller: referencesPageController.chapterAutoScrollController,
                            padding: EdgeInsets.fromLTRB(0, 8, 0, 80),
                            itemBuilder: (context, index) {
                              return AutoScrollTag(
                                key: ValueKey(index),
                                controller: referencesPageController.chapterAutoScrollController,
                                index: index,

                                child: InkWell(
                                  customBorder: CircleBorder(),
                                  onTap: (){
                                    controller.setReference(controller.bookNumber, index + 1, 1);
                                    referencesPageController.chapterListOnSelect(index);
                                    referencesPageController.verseListOnSelect(0);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: index == controller.chapterNumber - 1 ? Theme.of(context).textTheme.bodyText1.color: Colors.transparent,
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    height: 60,
                                    child: Text(
                                      '${index + 1}',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                                        color: index == controller.chapterNumber - 1 ? Theme.of(context).canvasColor : Theme.of(context).textTheme.bodyText1.color,
                                      ),
                                    )
                                  ),
                                ),
                              );
                            },
                            itemCount: valuesOfBooks[controller.bookNumber - 1].length,
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 100,
                      child: Scrollbar(
                        child: GetBuilder<ReferencesPageController>(
                          init: ReferencesPageController(),
                          builder: (referencesPageController)=> ListView.builder(
                            itemExtent: 60,
                            controller: referencesPageController.verseAutoScrollController,
                            padding: EdgeInsets.fromLTRB(0, 8, 0, 80),
                            itemBuilder: (context, index) {

                              return AutoScrollTag(
                                key: ValueKey(index),
                                controller: referencesPageController.verseAutoScrollController,
                                index: index,

                                child: InkWell(
                                  customBorder: CircleBorder(),
                                  onTap: (){
                                    controller.setReference(controller.bookNumber, controller.chapterNumber, index + 1);
                                    referencesPageController.verseListOnSelect(index);
                                    Get.back();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: index == controller.verseNumber - 1 ? Theme.of(context).textTheme.bodyText1.color: Colors.transparent,
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    height: 60,
                                    child: Text(
                                      '${index + 1}',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                                        color: index == controller.verseNumber - 1 ? Theme.of(context).canvasColor : Theme.of(context).textTheme.bodyText1.color,
                                      ),
                                    )
                                  ),
                                ),
                              );
                            },
                            itemCount: valuesOfBooks[controller.bookNumber - 1][controller.chapterNumber - 1],
                          ),
                        ),
                      ),
                    ),
                  ]
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
