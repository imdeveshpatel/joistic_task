import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joistic_task/core/model/photo_model.dart';
import 'package:joistic_task/core/services/api_service.dart';

class PhotoViewModel extends GetxController {
  final PhotoService _photoService = Get.put(PhotoService());
  final _photos = <Photo>[].obs;
  var isLoading = true.obs;
  var isSearchVisible = false.obs;
  var searchPhotos = <Photo>[].obs;
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    fetchPhotos();
    super.onInit();
    searchController.addListener(_onSearchChanged);
  }

  void fetchPhotos() async {
    try {
      isLoading(true);
      var photos = await _photoService.fetchPhotos();
      _photos.value = photos;
      searchPhotos.value = _photos;
    } catch (e) {
      Get.snackbar("Error", e.toString());
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
