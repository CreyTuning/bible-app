import 'package:yhwh/data/Data.dart';
import 'package:flutter/material.dart';
import 'package:diacritic/diacritic.dart';
import 'package:yhwh/pages/StylePage.dart';


// ignore: must_be_immutable
class BookSelection extends StatelessWidget {
  AsyncSnapshot snapshot;

  BookSelection({Key key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    snapshot = ModalRoute.of(context).settings.arguments;

    return MyTabbedPage(snapshot: snapshot,);
  }
}



// ignore: must_be_immutable
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
    Tab(child: Text('Libro')),
    Tab(child: Text('Capítulo')),
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
        title:  Text("Seleccione un libro"),
        bottom:  TabBar(
          controller: _tabController,
          tabs: myTabs,
        ),
      ),

      body:  TabBarView(
        controller: _tabController,
        children:
        [
          SelecionarLibro(tabController: _tabController,),
          SeleccionarCapitulo(asyncSnapshot: snapshot, tabController: _tabController)
        ],
      ),
    );
  }
}



class SelecionarLibro extends StatefulWidget
{
  TabController tabController;
  SelecionarLibro({this.tabController});

  _SelecionarLibroState createState() => _SelecionarLibroState();
}

class _SelecionarLibroState extends State<SelecionarLibro>
{
  TextEditingController editingController = TextEditingController();

  List<List> duplicateItems = List.generate(appData.namesAndChapters.length, (item) {
      return [item + 1, appData.namesAndChapters[item][0], appData.namesAndChapters[item][1]];
  });

  var items = List<List>();

  @override
  void initState() {
    items.addAll(duplicateItems);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<List> dummySearchList = List<List>();
    dummySearchList.addAll(duplicateItems);

    if(query.isNotEmpty) {
      List<List> dummyListData = List<List>();
      dummySearchList.forEach((item) {
        if(removeDiacritics(item[1]).toLowerCase().contains(removeDiacritics(query).toLowerCase())) { // ***********************
          dummyListData.add(item);
        }
      });

      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    }

    else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterSearchResults(value);
              },

              controller: editingController,
              decoration: InputDecoration(
                  hintText: "Buscar",
                  prefixIcon: Icon(Icons.search),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.bookmark_border, color: Theme.of(context).iconTheme.color,),
                  title: Text(items[index][1], style: Theme.of(context).textTheme.button,),
                  onTap: () async
                  {
                    await appData.loadBook(items[index][0]);
                    await appData.setChapter(1);

                    setState(() {
                      widget.tabController.animateTo((widget.tabController.index + 1) % 2);
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class SeleccionarCapitulo extends StatefulWidget
{
  AsyncSnapshot asyncSnapshot;
  TabController tabController;
  SeleccionarCapitulo({this.asyncSnapshot, this.tabController});

  _SeleccionarCapituloState createState() => _SeleccionarCapituloState();
}

class _SeleccionarCapituloState extends State<SeleccionarCapitulo>
{
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 150.0),
      itemCount: widget.asyncSnapshot.data.chapters.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        childAspectRatio: 1.15
      ),

      itemBuilder: (context, item) {
        return GridTile(
            child: FlatButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              child: Text('${item + 1}', style: Theme.of(context).textTheme.button),
              onPressed: () {
                appData.setChapter(item + 1);
                Navigator.pop(context);
              },
            )
        );
      }
    );
  }
}