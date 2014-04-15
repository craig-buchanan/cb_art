part of cb_art;

class Artist {
  String firstName;
  String lastName;
}

abstract class ArtistDAO {
  Future<Artist> get(int id);
  
}