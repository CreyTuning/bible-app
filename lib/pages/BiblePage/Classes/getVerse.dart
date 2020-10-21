import 'dart:convert';

import 'package:flutter/services.dart';

Future getVerse(int book, int chapter, int verse) async {

  if(book == 0 || chapter == 0 || verse == 0)
    return 'Cargando...';
  
  else{
    Map data = json.decode(await rootBundle.loadString('lib/bibles/RVR60/${book}_$chapter.json'));
    return data['verses'][verse - 1]['text'].toString();
  }
}