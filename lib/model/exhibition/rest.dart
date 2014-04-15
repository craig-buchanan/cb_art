part of cb_art.rest;

class ExhibitionDAORest implements ExhibitionDAO {
  String _url;
  
  ExhibitionDAORest(this._url);
  
  @override
  Future<List<Exhibition>> all() {
    return HttpRequest.getString(_url).then((String jsonStr) {
      List<Map> jsonMaps = JSON.decode(jsonStr);
      List<Future<Exhibition>> decoded = new List<Future<Exhibition>>();
      for(var m in jsonMaps)
        decoded.add(fromJson(m));
      return Future.wait(decoded);
    }); 
    
  }

  @override
  Future<Exhibition> get(int id) {
    // TODO: implement get
  }

  @override
  Future<Exhibition> save(Exhibition exhibition) {
    Completer c = new Completer();
    HttpRequest req = new HttpRequest();
    
    req.onReadyStateChange.listen((_) {
      if(req.readyState != HttpRequest.DONE) return;
      if(req.status != 200 && req.status != 0) return;
      print("We have a response: " + req.status.toString());
      fromJson(JSON.decode(req.responseText)).then((Exhibition e) => c.complete(e));
    });
    toJson(exhibition).then((Map m) {
      req.open("POST", _url, async: false);
      String toSend = JSON.encode(m);
      
      print("We are sending the json string: ${toSend}");
      req.send(JSON.encode(m));
    });
    return c.future;
  }

  @override
  Future<Map> toJson(Exhibition e) {
    return new Future.value(exhibitionToJson(e));
  }
  
  @override
  Future<Exhibition> fromJson(Map m) {
    return new Future.value(exhibitionFromJson(m));
  }
}