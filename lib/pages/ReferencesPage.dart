
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:yhwh/controllers/BiblePageController.dart';
import 'package:yhwh/controllers/ReferencesPageController.dart';
import 'package:yhwh/data/Define.dart';
import 'package:yhwh/data/valuesOfBooks.dart';

class ReferencesPage extends StatelessWidget {
  const ReferencesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ReferencesPageController>(
        init: ReferencesPageController(),
        builder: (ReferencesPageController referencesPageController) { 
          return GetBuilder<BiblePageController>(
            init: BiblePageController(),
            builder: (biblePageController) { 
              return Container(
                color: Theme.of(context).canvasColor,
                child: Stack(
                  children: [
                    // Referencias
                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
                      child: Scaffold(
                        backgroundColor: Theme.of(context).canvasColor,
                        appBar: AppBar(
                          backgroundColor: Theme.of(context).canvasColor,
                          scrolledUnderElevation: 0,
                          elevation: 0,
                          title: Text("Referencias", style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).indicatorColor
                          )),
                      
                          leading: IconButton(
                            tooltip: 'Volver',
                            icon: Icon(Icons.arrow_back, color: Theme.of(context).indicatorColor),
                            onPressed: Get.back,
                          ), 
                      
                          actions: [
                            IconButton(
                                tooltip: 'Buscar referencias',
                                color: Theme.of(context).indicatorColor,
                                onPressed: (){
                                  Get.dialog(
                                     GetBuilder<ReferencesPageController>(
                                      init: ReferencesPageController(),
                                      builder: (ReferencesPageController referencesPageController) {
                                        return Container(
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                                            color: Theme.of(context).indicatorColor,
                                          ),
                                          
                                          child: Scaffold(
                                            appBar: AppBar(
                                              backgroundColor: Theme.of(context).canvasColor,
                                              elevation: 0,
                                              title: TextField(
                                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 21, color: Theme.of(context).indicatorColor),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Buscar',
                                                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 21, color: Theme.of(context).indicatorColor.withValues(alpha: 0.5)),
                                                ),
                                                          
                                                cursorColor: Theme.of(context).indicatorColor,
                                                cursorRadius: Radius.circular(8),
                                                          
                                                autofocus: true,
                                                keyboardType: TextInputType.text,
                                                textInputAction: TextInputAction.search,
                                                autocorrect: false,
                                                onSubmitted: referencesPageController.searchTextFieldOnSubmitted,
                                                          
                                                          
                                                controller: referencesPageController.textEditingController,
                                                onChanged: referencesPageController.searchTextFieldOnChange,
                                              ),
                                                          
                                              leading: IconButton(
                                                tooltip: 'Volver',
                                                icon: Icon(Icons.arrow_back, color: Theme.of(context).indicatorColor),
                                                onPressed: Get.back
                                              ),
                                                          
                                              actions: [
                                                IconButton(
                                                  tooltip: 'Limpiar',
                                                  icon: Icon(Icons.clear, color: Theme.of(context).indicatorColor),
                                                  onPressed: referencesPageController.clearSearchTextField
                                                ),
                                              ],
                                                          
                                              bottom: PreferredSize(
                                                child: Container(
                                                  color: Theme.of(context).indicatorColor,
                                                  height: 1.5
                                                ),
                                                
                                                preferredSize: Size.fromHeight(0)
                                              ),
                                            ),
                                                          
                                            body: Container(
                                              color: Theme.of(context).canvasColor,
                                              child: ListView.builder(
                                                controller: referencesPageController.searchListScrollController,
                                                itemBuilder: (context, index) => ListTile(
                                                  title: Text(
                                                    '${intToBook[referencesPageController.searchList[index][0]]} ${referencesPageController.searchList[index][1]}:${referencesPageController.searchList[index][2]}', 
                                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                      fontSize: 18,
                                                      fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal,
                                                      color: Theme.of(context).indicatorColor
                                                    )
                                                  ),
                                                          
                                                  onTap: (){
                                                    referencesPageController.searchListItemOnTap(index);
                                                  },
                                                          
                                                  leading: Icon(Icons.search, color: Theme.of(context).indicatorColor)
                                                ),
                                                
                                                itemCount: referencesPageController.searchList.length,
                                              ),
                                            )
                                          ),
                                        );
                                      }
                                    )
                                  );
                                },
                                icon: Icon(Icons.search),
                            )
                          ],
                      
                          bottom: PreferredSize(
                            preferredSize: Size.fromHeight(kToolbarHeight),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).canvasColor,
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1.5,
                                    color: Theme.of(context).indicatorColor.withValues(alpha: 0.8)
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
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 12),
                                        child: Text("Libro", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18, color: Theme.of(context).indicatorColor), textAlign: TextAlign.center),
                                      ),
                                    ),
                                  ),
                      
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: kToolbarHeight,
                                      // color: Color(0xffEA4335),
                                      child: Text("Capitulo", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18, color: Theme.of(context).indicatorColor), textAlign: TextAlign.center),
                                    ),
                                  ),
                      
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: kToolbarHeight,
                                      // color: Color(0xff34A853),
                                      child: Text("Verso", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18, color: Theme.of(context).indicatorColor), textAlign: TextAlign.center),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      
                        body:GetBuilder<BiblePageController>(
                          init: BiblePageController(),
                          builder: (biblePageController) {
                            return Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 200,
                                      child: RawScrollbar(
                                        controller: referencesPageController.bookAutoScrollController,
                                        thumbColor: Theme.of(context).indicatorColor.withValues(alpha: 0.4),
                                        radius: Radius.circular(30),
                                        child: ListView.builder(
                                          itemExtent: 60,
                                          controller: referencesPageController.bookAutoScrollController,
                                          padding: EdgeInsets.fromLTRB(6, 8, 0, 80),
                                          itemBuilder: (context, index) {
                                            return AutoScrollTag(
                                              key: ValueKey(index),
                                              controller: referencesPageController.bookAutoScrollController!,
                                              index: index,
                                                              
                                              child: InkWell(
                                                borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30), bottomLeft: Radius.circular(6), topLeft: Radius.circular(6)),
                                                onTap: (){
                                                  biblePageController.setReference(index + 1, 1, 1);
                                                  referencesPageController.bookListOnSelect(index);
                                                  referencesPageController.chapterListOnSelect(0);
                                                  referencesPageController.verseListOnSelect(0);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(left: 6),
                                                  decoration: BoxDecoration(
                                                    color: index == biblePageController.bookNumber - 1 ? Theme.of(context).indicatorColor: Colors.transparent,
                                                    borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30), bottomLeft: Radius.circular(6), topLeft: Radius.circular(6)),
                                                  ),
                                                  // padding: EdgeInsets.only(left: 15),
                                                  alignment: Alignment.centerLeft,
                                                  height: 60,
                                                  child: Text(
                                                    '${intToBook[index + 1]}',
                                                    textAlign: TextAlign.center,
                                                    maxLines: 1,
                                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                      color: index == biblePageController.bookNumber - 1 ? Theme.of(context).canvasColor : Theme.of(context).indicatorColor,
                                                      fontSize: 18,
                                                      overflow: TextOverflow.ellipsis,
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
                              
                                    Expanded(
                                      flex: 100,
                                      child: RawScrollbar(
                                        controller: referencesPageController.chapterAutoScrollController,
                                        thumbColor: Theme.of(context).indicatorColor.withValues(alpha: 0.4),
                                        radius: Radius.circular(30),
                                        child: ListView.builder(
                                          itemExtent: 60,
                                          controller: referencesPageController.chapterAutoScrollController,
                                          padding: EdgeInsets.fromLTRB(0, 8, 0, 80),
                                          itemBuilder: (context, index) {
                                            return AutoScrollTag(
                                              key: ValueKey(index),
                                              controller: referencesPageController.chapterAutoScrollController!,
                                              index: index,
                                                              
                                              child: InkWell(
                                                customBorder: CircleBorder(),
                                                onTap: (){
                                                  biblePageController.setReference(biblePageController.bookNumber, index + 1, 1);
                                                  referencesPageController.chapterListOnSelect(index);
                                                  referencesPageController.verseListOnSelect(0);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: index == biblePageController.chapterNumber - 1 ? Theme.of(context).indicatorColor : Colors.transparent,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  alignment: Alignment.center,
                                                  height: 60,
                                                  child: Text(
                                                    '${index + 1}',
                                                    textAlign: TextAlign.center,
                                                    maxLines: 1,
                                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                      color: index == biblePageController.chapterNumber - 1 ? Theme.of(context).canvasColor : Theme.of(context).indicatorColor,
                                                      fontSize: 18,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  )
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount: valuesOfBooks[biblePageController.bookNumber - 1].length,
                                        ),
                                      ),
                                    ),
                              
                                    Expanded(
                                      flex: 100,
                                      child:RawScrollbar(
                                        controller: referencesPageController.verseAutoScrollController,
                                        thumbColor: Theme.of(context).indicatorColor.withValues(alpha: 0.4),
                                        radius: Radius.circular(30),
                                        child: ListView.builder(
                                          itemExtent: 60,
                                          controller: referencesPageController.verseAutoScrollController,
                                          padding: EdgeInsets.fromLTRB(0, 8, 0, 80),
                                          itemBuilder: (context, index) {
                                                              
                                            return AutoScrollTag(
                                              key: ValueKey(index),
                                              controller: referencesPageController.verseAutoScrollController!,
                                              index: index,
                                                              
                                              child: InkWell(
                                                customBorder: CircleBorder(),
                                                onTap: (){
                                                  biblePageController.setReferenceSafeScroll(biblePageController.bookNumber, biblePageController.chapterNumber, index + 1);
                                                  referencesPageController.verseListOnSelect(index);
                                                  Get.back();
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: index == biblePageController.verseNumber - 1 ? Theme.of(context).indicatorColor: Colors.transparent,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  alignment: Alignment.center,
                                                  height: 60,
                                                  child: Text(
                                                    '${index + 1}',
                                                    textAlign: TextAlign.center,
                                                    maxLines: 1,
                                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                      color: index == biblePageController.verseNumber - 1 ? Theme.of(context).canvasColor : Theme.of(context).indicatorColor,
                                                      fontSize: 18,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  )
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount: valuesOfBooks[biblePageController.bookNumber - 1][biblePageController.chapterNumber - 1],
                                        ),
                                      ),
                                    ),
                                  ]
                                ),
                              );
                          }
                        ),
                      ),
                    )
                  ],
                ),
                      );
            }
          );
      }
    );
  }
}
