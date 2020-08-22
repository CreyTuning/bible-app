import 'package:diacritic/diacritic.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yhwh/data/Define.dart';
import 'package:yhwh/data/valuesOfBooks.dart';
import 'package:yhwh/pages/BiblePage/ParallelBookViewer.dart';
import 'package:yhwh/ui_widgets/ScrollableListEdited/scrollable_positioned_list.dart';
import 'package:yhwh/ui_widgets/chapter_footer.dart';


class SecondaryBookSelectionPage extends StatefulWidget {
  SecondaryBookSelectionPage({
    @required this.initialTab
  });

  final int initialTab;

  @override
  _SecondaryBookSelectionPageState createState() => _SecondaryBookSelectionPageState();
}


class _SecondaryBookSelectionPageState extends State<SecondaryBookSelectionPage> with SingleTickerProviderStateMixin {
  _SecondaryBookSelectionPageState();

  TabController tabController;
  int book = 0;
  int chapter = 1;
  int verse = 1;

  ScrollController myScroll = ScrollController();

  void setLocalReference(int b, int c, int v){
    
    SharedPreferences.getInstance().then((preferences){
      setState(() {
        book = b;
        chapter = c;
        verse = v;

        preferences.setInt('parallelBookNumber', b);
        preferences.setInt('parallelChapterNumber', c);
        preferences.setInt('parallelVerseNumber', v);
      });
    });
  }

  List<int> getLocalReference(){
    return [book, chapter, verse];
  }

  @override
  void initState() {
    SharedPreferences.getInstance().then((preferences){
      setState(() {
        book = preferences.getInt('parallelBookNumber') ?? 1;
        chapter = preferences.getInt('parallelChapterNumber') ?? 1;
        verse = preferences.getInt('parallelVerseNumber') ?? 1;
      });
    });

    tabController = TabController(length: 3, vsync: this, initialIndex: widget.initialTab);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lectura paralela", style: Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.bold
        )),
        
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(text: 'Libro'),
            Tab(text: 'Capitulo'),
            Tab(text: 'Verso'),
          ]
        )
      ),

      body: TabBarView(
        controller: tabController,
        
        children: [
          SelecionarLibro(
            setLocalReference: setLocalReference,
            bookNumber: book,
            chapterNumber: chapter,
            verseNumber: verse,
            tabController: tabController
          ),
          
          // Seleccionar Capitulo
          (book == 0) 
          ? Center(
            child: CircularProgressIndicator(),
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
                        setLocalReference(book, item + 1, 1);
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
          (book == 0)
          ? Center(
            child: CircularProgressIndicator(),
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
                        setLocalReference(book, chapter, item + 1);
                        tabController.animateTo(0);
                        
                        showDialog(
                          context: context,
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: ParallelBookViewer(
                              bookNumber: getLocalReference()[0],
                              chapterNumber: getLocalReference()[1],
                              verseNumber: item + 1,
                              itemScrollController: ItemScrollController(),
                              chapterFooter: ChapterFooter(),
                              scrollController: ScrollController(),
                            ),
                          )
                        );

                        // Navigator.pop(context);
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




class SelecionarLibro extends StatefulWidget{
  SelecionarLibro({
    this.tabController,
    @required this.setLocalReference,
    this.bookNumber,
    this.chapterNumber,
    this.verseNumber
  });
  
  final TabController tabController;
  final void Function(int book, int chapter, int verse) setLocalReference;
  final bookNumber;
  final chapterNumber;
  final verseNumber;

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
  void didUpdateWidget(SelecionarLibro oldWidget) {
    scrollController = ScrollController(initialScrollOffset: 56.0 * (widget.bookNumber - 1));
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    items.addAll(duplicateItems);
    scrollController = ScrollController(initialScrollOffset: 56.0 * (widget.bookNumber - 1));
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

    if(widget.bookNumber == 0){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    
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

                    title: intToBook[widget.bookNumber] == items[index][1]
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
