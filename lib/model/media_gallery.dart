part of cb_art;

class MediaGallery implements GalleryItem{
  String _description;  

  @override
  String get description => _description;
  
}

class GalleryItem {
  
  String get description => ""; 
}