import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';

class BuscarPage extends StatefulWidget {
  BuscarPage({Key key}) : super(key: key);

  @override
  _BuscarPageState createState() => _BuscarPageState();
}

class _BuscarPageState extends State<BuscarPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: SafeArea(
        top: true,
        child: FloatingSearchBar.builder(
          pinned: true,
          itemCount: 100,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Text(index.toString()),
            );
          },

          trailing: CircleAvatar(
            child: Text("Gn"),
          ),

          drawer: Drawer(
            child: Container(),
          ),

          onChanged: (String value) {},

          onTap: () {
            print('taped');
          },

          decoration: InputDecoration.collapsed(
            hintText: "Buscar...",
          ),
        ),
      ),
    );
  }
}