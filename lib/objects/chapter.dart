import 'package:yhwh/ui_widgets/ui_verse.dart';

class Chapter {
  int number = 0;
  List<UiVerse> versos = List<UiVerse>();

  Chapter({this.number, this.versos});

  Future<void> fromMap(Map map) async
  {
    versos = List<UiVerse>();
    this.number = map['number'];

    for(int i = 0; i < map['verses'].length; i++){
      versos.add(
        UiVerse(
          number: i + 1,
          text: map['verses'][i]['text']
        )
      );
    }
  }
}
