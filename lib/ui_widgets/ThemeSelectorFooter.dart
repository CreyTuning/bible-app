import 'package:flutter/material.dart';
import 'package:yhwh/pages/BiblePage/BibleInformation.dart';

class ThemeSelectorFooter extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(height: 25, color: Color(0x00)),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: RichText(
              text: TextSpan(
                text: 'Las combinaciones de colores te ayudaran a mejorar tu lectura en lugares iluminados o muy poco iluminados.',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Baloo',
                    color: Theme.of(context).textTheme.bodyText2.color,
                    height: 1.2
                )
              ),
              textAlign: TextAlign.center,
            )
        ),

        FlatButton(
          child: Text('Ministerio YHWH',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Baloo',
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyText1.color
            )
          ),
          onPressed: null
        ),

        Container(
          height: 25
        )
      ],
    );
  }
}