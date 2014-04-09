library art_dao;

import 'package:cb_art/exhibition.dart';
import 'package:sqljocky/sqljocky.dart';
import 'dart:async';

class ExhibitionDAOSqlJockey implements ExhibitionDAO {
  ConnectionPool conn;
  Map<String, Query> prepared = new Map();
  Map<String, String> sqlStatements = {
    'insert': "INSERT INTO exhibition (begin, end, name, description, url) values (?,?,?,?,?)",
    'update': "UPDATE exhibition SET begin=?, end=?, name=?, description=?, url=?) WHERE id=?"
  };
  
  ExhibitionDAOSqlJockey(this.conn);

  @override
  Future add(Exhibition exhibition) {
    Completer c = new Completer();
    getPrepared("insert").then((Query query) {
      query.execute([exhibition.begin, exhibition.end, exhibition.name, exhibition.description, exhibition.url])
        .then((result) { 
          exhibition.id = result.insertId;
          c.complete(exhibition);
        });
    }); 
    return c.future;
  }
  
  Future getPrepared(String key) {
    return new Future(() {
      if(prepared.containsKey(key)) return prepared[key];
      return conn.prepare(sqlStatements[key]);     
    });
  }
}

