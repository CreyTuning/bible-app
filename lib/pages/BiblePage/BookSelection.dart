import 'package:diacritic/diacritic.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yhwh/data/Define.dart';
import 'package:yhwh/data/Titles.dart';
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
  int book = 1;
  int chapter = 1;
  int verse = 1;

  bool titleMode = false;
  ScrollController myScroll = ScrollController();

  void setLocalReferece(int b, int c, int v){
    setState(() {
      book = b;
      chapter = c;
      verse = v;
    });
  }

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this, initialIndex: widget.initialTab);
    book = widget.getReference()[0];
    chapter = widget.getReference()[1];
    verse = widget.getReference()[2];

    SharedPreferences.getInstance().then((preferences){
      setState(() {
        titleMode = preferences.getBool('titleMode') ?? false;
      });
    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
        child: Icon(Icons.check),
        onPressed: () async{
          widget.setReference(book, chapter, verse);
          setLocalReferece(book, chapter, verse);
          Navigator.pop(context);
        },
      ),

      appBar: AppBar(
        title: Text("Referencias", style: Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 21,
          fontWeight: FontWeight.bold
        )),
        
        bottom: (titleMode)
        ? TabBar(
          controller: tabController,
          tabs: [
            Tab(text: 'Libros'),
            Tab(text: 'Titulos'),
            Tab(text: 'Todo'),
          ]
        )
        : TabBar(
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
          (titleMode)
          ? SelecionarLibroTitulo(
            setReference: widget.setReference,
            getReference: widget.getReference,
            setLocalReference: setLocalReferece,
            tabController: tabController
          )
          : SelecionarLibro(
            setReference: widget.setReference,
            getReference: widget.getReference,
            setLocalReference: setLocalReferece,
            tabController: tabController
          ),
          
          // Seleccionar Capitulo
          (titleMode)
          ? SeleccionarTituloCapitulo(
            setReference: widget.setReference,
            getReference: widget.getReference,
            setLocalReference: setLocalReferece,
            tabController: tabController
          )
          : Scrollbar(
            child: GridView.builder(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 55),
              itemCount: valuesOfBooks[book - 1].length,
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
                        widget.setReference(book, item + 1, 1);
                        setLocalReferece(book, item + 1, 1);
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
                          color: (item == chapter - 1) ? Theme.of(context).accentColor : Colors.transparent,
                        ),
                        
                        child: Text(
                          '${item + 1}',
                          style: Theme.of(context).textTheme.button.copyWith(
                            fontSize: 19,
                            color: (item == chapter - 1) ? Colors.white : Theme.of(context).textTheme.bodyText1.color,
                            // fontWeight: FontWeight.bold
                          )
                        ),
                      ),
                    )
                  )
                );
              }
            ),
          ),
          
          // Seleccionar Versiculo
          (titleMode)
          ? SeleccionarTituloTodos(
            setReference: widget.setReference,
            getReference: widget.getReference,
            setLocalReference: setLocalReferece,
            tabController: tabController
          )
          : Scrollbar(
            child: GridView.builder(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 55),
              itemCount: valuesOfBooks[book - 1][chapter - 1],
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.15
              ),

              itemBuilder: (context, item) {
                return GridTile(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      
                      onTap: () async{
                        widget.setReference(book, chapter, item + 1);
                        setLocalReferece(book, chapter, item + 1);
                        Navigator.pop(context);
                      },
                      
                      child: Center(
                        child: Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: (item == verse - 1) ? Theme.of(context).accentColor : Colors.transparent,
                          ),
                          
                          child: Text(
                            '${item + 1}',
                            style: Theme.of(context).textTheme.button.copyWith(
                              fontSize: 19,
                              color: (item == verse - 1) ? Colors.white : Theme.of(context).textTheme.bodyText1.color,
                              // fontWeight: FontWeight.bold
                            )
                          ),
                        ),
                      )
                    )
                );
              }
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

              cursorColor: Theme.of(context).accentColor,
              controller: editingController,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).accentColor,
                  )
                ),

                hintText: "Buscar...",
                prefixIcon: Icon(Icons.search, color: Theme.of(context).iconTheme.color),
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
                    // leading: intToBook[widget.getReference()[0]] == items[index][1]
                    //     ? Icon(Icons.bookmark, color: Theme.of(context).textTheme.bodyText1.color)
                    //     : Icon(Icons.bookmark_border, color: Theme.of(context).textTheme.bodyText2.color),

                    title: intToBook[widget.getReference()[0]] == items[index][1]
                        ? Text(items[index][1], style: TextStyle(
                      fontSize: 19,
                      color: Theme.of(context).textTheme.bodyText1.color,
                      fontWeight: FontWeight.bold,
                      fontFamily: Theme.of(context).textTheme.button.fontFamily,))
                        : Text(items[index][1], style: Theme.of(context).textTheme.bodyText1),
                      

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


