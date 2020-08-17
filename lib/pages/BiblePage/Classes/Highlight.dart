import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Highlight {

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  
  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/highlight.json');
  }

  static Future<String> readHighlight() async {
    try {
      final file = await _localFile;
      String contents;

      if(await file.exists()){
        contents = await file.readAsString();

        if(contents == ''){
          contents = '{}';
          file.writeAsString('{}');
        }
      }

      else{
        file.create();
        file.writeAsString('{}');
        contents = await file.readAsString();
      }
      
      return contents;
    }
    
    catch (e) {
      // Si encuentra un error, regresamos 0
      return 'ERROR en el archivo "highlight.json" puede que este defectuoso, no exista o contenga informacion que no puede ser leida';
    }
  }

  static Future<File> writeHighlight(String data) async {
    final file = await _localFile;

    // Escribir archivo
    return file.writeAsString(data);
  }

}