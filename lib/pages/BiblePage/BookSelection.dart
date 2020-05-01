import 'package:flutter/widgets.dart';
import 'package:yhwh/data/Data.dart';
import 'package:flutter/material.dart';
import 'package:diacritic/diacritic.dart';
import 'package:yhwh/pages/BiblePage/StylePage.dart';


// ignore: must_be_immutable
class BookSelection extends StatelessWidget {
  AsyncSnapshot snapshot;
  ScrollController scrollController;

  BookSelection({Key key, this.snapshot, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    snapshot = ModalRoute.of(context).settings.arguments;


    Map args = ModalRoute.of(context).settings.arguments;

    snapshot = args['snapshot'];
    scrollController = args['scrollController'];


    return MyTabbedPage(snapshot: snapshot, scrollController: scrollController,);
  }
}



// ignore: must_be_immutable
class MyTabbedPage extends StatefulWidget {
  AsyncSnapshot snapshot;
  ScrollController scrollController;


  MyTabbedPage({Key key, this.snapshot, this.scrollController}) : super(key: key);

  @override
  _MyTabbedPageState createState() =>  _MyTabbedPageState(snapshot: snapshot, scrollController: scrollController);
}




class _MyTabbedPageState extends State<MyTabbedPage> with SingleTickerProviderStateMixin {
  AsyncSnapshot snapshot;
  ScrollController scrollController;

  _MyTabbedPageState({this.snapshot, this.scrollController});

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
        elevation: 0,
        title:  Text("Seleccione un libro"),
        bottom:  TabBar(
          controller: _tabController,
          tabs: myTabs,
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children:
        [
          SelecionarLibro(tabController: _tabController, snapshot: snapshot, readViewScrollController: scrollController),
          SeleccionarCapitulo(asyncSnapshot: snapshot, tabController: _tabController, readViewScrollController: scrollController)
        ],
      )
    );
  }
}



class SelecionarLibro extends StatefulWidget
{
  TabController tabController;
  AsyncSnapshot snapshot;
  ScrollController scrollController;
  ScrollController readViewScrollController;

  SelecionarLibro({this.tabController, this.readViewScrollController, this.snapshot});
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
    widget.scrollController = ScrollController(initialScrollOffset: 56.0 * (appData.getBookNumber - 1));
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
              textInputAction: TextInputAction.done,
              onChanged: (value) {
                filterSearchResults(value);
              },

              cursorColor: Theme.of(context).accentColor,
              controller: editingController,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).accentColor,
                  )
                ),

                hintText: "Buscar",
                prefixIcon: Icon(Icons.search, color: Theme.of(context).iconTheme.color),
              )
            ),
          ),

          Expanded(
            child: Scrollbar(
              child: ListView.builder(
                controller: widget.scrollController,
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: appData.getBookNumber == index + 1
                        ? Icon(Icons.bookmark, color: Theme.of(context).iconTheme.color)
                        : Icon(Icons.bookmark_border, color: Theme.of(context).iconTheme.color),

                    title: appData.getBookNumber == index + 1
                        ? Text(items[index][1], style: TextStyle(
                      fontSize: Theme.of(context).textTheme.button.fontSize,
                      color: Theme.of(context).textTheme.button.color,
                      fontWeight: FontWeight.bold,
                      fontFamily: Theme.of(context).textTheme.button.fontFamily,))
                        : Text(items[index][1], style: Theme.of(context).textTheme.button,),

                    onTap: () async
                    {
                      appData.scrollOffset = 0;
                      await appData.loadBook(items[index][0]);
                      await appData.setChapter(1);
                      await appData.saveData();

                      setState(() {
                        widget.tabController.animateTo((widget.tabController.index + 1) % 2);
                        widget.readViewScrollController.jumpTo(0);
                      });
                    },
                  );
                },
              ),
            )
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
  ScrollController readViewScrollController;
  SeleccionarCapitulo({this.asyncSnapshot, this.tabController, this.readViewScrollController});

  _SeleccionarCapituloState createState() => _SeleccionarCapituloState();
}

class _SeleccionarCapituloState extends State<SeleccionarCapitulo>
{
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: GridView.builder(
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
                  onPressed: () async{
                    appData.scrollOffset = 0;
                    await appData.setChapter(item + 1);
                    await appData.saveData();
                    Navigator.pop(context);

                    setState(() {
                      widget.readViewScrollController.jumpTo(0);
                    });
                  },
                )
            );
          }
      ),
    );
  }
}