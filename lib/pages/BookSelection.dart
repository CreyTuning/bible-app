import 'package:yhwh/data/Data.dart';
import 'package:flutter/material.dart';

class BookSelection extends StatelessWidget {
  AsyncSnapshot snapshot;

  BookSelection({Key key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    snapshot = ModalRoute.of(context).settings.arguments;

    return MyTabbedPage(snapshot: snapshot,);
  }
}

class MyTabbedPage extends StatefulWidget {
  AsyncSnapshot snapshot;

  MyTabbedPage({Key key, this.snapshot}) : super(key: key);

  @override
  _MyTabbedPageState createState() =>  _MyTabbedPageState(snapshot: snapshot);
}

class _MyTabbedPageState extends State<MyTabbedPage> with SingleTickerProviderStateMixin {
  AsyncSnapshot snapshot;

  _MyTabbedPageState({this.snapshot});

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
    return Scaffold(
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
          seleccionarCapitulo(snapshot)
        ],
      ),

      floatingActionButton:  FloatingActionButton(
        onPressed: () => _tabController.animateTo((_tabController.index + 1) % 2), // Switch tabs
        child:  Icon(Icons.swap_horiz),
      ),
    );
  }

  GridView seleccionarCapitulo(AsyncSnapshot snapshot)
  {
    return GridView.builder(
      padding: EdgeInsets.only(bottom: 150.0),
      itemCount: snapshot.data.chapters.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5
      ),

      itemBuilder: (context, item) {
        return GridTile(
          child: FlatButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            child: Text('${item + 1}', style: TextStyle(color: Colors.black, fontSize: 15)),
            onPressed: () {
              appData.setChapter(item + 1);
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
        return ListTile(
          title: Text(appData.namesAndChapters[item][0]),
          onTap: ()
          {
            setState(() {
              _tabController.animateTo((_tabController.index + 1) % 2);
              appData.loadBook(item + 1);
              appData.setChapter(1);
            });
          },
        );
      }
    );
  }
}

