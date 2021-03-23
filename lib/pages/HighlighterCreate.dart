import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yhwh/controllers/BiblePageController.dart';

class HihglighterCreate extends StatelessWidget {
  const HihglighterCreate({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1.5
          )
        )
      ),

      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0,
          
          title: Text("Resaltar", style: Theme.of(context).textTheme.bodyText1.copyWith(
            fontSize: 21,
            fontWeight: FontWeight.bold
          )),

          leading: IconButton(
            tooltip: 'Volver',
            icon: Icon(Icons.clear, color: Theme.of(context).textTheme.bodyText1.color),
            onPressed: Get.back,
          )
        ),

        body: GetBuilder<BiblePageController>(
          init: BiblePageController(),
          builder: (biblePageController) {
            
            return ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(right: 6, bottom: 12),

              children: [

                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: InkWell(
                    onTap: (){
                      biblePageController.removeFromHighlighter();
                      Get.back();
                    },
                    radius: 30,
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.5),
                          width: 1.5
                        )
                      ),

                      child: Icon(Icons.delete),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: InkWell(
                    onTap: (){
                      biblePageController.addToHighlighter(Color(0xff8ab4f8));
                      Get.back();
                    },
                    radius: 30,
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Color(0xff8ab4f8),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.5),
                          width: 1.5
                        )
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: InkWell(
                    onTap: (){
                      biblePageController.addToHighlighter(Color(0xfff28b82));
                      Get.back();
                    },
                    radius: 30,
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Color(0xfff28b82),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.5),
                          width: 1.5
                        )
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: InkWell(
                    onTap: (){
                      biblePageController.addToHighlighter(Color(0xfffdd663));
                      Get.back();
                    },
                    radius: 30,
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Color(0xfffdd663),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.5),
                          width: 1.5
                        )
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: InkWell(
                    onTap: (){
                      biblePageController.addToHighlighter(Color(0xff81c995));
                      Get.back();
                    },
                    radius: 30,
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Color(0xff81c995),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.5),
                          width: 1.5
                        )
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: InkWell(
                    onTap: (){
                      biblePageController.addToHighlighter(Color(0xffff8bcb));
                      Get.back();
                    },
                    radius: 30,
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Color(0xffff8bcb),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.5),
                          width: 1.5
                        )
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: InkWell(
                    onTap: (){
                      biblePageController.addToHighlighter(Color(0xffd7aefb));
                      Get.back();
                    },
                    radius: 30,
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Color(0xffd7aefb),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.5),
                          width: 1.5
                        )
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: InkWell(
                    onTap: (){
                      biblePageController.addToHighlighter(Color(0xff78d9ec));
                      Get.back();
                    },
                    radius: 30,
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Color(0xff78d9ec),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.5),
                          width: 1.5
                        )
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}