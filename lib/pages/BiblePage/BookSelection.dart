import 'package:diacritic/diacritic.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:yhwh/data/Define.dart';
import 'package:yhwh/data/valuesOfBooks.dart';


class BookSelectionPage extends StatefulWidget {
  BookSelectionPage({
    @required this.setReference,
    @required this.getReference,
    @required this.initialTab
  });

  final int initialTab;
  final void Function(int book, int chapter, int verse) setReference;
  final List<int> Function() getReference;

  @override
  _BookSelectionPageState createState() =>  _BookSelectionPageState();
}


class _BookSelectionPageState extends State<BookSelectionPage> with SingleTickerProviderStateMixin {
  _BookSelectionPageState();

  TabController tabController;
  ValueNotifier<int> book = ValueNotifier<int>(1);
  ValueNotifier<int> chapter = ValueNotifier<int>(1);
  ValueNotifier<int> verse = ValueNotifier<int>(1);

  ScrollController myScroll = ScrollController();

  void setLocalReferece(int b, int c, int v){
    setState(() {
      book.value = b;
      chapter.value = c;
      verse.value = v;
    });
  }

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this, initialIndex: widget.initialTab);
    book.value = widget.getReference()[0];
    chapter.value = widget.getReference()[1];
    verse.value = widget.getReference()[2];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
        child: Icon(Icons.check, color: Theme.of(context).textTheme.bodyText1.color),
        onPressed: () async{
          widget.setReference(book.value, chapter.value, verse.value);
          setLocalReferece(book.value, chapter.value, verse.value);
          Navigator.pop(context);
        },
      ),

      appBar: AppBar(
        title: Text("Referencias", style: Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 21,
          fontWeight: FontWeight.bold
        )),
        
        bottom: TabBar(
          labelStyle: Theme.of(context).textTheme.bodyText1.copyWith(
            fontFamily: 'Roboto-Medium',
            fontSize: 17
          ),

          unselectedLabelStyle: Theme.of(context).textTheme.bodyText1.copyWith(
            fontFamily: 'Roboto-Medium',
            fontSize: 17
          ),

          indicatorColor: Theme.of(context).accentColor,
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
          ValueListenableBuilder(
            valueListenable: book,
            builder: (context, value, child) {
              return Scrollbar(
                child: GridView.builder(
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 55),
                  itemCount: valuesOfBooks[value - 1].length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1.15
                  ),

                  itemBuilder: (context, item) {
                    return GridTile(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        
                        onTap: () async{
                          setState(() {
                            widget.setReference(value, item + 1, 1);
                            setLocalReferece(value, item + 1, 1);
                            tabController.animateTo(2);
                          });
                        },
                        
                        child: Center(
                          child: Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.center,
                            
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: (item == chapter.value - 1) ? Theme.of(context).textTheme.bodyText1.color : Colors.transparent,
                            ),
                            
                            child: Text(
                              '${item + 1}',
                              style: Theme.of(context).textTheme.button.copyWith(
                                fontSize: 19,
                                color: (item == chapter.value - 1) ? Theme.of(context).canvasColor : Theme.of(context).textTheme.bodyText1.color,
                                fontFamily: 'Roboto-Medium'
                                // fontWeight: FontWeight.bold
                              )
                            ),
                          ),
                        )
                      )
                    );
                  }
                ),
              );
            } 
          ),
          
          // Seleccionar Versiculo
          ValueListenableBuilder(
            valueListenable: book,
            builder: (context, value, child) => Scrollbar(
              child: GridView.builder(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 55),
                itemCount: valuesOfBooks[value - 1][chapter.value - 1],
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.15
                ),

                itemBuilder: (context, item) {
                  return GridTile(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        
                        onTap: () async{
                          widget.setReference(book.value, chapter.value, item + 1);
                          setLocalReferece(book.value, chapter.value, item + 1);
                          Navigator.pop(context);
                        },
                        
                        child: Center(
                          child: Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.center,
                            
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: (item == verse.value - 1) ? Theme.of(context).textTheme.bodyText1.color : Colors.transparent,
                            ),
                            
                            child: Text(
                              '${item + 1}',
                              style: Theme.of(context).textTheme.button.copyWith(
                                fontSize: 19,
                                color: (item == verse.value - 1) ? Theme.of(context).canvasColor : Theme.of(context).textTheme.bodyText1.color,
                                fontFamily: 'Roboto-Medium'
                              )
                            ),
                          ),
                        )
                      )
                  );
                }
              ),
            ),
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
            padding: EdgeInsets.fromLTRB(10, 5, 10, 1),
            child: TextField(
              enableSuggestions: true,
              keyboardAppearance: Theme.of(context).brightness,
              focusNode: FocusNode(),
              textInputAction: TextInputAction.none,
              
              onChanged: (value) {
                scrollController.jumpTo(0);
                filterSearchResults(value);
              },

              cursorColor: Theme.of(context).textTheme.bodyText1.color,
              controller: editingController,
              decoration: InputDecoration(
                
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).accentColor,
                  )
                ),

                hintStyle: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontSize: 16,
                  height: 1.33
                ),

                alignLabelWithHint: true,

                hintText: "Buscar...",
                prefixIcon: Icon(Icons.search, color: Theme.of(context).textTheme.bodyText2.color, size: 24,),
              )
            ),
          ),

          Expanded(
            child: Scrollbar(
              child: ListView.builder(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 55),
                controller: scrollController,
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {

                  return ListTile(
                    title: intToBook[widget.getReference()[0]] == items[index][1]
                        ? Text(items[index][1],
                          style: TextStyle(
                            fontSize: 19,
                            color: Theme.of(context).textTheme.bodyText1.color,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto-Medium'
                          )
                        )
                        : Text(items[index][1], style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontFamily: 'Roboto',
                          fontSize: 19,
                          color: Theme.of(context).textTheme.bodyText1.color
                        )),

                    // leading: intToBook[widget.getReference()[0]] == items[index][1] ? Icon(Icons.bookmark, color: Theme.of(context).textTheme.bodyText1.color,) : SizedBox(),
                      

                    onTap: () async
                    {
                      widget.setReference(bookToInt[items[index][1]], 1, 1);
                      widget.setLocalReference(bookToInt[items[index][1]], 1, 1);
                      widget.tabController.animateTo(1);
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
