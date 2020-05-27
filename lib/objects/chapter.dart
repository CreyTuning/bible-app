class Chapter {
  Chapter({this.number, this.versos});
  
  int number = 0;
  List<List> versos = List<List>();

  Future<void> fromMap(Map map) async
  {
    versos = List<List>();
    this.number = map['number'];

    for(int i = 0; i < map['verses'].length; i++){
      versos.add([i + 1, map['verses'][i]['text']]);
    }
  }
}
