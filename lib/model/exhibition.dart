part of cb_art;

class Exhibition implements Identifiable{
  int id;
  DateTime begin;
  DateTime end;
  String name;
  String description;
  String url;
  
  DateFormat _df = new DateFormat("yyyy-MM-dd"); 
  
  String get beginStr => begin == null ? null : _df.format(begin);
  set beginStr(String inputString) {
    try {
      DateTime dt = _df.parse(inputString);
      begin = dt;
    } catch (e) {
      
    }
  }
  
  
}

abstract class ExhibitionDAO {
  Future<Exhibition> save(Exhibition exhibition);
  Future<Exhibition> get(int id);
  Future<List<Exhibition>> all();
  Future<Exhibition> fromJson(Map m);
  Future<Map> toJson(Exhibition);
  
  
}
var formatter = new DateFormat('yyyy-MM-dd');
Map exhibitionToJson(Exhibition e) {
 return {
    'id': e.id,
    'begin': e.begin == null ? null : formatter.format(e.begin),
    'end': e.end == null ? null : formatter.format(e.end),
    'name': e.name,
    'description':e.description,
    'url': e.url
  };
}
Exhibition exhibitionFromJson(Map j) => 
    new Exhibition()
    ..id = j['id']
    ..begin = j['begin'] == null ? null : formatter.parse(j['begin'])
    ..end = j['end']  == null ? null : formatter.parse(j['end'])
    ..name = j['name']
    ..description = j['description']
    ..url = j['url'];



