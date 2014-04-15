part of cb_art.postgres;

class ExhibitionDAOPostgres extends DAOCrudPostrges<Exhibition> implements ExhibitionDAO {
  @override String get _allSql => "SELECT * FROM exhibition";
  @override String get _getSql => "SELECT * FROM exhibition WHERE id=@id";
  @override String get _insertSql => "INSERT INTO exhibition (begin_date, end_date, name, description, url) VALUES (@begin, @end, @name, @description, @url) RETURNING *;";
  @override String get _updateSql => "UPDATE exhibition SET begin_date=@begin, end_date=@end, name=@name, description=@description, url=@url WHERE id=@id RETURNING *;";
  
  DateFormat _dbFormat = new DateFormat("yyyy-MM-dd");
  
  ExhibitionDAOPostgres(String connectionUri) {
    this._connectionUri = connectionUri;
  }

  @override
  Future<Map> toJson(Exhibition e) {
    return new Future.value(exhibitionToJson(e));
  }
  
  @override
  Future<Exhibition> fromJson(Map m) {
    return new Future.value(exhibitionFromJson(m));
  }
  
  @override
  Map objectToRowMap(Exhibition obj) {
    return {
      'id': obj.id, 
      'begin': _dbFormat.format(obj.begin),
      'end': _dbFormat.format(obj.end),
      'name': obj.name,
      'description': obj.description,
      'url': obj.url
    };
  }

  @override
  Exhibition rowToObject(Row r) {
    return new Exhibition()
      ..id = r.id
      ..begin = r.begin_date
      ..end = r.end_date
      ..name = r.name
      ..description = r.description
      ..url = r.url;
  }

  
}
