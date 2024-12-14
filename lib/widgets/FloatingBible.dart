import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yhwh/controllers/FloatingBibleController.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:yhwh/data/Define.dart';
import 'package:yhwh/pages/HighlighterCreate.dart';
import 'package:yhwh/widgets/Verse.dart';

class FloatingBible extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FloatingBibleController>(
      init: FloatingBibleController(),
      builder: (floatingBibleController) =>  OrientationBuilder(
        builder: (context, orientation) => Container(
          color: Theme.of(context).canvasColor.withOpacity(0.5),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8, tileMode: TileMode.clamp),
            child: AnimatedPadding(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: EdgeInsets.fromLTRB(
                  (orientation == Orientation.landscape) ? floatingBibleController.padding_width_landscape : floatingBibleController.padding_width_portrait, // left
                  (orientation == Orientation.landscape) ? floatingBibleController.padding_height_landscape : floatingBibleController.padding_height_portrait, // top
                  (orientation == Orientation.landscape) ? floatingBibleController.padding_width_landscape : floatingBibleController.padding_width_portrait, // right
                  (orientation == Orientation.landscape) ? floatingBibleController.padding_height_landscape : floatingBibleController.padding_height_portrait, // bottom
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      width: 2,
                      color: Theme.of(context).dividerColor
                    )
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(19),
                    child: Scaffold( 
                      body: GetBuilder<FloatingBibleController>(
                        init: FloatingBibleController(),
                        builder: (floatingBibleController) => NotificationListener<ScrollNotification>(
                          onNotification: floatingBibleController.scrollNotification,
                          child: RawScrollbar(
                            controller: floatingBibleController.autoScrollController,
                            thumbColor: Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha: 0.4),
                            child: CustomScrollView(
                              controller: floatingBibleController.autoScrollController,
                              slivers: [
                                // AppBar
                                SliverAppBar(
                                  backgroundColor: Theme.of(context).appBarTheme.backgroundColor!.withValues(alpha: 0.2),
                                  primary: true,
                                  floating: false,
                                  automaticallyImplyLeading: false,
                                  // snap: false,
                                  // primary: true,
                                  pinned: true,
                                  elevation: 0,
                                  titleSpacing: 0,
                                  bottom: PreferredSize(
                                    child: Container(
                                      color: Theme.of(context).dividerColor,
                                      height: 1.5
                                    ),
                                    
                                    preferredSize: Size.fromHeight(0)
                                  ),
                            
                                  flexibleSpace: ClipRRect(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 24,
                                        sigmaY: 24,
                                        tileMode: TileMode.mirror
                                      ),
                                      child: Container(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                  
                                  title: AnimatedCrossFade(
                                    sizeCurve: Curves.easeInOut,
                                    duration: Duration(milliseconds: 300),
                                    crossFadeState: floatingBibleController.selectionMode == false ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                    firstChild: Container(
                                      height: 65,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Tooltip(
                                              message: 'Referencia',
                                              child: InkWell(
                                                // borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
                                                child: Container(
                                                  height: 55,
                                                  alignment: Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: EdgeInsets.fromLTRB(17, 0, 0, 0),
                                                    child: RichText(
                                                      textAlign: TextAlign.left,
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      text: TextSpan(
                                                        text: '${intToAbreviatura[floatingBibleController.bookNumber]} ${floatingBibleController.chapterNumber}:${floatingBibleController.verseNumber}-${floatingBibleController.verseNumber_to}',
                                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                          fontFamily: 'Roboto-Medium',
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 18,
                                                        ),
                                                      )
                                                    ),
                                                  ),
                                                ),
                                    
                                                // onTap: floatingBibleController.referenceButtonOnTap,
                                                
                                              ),
                                            ),
                                          ),
                                    
                                          IconButton(
                                            tooltip: 'Abrir en la biblia',
                                            onPressed: (){
                                              floatingBibleController.cancelSelectionModeOnTap();
                                              floatingBibleController.ShowInBiblePage();
                                              Get.back();
                                            },
                                            icon: Icon(Icons.open_in_new_rounded),
                                            // iconSize: 25,
                                          ),
                                    
                                          Container(width: 5),
      
                                          IconButton(
                                            tooltip: 'Cerrar',
                                            onPressed: (){
                                              floatingBibleController.cancelSelectionModeOnTap();
                                              Get.back();
                                              // Get.to(()=> ReadPreferences());
                                              /*
                                                Recuerda agregar floatingBibleController.cancelSelectionModeOnTap(),
                                                para evitar un posible bug al momento de entrar en modo
                                                seleccion y presionar alguna otra funccion en pantalla.
                                              */
                                            },
                                            icon: Icon(Icons.close_rounded),
                                            iconSize: 27,
                                          ),
                                    
                                          Container(width: 5,)
                                        ],
                                      )
                                    ),
                            
                                    secondChild: Container(
                                      height: 90,
                                      child: Row(
                                        children: [
                                          IconButton(
                                            tooltip: 'Cancelar',
                                            icon: Icon(Icons.arrow_back),
                                            iconSize: 30,
                                            onPressed: floatingBibleController.cancelSelectionModeOnTap,
                                          ),
                                    
                                          Expanded(
                                            child: HihglighterCreate()
                                          ),
                                    
                                          // Container(width: 12,)
                                        ],
                                      )
                                    ),
                                  )
                                ),
                            
                                // Verses list
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (BuildContext buildContext, int index){
                                      return AutoScrollTag(
                                        key: ValueKey(index),
                                        controller: floatingBibleController.autoScrollController!,
                                        index: index,
                            
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 15),
                                          child: Verse(
                                            highlight: floatingBibleController.versesRawList[index].highlight!,
                                            selected: floatingBibleController.versesSelected.contains(index + 1),
                                            verseNumber: floatingBibleController.versesRawList[index].verseNumber!,
                                            title: floatingBibleController.versesRawList[index].title!,
                                            text: floatingBibleController.versesRawList[index].text!,
                                            colorHighlight: floatingBibleController.versesRawList[index].colorHighlight!,
                                            colorNumber: Theme.of(context).textTheme.bodyMedium!.color!,
                                            colorText: Theme.of(context).textTheme.bodyLarge!.color!,
                                            fontSize: floatingBibleController.fontSize,
                                            fontHeight: floatingBibleController.fontHeight,
                                            fontLetterSeparation: floatingBibleController.fontLetterSeparation,
                                            fontFamily: floatingBibleController.fontFamily,
                                            isFirstVerseShowed: (index == 0) ? true : false,
                                            onReferenceTap: (int book, int chapter, int verse_from, int verse_to){
                                              floatingBibleController.setReference(book, chapter, verse_from, verse_to);
                                            },
                                          ),
                                        )
                                      );
                                    },
                            
                                    childCount: floatingBibleController.versesRawList.length,
                                  ),
                                ),
    
                                SliverToBoxAdapter(
                                  child: Container(height: Get.size.height * 0.05),
                                )
                            
                                // Chapter footer
                                // ChapterFooter(
                                //   bibleVersion: floatingBibleController.bibleVersion,
                                // )
                            
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ),
    );
  }
}