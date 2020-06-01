import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yhwh/data/Data.dart';
import 'package:flutter/material.dart';
import 'package:diacritic/diacritic.dart';
import 'package:yhwh/data/Define.dart';


class BookSelection extends StatefulWidget {
  BookSelection({Key key}) : super(key: key);

  @override
  _BookSelectionState createState() =>  _BookSelectionState();
}


class _BookSelectionState extends State<BookSelection> with SingleTickerProviderStateMixin {

  _BookSelectionState();

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
          SelecionarLibro(tabController: _tabController),
          SeleccionarCapitulo(tabController: _tabController)
        ],
      )
    );
  }
}



class SelecionarLibro extends StatefulWidget
{
  final TabController tabController;

  SelecionarLibro({this.tabController});
  _SelecionarLibroState createState() => _SelecionarLibroState();
}

class _SelecionarLibroState extends State<SelecionarLibro>
{
  ScrollController scrollController = ScrollController();
  TextEditingController editingController = TextEditingController();

  List<List> duplicateItems = List.generate(namesAndChapters.length, (item) {
      return [item + 1, namesAndChapters[item][0], namesAndChapters[item][1]];
  });

  var items = List<List>();

  @override
  void initState() {
    items.addAll(duplicateItems);
    scrollController = ScrollController(initialScrollOffset: 56.0 * (appData.getBookNumber - 1));
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
                controller: scrollController,
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {

                  return ListTile(
                    leading: intToBook[appData.getBookNumber] == items[index][1]
                        ? Icon(Icons.bookmark, color: Theme.of(context).iconTheme.color)
                        : Icon(Icons.bookmark_border, color: Theme.of(context).iconTheme.color),

                    title: intToBook[appData.getBookNumber] == items[index][1]
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

                      SharedPreferences.getInstance().then((preferences){
                        preferences.setInt('bookNumber', items[index][0]);
                        preferences.setInt('chapterNumber', 1);
                      });

                      setState(() {
                        widget.tabController.animateTo((widget.tabController.index + 1) % 2);
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
  final TabController tabController;
  SeleccionarCapitulo({this.tabController});

  _SeleccionarCapituloState createState() => _SeleccionarCapituloState();
}

class _SeleccionarCapituloState extends State<SeleccionarCapitulo>
{

  int chapterCount = 0;

  @override
  void initState() {
    SharedPreferences.getInstance().then((preferences){
      setState(() {
        chapterCount = namesAndChapters[preferences.getInt('bookNumber') - 1][1];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: GridView.builder(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 150.0),
          itemCount: chapterCount,
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

                    SharedPreferences.getInstance().then((preferences){
                      preferences.setInt('chapterNumber', item + 1);
                    });
                  },
                )
            );
          }
      ),
    );
  }
}