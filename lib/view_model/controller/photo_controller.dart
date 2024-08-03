import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:joistic_task/core/model/photo_model.dart';

class PhotoViewModel extends GetxController {
  final _photos = <Photo>[].obs;
  var isLoading = true.obs;
  var isSearchVisible = false.obs; 
  var searchPhotos = <Photo>[].obs;
  final TextEditingController searchController = TextEditingController();
  // var isSelected = false.obs;

  @override
  void onInit() {
    fetchPhotos();
    super.onInit();
    searchController.addListener(_onSearchChanged);
  }

  void fetchPhotos() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
      if (response.statusCode == 200) {
        var result = json.decode(response.body) as List;
        _photos.value = result.map((photo) => Photo.fromJson(photo)).toList();
        searchPhotos.value = _photos; 
      }
    } finally {
      isLoading(false);
    }
  }

  void _onSearchChanged() {
    searchPhotosByQuery(searchController.text);
  }

  void searchPhotosByQuery(String query) {
    if (query.isEmpty) {
      searchPhotos.value = _photos; 
    } else {
      searchPhotos.value = _photos.where((photo) {
        return photo.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

 void toggleSelection(int index) {
    var photo = searchPhotos[index];
    photo.isSelected.value = !photo.isSelected.value; 
    searchPhotos[index] = photo; 
  }
}
