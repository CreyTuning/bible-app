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
                  text: "Obra de la Iglesia Bautista Bíblica de la Gracia en Monterrey.\n\nSe han invertido años en el proceso de la purificación de la Biblia de Valera 1602.\n\nMuchos creemos que el texto griego neo-testamentario que Dios siempre ha bendecido por los siglos de la iglesia es el texto conocido como el “Texto Recibido”.\n\nSi usted está de acuerdo con este principio, entonces usará una Biblia que lleva el nombre “Reina Valera” (pero no la “Reina Valera Actualizada”, la cual es una Biblia basada en el texto corrupto conocido como el “Texto Alejandrino” o el “Texto Crítico”).\n\nPero, ¿cuál edición de la Reina Valera debemos usar? Hubo muchas revisiones de ella. Principalmente los cristianos evangélicos hemos usado o la Antigua Versión de 1909 o la Revisión de 1960.\n\nLa Revisión de 1865 fue impresa en cantidades grandes hasta como 1950, y últimamente está siendo reimpresa por una iglesia bautista independiente.\n\nTambién la Sociedad Bíblica Trinitaria de Inglaterra hizo una revisión de la Antigua Versión en 2001 que corrigió muchas de las discrepancias en la Antigua Versión de 1909.",
                  style: TextStyle(fontFamily: 'Roboto', fontSize: 18, color: Color(0xff263238),)
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );

    return Container(
      color: Colors.green,
      child: SafeArea(
        child: Scaffold(
            body: Scrollbar(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    forceElevated: true,
                    floating: true,
                    backgroundColor: Colors.green,
                     title: Text(
                      "Valera 1602 Purificada",
                      style: TextStyle(fontFamily: 'Roboto', fontSize: 20, fontWeight: FontWeight.bold),
                    ),
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
