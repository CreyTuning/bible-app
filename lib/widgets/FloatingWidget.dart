import 'package:flutter/material.dart';

class FloatingWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const FloatingWidget({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(24.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Padding(
        padding: padding,
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).indicatorColor.withValues(alpha: 0.7), width: 1.0),
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.circular(18.0),
              // boxShadow: [
              //   BoxShadow(
              //     color: Theme.of(context).shadowColor.withValues(alpha: 0.5),
              //     blurRadius: 12.0,
              //     spreadRadius: 2.0,
              //     offset: Offset(0, 0)
              //   )
              // ]
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18.0),
              child: child
            )
          ),
        ),
      ),
    );
  }
}