class SeleccionarVersiculo extends StatefulWidget {
  SeleccionarVersiculo({
    Key key,
    this.book,
    this.chapter,
    this.setReference,
    this.setLocalReference

  }) : super(key: key);

  final int book;
  final int chapter;

  final Function(int, int, int) setReference;
  final Function(int, int, int) setLocalReference;

  @override
  _SeleccionarVersiculoState createState() => _SeleccionarVersiculoState();
}

class _SeleccionarVersiculoState extends State<SeleccionarVersiculo> {

  int jumpsToDo = 0;
  List<int> localTitles = [];

  @override
  void initState() {

    titles[widget.book][widget.chapter].forEach((key, value){
      localTitles.add(key);
      // print('$key : $value');
    });

    print(localTitles);
    print(valuesOfBooks[widget.book - 1][widget.chapter - 1]);

    super.initState();
  }


  @override
  Widget build(BuildContext context) {


    localTitles.forEach((int element) {
      
    });


    return Container(
       child: ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 55),
        itemCount: valuesOfBooks[widget.book - 1][widget.chapter - 1],
        itemBuilder: (BuildContext context, int item){


          if(titles[widget.book][widget.chapter].containsKey(item + 1)){
            return InkWell(
              onTap: (){},
              child: Container(
                // color: Theme.of(context).accentColor,
                padding: EdgeInsets.symmetric(horizontal: 50),
                alignment: Alignment.center,
                height: 80,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: '${titles[widget.book][widget.chapter][item + 1]}',
                    style: Theme.of(context).textTheme.button.copyWith(
                      fontSize: 19,
                    ),
                  ),
                ),
              ),
            );
          }

          else
          {
            List<Widget> widgets = [];

            for(int i = 0; i < 1; i++)
            {

              List<Widget> tempList = [];

              for(int j = 0; j < 4; j++)
              {
                tempList.add(
                  GridTile(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(150),
                      onTap: (){},
                      child: Container(
                        alignment: Alignment.center,
                        height: 90,
                        width: 90,
                        child: Text('${item + 1}', style: Theme.of(context).textTheme.button.copyWith(
                          fontSize: 19,
                        // fontWeight: FontWeight.bold
                      )),
                      ),
                    )
                  )
                );
              }

              widgets.add(
                Row(
                  children: tempList,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                )
              );

            }

            return Column(
              children: widgets,
            );
          }
        }
      ),
    );
  }
}




class SeleccionarTituloTodos extends StatefulWidget
{
  SeleccionarTituloTodos({
    this.tabController,
    @required this.setReference,
    @required this.getReference,
    @required this.setLocalReference
  });
  
  final TabController tabController;
  final void Function(int book, int chapter, int verse) setReference;
  final void Function(int book, int chapter, int verse) setLocalReference;
  final List<int> Function() getReference;

  _SeleccionarTituloTodosState createState() => _SeleccionarTituloTodosState();
}

class _SeleccionarTituloTodosState extends State<SeleccionarTituloTodos>
{
  ScrollController scrollController = ScrollController();
  TextEditingController editingController = TextEditingController();

