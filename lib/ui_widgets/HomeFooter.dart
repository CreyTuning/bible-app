import 'package:flutter/material.dart';

class HomeFooter extends StatelessWidget
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
                text: 'Aplicación desarrollada para el estudio bíblico, completamente libre y de código abierto para los que buscan el camino, la verdad y la vida.',
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
          height: 125
        )
      ],
    );
  }
}