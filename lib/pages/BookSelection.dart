import 'package:yhwh/data/Data.dart';
import 'package:flutter/material.dart';

class BookSelection extends StatefulWidget {
  BookSelection({Key key}) : super(key: key);

  @override
  _BookSelectionState createState() => _BookSelectionState();
}

class _BookSelectionState extends State<BookSelection>
{
  @override
  Widget build(BuildContext context) {
    return MyTabbedPage();
  }
}

class MyTabbedPage extends StatefulWidget {
  const MyTabbedPage({Key key}) : super(key: key);

  @override
  _MyTabbedPageState createState() =>  _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage> with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(child: Text('LIBRO', style: TextStyle(color: Colors.black))),
    Tab(child: Text('CAPÍTULO', style: TextStyle(color: Colors.black))),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =  TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title:  Text("Seleccione un libro", style: TextStyle(color: Colors.black)),
        bottom:  TabBar(
          controller: _tabController,
          tabs: myTabs,
        ),
      ),

      body:  TabBarView(
        controller: _tabController,
        children: 
        [
          selecionarLibro(),
          seleccionarCapitulo()
        ],
      ),

      floatingActionButton:  FloatingActionButton(
        onPressed: () => _tabController.animateTo((_tabController.index + 1) % 2), // Switch tabs
        child:  Icon(Icons.swap_horiz),
      ),
    );
  }

  GridView seleccionarCapitulo()
  {
    return GridView.builder
    (
      padding: EdgeInsets.only(bottom: 150.0),
      itemCount: appData.chaptersCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount
      (
        crossAxisCount: 5
      ),
      
      itemBuilder: (context, item)
      {
        return GridTile(
          child: FlatButton
          (
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            child: Text('${item + 1}', style: TextStyle(color: Colors.black, fontSize: 15)),
            onPressed: ()
            {
              appData.chapter = item + 1;
              Navigator.pop(context);
            },
          )
        );
      }
    );
  }

  ListView selecionarLibro()
  {
    return ListView.builder
    (
      itemCount: 66,
      itemBuilder: (context, item)
      {
        return ListTile
        (
          title: Text(appData.librosConCapitulo[item][0]),
          onTap: ()
          {
            setState(() {
              _tabController.animateTo((_tabController.index + 1) % 2);
              appData.chaptersCount = appData.librosConCapitulo[item][1];
              appData.book = item + 1;
              appData.chapter = 1;
            });
          },
        );
      }
    );
  }
}

