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
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RichText(
              text: TextSpan(
                text: "La Reina Valera es una de las traducciones de la Biblia al español más frecuentemente utilizadas entre los protestantes hispanohablantes. La actual Reina Valera es el resultado de un conjunto de revisiones hechas por las Sociedades Bíblicas Unidas sobre una de las primeras traducciones de la Biblia español: la Biblia del oso de 1569.\n\nEn un sentido más amplio, incluye las revisiones hechas por otras entidades que se basan en los textos de la Reina Valera. La traducción del monje español convertido al Protestantismo, Casiodoro de Reina, conocida como la Biblia del oso de 1569, tiene la característica de ser la primera traducción de la biblia en ser realizada a partir de los textos en lenguas originales; utilizando el Texto Masorético para el Antiguo Testamento, y el Textus Receptus para el Nuevo Testamento. Previo a la publicación del trabajo completo de Casiodoro de Reina, las biblias existentes (o parte de ellas) en lengua castellana, eran traducciones hechas a partir de la Vulgata de San Jerónimo de Estridón. La Biblia del Oso fue publicada en Basilea, Suiza, el 28 de septiembre de 1569. \n\nSu traductor fue Casiodoro de Reina, religioso español convertido al protestantismo.\nRecibe el sobrenombre de Reina Valera por haber hecho Cipriano de Valera la primera revisión de ella en 1602.",
                style: TextStyle(
                  fontSize: 20,
                  height: 1.5
                ),
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
                    forceElevated: true,
                    floating: true,
                    title: Text("Reina Valera 1960 ©"),
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
