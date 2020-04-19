import 'package:flutter/material.dart';
import 'package:yhwh/ui_widgets/ui_verse.dart';

class ChapterFooter extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(height: 50, color: Color(0x00)),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: RichText(
              text: TextSpan(text: 'La Valera 1602 Purificada es la obra de la Iglesia Bautista Bíblica de la Gracia en Monterrey.',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Baloo',
                      letterSpacing: 1,
                      color: Colors.black54,
                      height: 1
                  )
              ),
              textAlign: TextAlign.center,
            )
        ),

        FlatButton(
          splashColor: Colors.white,
            child: Text('Quiero saber más',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Baloo',
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Colors.green,
              )),
          onPressed: (){Navigator.pushNamed(context, 'bible_information');},
        ),

        Container(height: 230)
      ],
    );
  }
}