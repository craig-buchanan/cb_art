part of cb_art;

class Vita {
  int get beginYear => null;
  int get endYear => null;
  String get description => null;
  
}

class VitaExhibition extends Exhibition implements Vita{
  
  @override
  int get beginYear => begin != null ? begin.year : null;

  @override
  int get endYear => end != null ? end.year : null;
}