  List<List> duplicateItems = [];

  var items = List<List>();

  @override
  void initState() {

    
    titles.forEach((bookKey, value)
    {
      value.forEach((chapterKey, value)
      {
        value.forEach((verseKey, value)
        {
          duplicateItems.add(
            [value.toString(), bookKey, chapterKey, verseKey, duplicateItems.length + 1]
          );
        });
      });
    });


    items.addAll(duplicateItems);
    scrollController = ScrollController(initialScrollOffset: 0); //56.0 * (widget.getReference()[0] - 1));
    super.initState();
  }

  void filterSearchResults(String query) {
    List<List> dummySearchList = List<List>();
    dummySearchList.addAll(duplicateItems);

    if(query.isNotEmpty) {
      List<List> dummyListData = List<List>();
      dummySearchList.forEach((item) {
        // scrollController.jumpTo(0);

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
    return Scaffold(
      appBar: PreferredSize(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 1),
          child: TextField(
            focusNode: FocusNode(),
            textInputAction: TextInputAction.none,
            
            onChanged: (value) {
              scrollController.jumpTo(0);
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
        preferredSize: Size.fromHeight(50)
      ),

      body: DraggableScrollbar.semicircle(
        controller: scrollController,
        
        child: ListView.builder(

          padding: EdgeInsets.fromLTRB(0, 3, 0, 55),
          controller: scrollController,
          itemCount: items.length,
          cacheExtent: 10,
          itemExtent: 75,
          itemBuilder: (context, index) {

            return InkWell(
              onTap: () async
              {
                setState(() {
                  widget.setReference(items[index][1], items[index][2], items[index][3]);
                  widget.setLocalReference(items[index][1], items[index][2], items[index][3]);
                  Navigator.pop(context);
                });
              },

              child: Container(
                height: 75,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          text: items[index][0], 
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize: 17
                          )
                        ),

                        overflow: TextOverflow.ellipsis,
                        
                      ),

                      Text(
                        '${intToBook[items[index][1]]} ${items[index][2].toString()}:${items[index][3].toString()}',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize: 16,
                          height: 1.5
                        )
                      ),
                      
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


class SelecionarLibroTitulo extends StatefulWidget
{
  SelecionarLibroTitulo({
    this.tabController,
    @required this.setReference,
    @required this.getReference,
    @required this.setLocalReference
  });
  
  final TabController tabController;
  final void Function(int book, int chapter, int verse) setReference;
  final void Function(int book, int chapter, int verse) setLocalReference;
  final List<int> Function() getReference;

  _SelecionarLibroTituloState createState() => _SelecionarLibroTituloState();
}

class _SelecionarLibroTituloState extends State<SelecionarLibroTitulo>
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
    scrollController = ScrollController(initialScrollOffset: 75.0 * (widget.getReference()[0] - 1));
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

    return Scaffold(
      appBar: PreferredSize(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 1),
          child: TextField(
            focusNode: FocusNode(),
            textInputAction: TextInputAction.none,
            
            onChanged: (value) {
              scrollController.jumpTo(0);
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
        preferredSize: Size.fromHeight(50)
      ),

      body: DraggableScrollbar.semicircle(
        controller: scrollController,
        
        child: ListView.builder(

          padding: EdgeInsets.fromLTRB(0, 3, 0, 55),
          controller: scrollController,
          itemCount: items.length,
          cacheExtent: 10,
          itemExtent: 75,
          itemBuilder: (context, index) {

            return InkWell(
              onTap: () async
              {
                setState(() {
                  widget.tabController.animateTo(1);
                  widget.setReference(items[index][0], 1, 1);
                  widget.setLocalReference(items[index][0], 1, 1);
                });
              },

              child: Container(
                height: 75,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      intToBook[widget.getReference()[0]] == items[index][1]
                      ? Text(items[index][1],
                        
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                            height: 1.5,
                            fontSize: 17,
                            color: Theme.of(context).textTheme.bodyText1.color,
                            fontWeight: FontWeight.bold,
                            fontFamily: Theme.of(context).textTheme.button.fontFamily,
                          ),
                        )

                      : Text(items[index][1], style: Theme.of(context).textTheme.bodyText1.copyWith(
                        height: 1.5,
                        fontSize: 17,
                        // color: Theme.of(context).textTheme.bodyText1.color,
                        // fontWeight: FontWeight.bold,
                        fontFamily: Theme.of(context).textTheme.button.fontFamily,
                      )),

                      RichText(
                        text: TextSpan(
                          text: titles.containsKey(items[index][0])
                            ? titles[items[index][0]].containsKey(1)
                              ? titles[items[index][0]][1].containsKey(1)
                                ? titles[items[index][0]][1][1]
                                : 'no contiene titulos'
                              : 'no contiene titulos'
                            : 'no contiene titulos',
                          
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                            fontSize: 16,
                            height: 1.5
                          )
                        ),

                        overflow: TextOverflow.ellipsis,
                        
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


class SeleccionarTituloCapitulo extends StatefulWidget
{
  SeleccionarTituloCapitulo({
    this.tabController,
    @required this.setReference,
    @required this.getReference,
    @required this.setLocalReference
  });
  
  final TabController tabController;
  final void Function(int book, int chapter, int verse) setReference;
  final void Function(int book, int chapter, int verse) setLocalReference;
  final List<int> Function() getReference;

  _SeleccionarTituloCapituloState createState() => _SeleccionarTituloCapituloState();
}

class _SeleccionarTituloCapituloState extends State<SeleccionarTituloCapitulo>
{
  ScrollController scrollController = ScrollController();
  TextEditingController editingController = TextEditingController();

  List<List> duplicateItems = [];

  var items = List<List>();

  @override
  void initState() {

    
    titles[widget.getReference()[0]].forEach((chapterKey, value)
    {
      value.forEach((verseKey, value)
      {
        duplicateItems.add(
          [value.toString(), widget.getReference()[0], chapterKey, verseKey, duplicateItems.length + 1]
        );
      });
    });


    items.addAll(duplicateItems);
    scrollController = ScrollController(initialScrollOffset: 0); //56.0 * (widget.getReference()[0] - 1));
    super.initState();
  }

  void filterSearchResults(String query) {
    List<List> dummySearchList = List<List>();
    dummySearchList.addAll(duplicateItems);

    if(query.isNotEmpty) {
      List<List> dummyListData = List<List>();
      dummySearchList.forEach((item) {
        scrollController.jumpTo(0);

        if(removeDiacritics(item[0]).toLowerCase().contains(removeDiacritics(query).toLowerCase())) {
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

    return Scaffold(
      appBar: PreferredSize(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 1),
          child: TextField(
            focusNode: FocusNode(),
            textInputAction: TextInputAction.none,
            
            onChanged: (value) {
              scrollController.jumpTo(0);
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
        preferredSize: Size.fromHeight(50)
      ),

      body: DraggableScrollbar.semicircle(
        controller: scrollController,
        
        child: ListView.builder(

          padding: EdgeInsets.fromLTRB(0, 3, 0, 55),
          controller: scrollController,
          itemCount: items.length,
          cacheExtent: 10,
          itemExtent: 75,
          itemBuilder: (context, index) {

            return InkWell(
              onTap: () async
              {
                setState(() {
                  widget.setReference(items[index][1], items[index][2], items[index][3]);
                  widget.setLocalReference(items[index][1], items[index][2], items[index][3]);
                  Navigator.pop(context);
                });
              },

              child: Container(
                height: 75,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          text: items[index][0], 
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize: 17
                          )
                        ),

                        overflow: TextOverflow.ellipsis,
                        
                      ),

                      Text(
                        '${intToBook[items[index][1]]} ${items[index][2].toString()}:${items[index][3].toString()}',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize: 16,
                          height: 1.5
                        )
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}