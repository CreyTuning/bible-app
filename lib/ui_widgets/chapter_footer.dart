import 'package:flutter/material.dart';

class ChapterFooter extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(height: 40, color: Color(0x00)),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: RichText(
              text: TextSpan(text: 'Biblia YHWH\nGratuita y de libre distribución.',
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
          splashColor: Colors.white,
            child: Text('Más información',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Baloo',
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor,
              )),
          onPressed: (){Navigator.pushNamed(context, 'bible_information');},
        ),

        Container(height: 100)
      ],
    );
  }
}