import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:joistic_task/core/model/photo_model.dart';

class PhotoService {
  Future<List<Photo>> fetchPhotos() async {
    var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    if (response.statusCode == 200) {
      var result = json.decode(response.body) as List;
      return result.map((photo) => Photo.fromJson(photo)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
