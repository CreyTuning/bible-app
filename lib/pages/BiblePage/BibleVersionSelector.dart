import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yhwh/data/Define.dart';

class BibleVersionSelector extends StatefulWidget {
  BibleVersionSelector({
    Key key,
    this.setBibleVersion
  }) : super(key: key);

  final Function(String) setBibleVersion;

  @override
  _BibleVersionSelectorState createState() => _BibleVersionSelectorState();
}

class _BibleVersionSelectorState extends State<BibleVersionSelector> {

  List<String> versiones = [
    'RVR60',
    'V1602P',
    'RVC'
  ];

  String actualVersion;

  @override
  void initState() {
    SharedPreferences.getInstance().then((preferences){
      setState(() {
        actualVersion = preferences.getString('bibleVersion') ?? 'RVR60';
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Traducción'),
          bottom: PreferredSize(
            child: Container(
              color: Theme.of(context).dividerColor,
              height: 1.5
            ),
            
            preferredSize: Size.fromHeight(0)
          ),
        ),

        body: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: versionToName[versiones[index]],
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontFamily: 'Roboto',
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyText1.color
                  ),
                ),
              ),

              subtitle: RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: versiones[index],
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    color: Theme.of(context).textTheme.bodyText2.color
                  ),
                ),
              ),
              
              leading: Icon(Icons.book),
              trailing: actualVersion == versiones[index] ? Icon(Icons.check) : SizedBox(),
              onTap: (){
                SharedPreferences.getInstance().then((preferences){
                  preferences.setString('bibleVersion', versiones[index]);
                  widget.setBibleVersion(versiones[index]);
                  Navigator.pop(context);
                });
              },
            ); 
          },

          itemCount: versiones.length,
        ),
      ),
    );
  }
}