import 'package:flutter/material.dart';

class SelectionAppbar extends StatefulWidget {
  SelectionAppbar({
    Key key,
    @required this.child,
    @required this.appbar,
    @required this.visible
  }) : super(key: key);

  final Widget child;
  final Widget appbar;
  final bool visible;

  @override
  _SelectionAppbarState createState() => _SelectionAppbarState();
}

class _SelectionAppbarState extends State<SelectionAppbar> {
  @override
  Widget build(BuildContext context) {

    
    return LayoutBuilder(
      builder: (context, constraints) => Row(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.passthrough,
              clipBehavior: Clip.antiAlias,
              children: [
                widget.child,

                AnimatedPositioned(
                  top: widget.visible ? 0 : -80,
                  height: 80,
                  width: constraints.maxWidth,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  child: widget.appbar
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}