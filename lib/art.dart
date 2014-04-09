library art;

//import 'package:cb_art/media_gallery.dart';
import 'package:cb_art/exhibition.dart';
import 'package:cb_art/vita.dart';

class Address {
  String street;
  String city;
  String postcode;
  String country;
}

class Location {
  String name;
  Address address;
}

class Artist{
    String firstName;
    String lastName;
}

class ArtWork {
  String name;
  int year;
  String material;
  int heightMM;
  int widthMM;
  int depthMM;
  List<String> images;
}

class Event {
  DateTime begin;
  DateTime end;
  String name;
}

class ExhibitionOpening extends Event {
  Exhibition exhibition;
}





