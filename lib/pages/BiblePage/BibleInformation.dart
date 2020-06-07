import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class BibleInformation extends StatefulWidget {
  @override
  _BibleInformationState createState() => _BibleInformationState();
}

class _BibleInformationState extends State<BibleInformation>
{

  List<Widget> content = List<Widget>();

  @override
  Widget build(BuildContext context) {

    final content = Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RichText(
              text: TextSpan(
                  text: "La Palabra de Dios",
                  style: Theme.of(context).textTheme.bodyText1
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );

    return Container(
      color: Theme.of(context).appBarTheme.color,
      child: SafeArea(
        child: Scaffold(
            body: Scrollbar(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    forceElevated: false,
                    floating: true,
                     title: Text("Información"),
                  ),

                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, item){
                      return content;
                    },
                    childCount: 1
                    ),
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}
