import 'package:hive/hive.dart';
import 'package:yhwh/models/highlighterItem.dart';
import 'package:yhwh/models/highlighterOrderItem.dart';

class HighlighterManager {
  static LazyBox highlighterBox;
  static LazyBox highlighterOrderBox;

  static Future<void> initBoxes() async {
    highlighterBox = await Hive.openLazyBox('highlighterBox');
    highlighterOrderBox = await Hive.openLazyBox('highlighterOrderBox');
    return;
  }

  static Future<void> checkBoxesState() async {
    if(highlighterBox == null || highlighterOrderBox == null)
      await initBoxes();
    
    return;
  }

  static Future<List<int>> getHighlightVersesInChapter(int book, int chapter) async {
    await checkBoxesState();

    List<int> highlightVerses = [];

    // obtener versos resaltados
    Map tempHil = await highlighterBox.get('$book:$chapter', defaultValue: {}) ?? {};
    tempHil.forEach((key, value) => highlightVerses.addAll(value.verses));

    return highlightVerses;
  }

  static Future<Map<int, HighlighterItem>> getHighlightVersesInChapterWithData(int book, int chapter) async {
    await checkBoxesState();

    Map<int, HighlighterItem> highlightVerses = {};

    // obtener versos resaltados
    Map tempHil = await highlighterBox.get('$book:$chapter', defaultValue: {}) ?? {};
    
    // Agregar al mapa
    tempHil.forEach((key, value) {
      value.verses.forEach((verse){
        highlightVerses[verse] = value;
      });
      // highlightVerses.addAll()
    });

    return highlightVerses;
  }

  static Future<void> add(HighlighterItem highlighterItem) async {
    await checkBoxesState();

    if(highlighterBox.containsKey('${highlighterItem.book}:${highlighterItem.chapter}')) {
      Map contentChapterList = await highlighterBox.get('${highlighterItem.book}:${highlighterItem.chapter}');
      
      // Verificar si existen versiculos que sobreescribir y hacerlo
      bool existToRemove = false;

      for(int verse in await getHighlightVersesInChapter(highlighterItem.book, highlighterItem.chapter)){
        if(highlighterItem.verses.contains(verse)){
          existToRemove = true;
          break;
        }
      }

      if(existToRemove){
        contentChapterList = await removeVersesInChapter(highlighterItem.book, highlighterItem.chapter, highlighterItem.verses);
      }
      
      // Agregar nuevos versiculos
      contentChapterList[highlighterItem.id] = highlighterItem;
      await highlighterBox.put('${highlighterItem.book}:${highlighterItem.chapter}', contentChapterList);
    }
    
    else {
      await highlighterBox.put('${highlighterItem.book}:${highlighterItem.chapter}', {highlighterItem.id : highlighterItem});
    }

    // Agregar al highlighterOrderBox [Esto no puede ir antes de removeVersesInChapter()]
    await highlighterOrderBox.add(HighlighterOrderItem(
      book: highlighterItem.book,
      chapter: highlighterItem.chapter,
      id: highlighterItem.id
    ));
  }

  static Future<Map> removeVersesInChapter(int book, int chapter, List<int> versesToRemove) async {
    Map contentChapterList = await highlighterBox.get('$book:$chapter');
    Map newMap = {};
    
    // Borrar versos
    contentChapterList.forEach((key, value) async
    {
      value.verses.forEach((int verse)
      {
        if(!versesToRemove.contains(verse)){

          if(!newMap.containsKey(key)){
            newMap[key] = HighlighterItem(
              book: value.book,
              chapter: value.chapter,
              color: value.color,
              id: value.id,
              dateTime: value.dateTime,
              verses: []
            );
          }

          newMap[key].verses.add(verse);
        }
      });
    });

    // Guardar el nuevo mapa
    await  highlighterBox.put('$book:$chapter', newMap);

    // lIMPIAR KEYS NULAS EN CASO DE EXISTIR
    for(var key in highlighterOrderBox.keys){
        
      HighlighterOrderItem highlighterOrderItem = await highlighterOrderBox.get(key);

      if(!highlighterBox.containsKey('${highlighterOrderItem.book}:${highlighterOrderItem.chapter}')){
        await highlighterOrderBox.delete(key);
      }
      
      else {  
        Map tempContent = await highlighterBox.get('${highlighterOrderItem.book}:${highlighterOrderItem.chapter}');

        if(!tempContent.containsKey(highlighterOrderItem.id)){
          await highlighterOrderBox.delete(key);
        }
      }
    }

    return newMap;
  }
}