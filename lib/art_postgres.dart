library cb_art.postgres;

import 'package:intl/intl.dart';
import 'package:postgresql/postgresql.dart';
import 'model/identifiable.dart';
import 'dart:async';

import 'art.dart';
export 'art.dart';

part 'model/exhibition/postgres.dart';

ArtDAOFactory getArtDAOFactory(Map config) {
  return new ArtDAOFactoryPostgres(config['postgres_uri']);
}

class ArtDAOFactoryPostgres implements ArtDAOFactory {
  
  String _uri;
  
  ExhibitionDAOPostgres _exhibitionDAO;
  ArtDAOFactoryPostgres(this._uri);
  
  @override
  ExhibitionDAO get exhibitionDAO {
    if(_exhibitionDAO == null) _exhibitionDAO = new ExhibitionDAOPostgres(_uri);
    return _exhibitionDAO;
  }
  
  // TODO: implement locationDAO
  @override
  LocationDAO get locationDAO => null;
}

abstract class DAOCrudPostrges<T extends Identifiable> {
  String _connectionUri;
  Map<int, T> _cache = new Map<int, T>();
  
  String get _getSql;
  String get _insertSql;
  String get _updateSql;
  String get _allSql;
  
  T rowToObject(Row r);
  Map objectToRowMap(T obj);
  
  Future<T> get(int id) {
    if(_cache.containsKey(id)) return new Future.value(_cache[id]);
    return _singleRow(_getSql, {'id': id});
  }
  
  Future<T> _singleRow(String sql, Map params) {
    Completer c = new Completer();
    
    connect(_connectionUri).then((Connection conn) =>
      conn.query(sql, params).single.then((Row r) {
        T obj = rowToObject(r);
        c.complete(rowToObject(r));
        conn.close();
        _cache[obj.id] = obj;
      })
    );
    return c.future;
  }
  
  Future<T> save(T obj) {
    return _singleRow(_insertSql, objectToRowMap(obj));
  }
  
  Future<List<T>> all() {
    return _multiRow(_allSql, {});
  }
  
  
  Future<List<T>> _multiRow(String sql, Map params) {
    Completer c = new Completer();
    connect(_connectionUri).then((Connection conn) => 
        
      conn.query(sql, params).toList().then((List<Row> result) {
        
        List<T> returnList = new List<T>();
        for(var r in result) {
          T obj = rowToObject(r);
          returnList.add(obj);
          _cache[r.id] = obj;
        }
        conn.close();
        c.complete(returnList);
      })
      
    );
    return c.future;
  }
}
