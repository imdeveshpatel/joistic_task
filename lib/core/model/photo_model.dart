
class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;
   bool isSelected;
 

  Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
    this.isSelected =false,
  });
  


  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'],
      id: json['id'],
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }

  String get shortTitle {
    List<String> words = title.split(' ');
    if (words.length > 2) {
      return '${words[0]} ${words[1]}';
    }
    return title;
  }
}
