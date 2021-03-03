import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yhwh/data/Define.dart';
import 'package:yhwh/models/highlighterItem.dart';

class VerseExplorerHighlighterWidget extends StatefulWidget {
  VerseExplorerHighlighterWidget({
    Key key,
    @required this.highlighterItem
  }) : super(key: key);

  final HighlighterItem highlighterItem;

  @override
  _VerseExplorerHighlighterWidgetState createState() => _VerseExplorerHighlighterWidgetState();
}

class _VerseExplorerHighlighterWidgetState extends State<VerseExplorerHighlighterWidget> with TickerProviderStateMixin {

  AnimateIconController animateIconController;
  bool isOpen = true;
  
  @override
  void initState() { 
    super.initState();
    animateIconController = AnimateIconController();
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      // height: height,
      
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: AnimatedCrossFade(
              duration: Duration(milliseconds: 300),
              crossFadeState: !isOpen ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              firstChild: ListTile(
                title: Text('Resaltado', style: Theme.of(context).textTheme.bodyText1),
                leading: Icon(
                  FontAwesomeIcons.highlighter,
                  color: Theme.of(context).textTheme.bodyText1.color,
                  size: 21,
                ),
              ),

              secondChild: Column(
                children: [
                  ListTile(
                    title: Text('Resaltado', style: Theme.of(context).textTheme.bodyText1),
                    leading: Icon(
                      FontAwesomeIcons.highlighter,
                      color: Theme.of(context).textTheme.bodyText1.color,
                      size: 21,
                    ),
                  ),

                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity(),
                    title: Text('Color: ${widget.highlighterItem.color}', style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: 16
                    )),
                  ),

                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity(),
                    title: Text('Fecha: ${monthDayToString[widget.highlighterItem.dateTime.month]}, ${widget.highlighterItem.dateTime.day} de ${widget.highlighterItem.dateTime.year}', style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: 16
                    )),
                  ),

                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity(),
                    title: Text('Hora: ${widget.highlighterItem.dateTime.hour}:${widget.highlighterItem.dateTime.minute}', style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: 16
                    )),
                  ),

                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity(),
                    title: Text('Versos: ${widget.highlighterItem.verses}', style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: 16
                    )),
                  ),

                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity(),
                    title: Text('Id: ${widget.highlighterItem.id}', style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: 16
                    )),
                  )
                ],
              )
            )
          ),

          Padding(
            padding: EdgeInsets.only(top: 5),
            child: AnimateIcons(
              duration: Duration(milliseconds: 300),
              startIcon: Icons.keyboard_arrow_down_rounded,
              endIcon: Icons.keyboard_arrow_up_rounded,
              startTooltip: 'Expandir',
              endTooltip: 'Contraer',
              
              onStartIconPress: (){
                onTap();
                return true;
              },

              onEndIconPress: (){
                onTap();
                return true;
              },

              controller: animateIconController,
              startIconColor: Theme.of(context).textTheme.bodyText1.color,
              endIconColor: Theme.of(context).textTheme.bodyText1.color,
              clockwise: true,
            ),
          ),
        ],
      ),
    );
  }

  void onTap(){
    setState((){
      // height = isOpen ? 56.0 : 220.0;
      isOpen = !isOpen;

      if (animateIconController.isStart()) {
          animateIconController.animateToEnd();
      } else if (animateIconController.isEnd()) {
          animateIconController.animateToStart();
      }

    });
  }
}