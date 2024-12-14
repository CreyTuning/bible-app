import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yhwh/controllers/BiblePageController.dart';

class HihglighterCreate extends StatelessWidget {
  const HihglighterCreate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colors = [
      0x0,
      // 0x1, funcion de copiar
      0xff8ab4f8,
      0xfff28b82,
      0xfffdd663,
      0xff81c995,
      0xffff8bcb,
      0xffd7aefb,
      0xff78d9ec
    ];

    return GetBuilder<BiblePageController>(
      init: BiblePageController(),
      builder: (biblePageController) {
        
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: colors.length,
          itemBuilder: (context, index){
            Widget widget = Container();
        
            if(colors[index] == 0x0){
              widget = Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha: 0.9),
                          width: 2.0,
                        ),
                      ),
                    ),
        
                    IconButton(
                      icon: Icon(Icons.delete_outlined),
                      iconSize: 25,
                      tooltip: 'Eliminar relsaltado',
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      disabledColor: Theme.of(context).textTheme.bodyLarge!.color,
                      onPressed: (){
                        biblePageController.removeFromHighlighter();
                        biblePageController.cancelSelectionModeOnTap();
                      }
                    ),
                  ],
                ),
              );
            }

            // FUNCION DE COPIAR VERSICULOS AL PORTAPAPELES
            // else if(colors[index] == 0x1){
            //   widget = Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 5),
            //     child: Stack(
            //       alignment: Alignment.center,
            //       children: [
            //         Container(
            //           height: 38,
            //           width: 38,
            //           decoration: BoxDecoration(
            //             shape: BoxShape.circle,
            //             border: Border.all(
            //               color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.9),
            //               width: 2.0,
            //             ),
            //           ),
            //         ),
        
            //         IconButton(
            //           icon: Icon(Icons.copy_rounded),
            //           tooltip: 'Copiar',
            //           iconSize: 25,
            //           color: Theme.of(context).textTheme.bodyText1.color,
            //           disabledColor: Theme.of(context).textTheme.bodyText1.color,
            //           onPressed: (){
            //             biblePageController.cancelSelectionModeOnTap();}
            //         ),
            //       ],
            //     ),
            //   );
            // }

            else {
              widget = Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha: 0.9),
                    ),
                  ),
        
                  IconButton(
                    icon: Icon(Icons.circle),
                    iconSize: 40,
                    color: Color(colors[index]),
                    onPressed: (){
                      biblePageController.addToHighlighter(Color(colors[index]));
                      Get.back();
                    },
                  ),
                ],
              );
            }
        
            return widget;
            return null;
          }
        );
      },
    );
  }
}