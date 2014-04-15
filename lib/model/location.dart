part of cb_art;

class Location {
  String name;
  Address address;
}

class Address {
  String street;
  String city;
  String postcode;
  String country;
}

abstract class LocationDAO {
  Future<Location> get(int id);
}

