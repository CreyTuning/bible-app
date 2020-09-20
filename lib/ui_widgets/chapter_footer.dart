import 'package:flutter/material.dart';
import 'package:yhwh/pages/BiblePage/BibleInformation.dart';

class ChapterFooter extends StatelessWidget
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
                text: 'Reina Valera 1960 ©\nPronto el texto sera revisado y corregido para ofrecer una traducción sin errores y fiel a la Palabra de Dios.',
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
          child: Text('Más información',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Baloo',
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyText1.color
            )
          ),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BibleInformation()
              )
            );
          },
        ),

        Container(
          height: 250
        )
      ],
    );
  }
}