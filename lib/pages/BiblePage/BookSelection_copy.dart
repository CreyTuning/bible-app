import 'dart:convert';

import 'package:diacritic/diacritic.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:yhwh/data/Define.dart';


class BookSelectionPage extends StatefulWidget {
  BookSelectionPage({
    @required this.setReference,
    @required this.getReference,
  });

  final void Function(int book, int chapter, int verse) setReference;
  final List<int> Function() getReference;

  @override
  _BookSelectionPageState createState() =>  _BookSelectionPageState();
}


class _BookSelectionPageState extends State<BookSelectionPage> with SingleTickerProviderStateMixin {
  _BookSelectionPageState();

  TabController tabController;
  int book = 1;
  int chapter = 1;
  int verse = 1;

  Future<int> getVersesCount(int book, int chapter) async => json.decode(await rootBundle.loadString(intToBookPath[book]))['chapters'][chapter - 1]['verses'].length;

  void setLocalReferece(int b, int c, int v){
    setState(() {
      book = b;
      chapter = c;
      verse = v;
    });
  }

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    book = widget.getReference()[0];
    chapter = widget.getReference()[1];
    verse = widget.getReference()[2];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Referencias'),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(text: 'Libro'),
            Tab(text: 'Capítulo'),
            Tab(text: 'Verso'),
          ]
        ),
      ),

      body: TabBarView(
        controller: tabController,
        
        children: [
          SelecionarLibro(
            setReference: widget.setReference,
            getReference: widget.getReference,
            setLocalReference: setLocalReferece,
            tabController: tabController
          ),
          
          // Seleccionar Capitulo
          GridView.builder(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 150.0),
            itemCount: namesAndChapters[book - 1][1],
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
                      setState(() {
                        widget.setReference(book, item + 1, 1);
                        setLocalReferece(book, item + 1, 1);
                        tabController.animateTo(2);
                      });
                    },
                  )
              );
            }
          ),
          
          // Seleccionar Versiculo
          FutureBuilder(
            future: getVersesCount(book, chapter),
            builder: (BuildContext buildContext, AsyncSnapshot<int> asyncSnapshot)
            {
              return GridView.builder(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 150.0),
                itemCount: asyncSnapshot.data,
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
                          widget.setReference(book, chapter, item + 1);
                          setLocalReferece(book, chapter, item + 1);
                          Navigator.pop(context);
                        },
                      )
                  );
                }
              );
            }
          ),
        ]
      ),
    );
  }
}




class SelecionarLibro extends StatefulWidget
{
  SelecionarLibro({
    this.tabController,
    @required this.setReference,
    @required this.getReference,
    @required this.setLocalReference
  });
  
  final TabController tabController;
  final void Function(int book, int chapter, int verse) setReference;
  final void Function(int book, int chapter, int verse) setLocalReference;
  final List<int> Function() getReference;

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
    scrollController = ScrollController(initialScrollOffset: 56.0 * (widget.getReference()[0] - 1));
    super.initState();
  }

  void filterSearchResults(String query) {
    List<List> dummySearchList = List<List>();
    dummySearchList.addAll(duplicateItems);

    if(query.isNotEmpty) {
      List<List> dummyListData = List<List>();
      dummySearchList.forEach((item) {
        if(removeDiacritics(item[1]).toLowerCase().contains(removeDiacritics(query).toLowerCase())) {
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
                    leading: intToBook[widget.getReference()[0]] == items[index][1]
                        ? Icon(Icons.bookmark, color: Theme.of(context).iconTheme.color)
                        : Icon(Icons.bookmark_border, color: Theme.of(context).iconTheme.color),

                    title: intToBook[widget.getReference()[0]] == items[index][1]
                        ? Text(items[index][1], style: TextStyle(
                      fontSize: Theme.of(context).textTheme.button.fontSize,
                      color: Theme.of(context).textTheme.button.color,
                      fontWeight: FontWeight.bold,
                      fontFamily: Theme.of(context).textTheme.button.fontFamily,))
                        : Text(items[index][1], style: Theme.of(context).textTheme.button,),

                    onTap: () async
                    {
                      setState(() {
                        widget.tabController.animateTo(1);
                        widget.setReference(bookToInt[items[index][1]], 1, 1);
                        widget.setLocalReference(bookToInt[items[index][1]], 1, 1);
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