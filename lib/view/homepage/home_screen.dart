
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joistic_task/core/constants/string_constant.dart';
import 'package:joistic_task/core/model/photo_model.dart';
import 'package:joistic_task/view/card_clipper.dart';
import 'package:joistic_task/view_model/controller/photo_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final PhotoViewModel photoViewModel = Get.put(PhotoViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (photoViewModel.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                _buildTitle(),
                _buildPhotoList(),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildHeader() {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  photoViewModel.isSearchVisible.value = !photoViewModel.isSearchVisible.value;
                  if (!photoViewModel.isSearchVisible.value) {
                    photoViewModel.searchController.clear();
                  }
                },
              ),
            ],
          ),
          if (photoViewModel.isSearchVisible.value)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0,left: 8,right: 8,),
              child: TextField(
                controller: photoViewModel.searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(.0),
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Text(
        AppString().title,
        style: const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildPhotoList() {
    return Expanded(
      child: ListView.builder(
        itemCount: photoViewModel.searchPhotos.length,
        itemBuilder: (context, index) {
          var photo = photoViewModel.searchPhotos[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: ClipOval(
                  child: Image.network(
                    photo.thumbnailUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  photo.shortTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    photo.title,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                trailing: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:!photo.isSelected ? const Color.fromARGB(255, 122, 33, 238) : Colors.green,
                      width: 7,
                    ),
                  ),
                ),
                onTap: () {
                _showPhotoDialog(context, photo); }
              ),
            ),
            
          );
          
        },
      ),
    );
  }
}
void _showPhotoDialog(BuildContext context, Photo photo) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return ClipPath(
        clipper: TopArcClipper(),
        child: Container(height: 900,
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(photo.thumbnailUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                photo.shortTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                photo.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      
                      onPressed: () {
                        // Add your onPressed logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple, // Set the background color to purple
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // Optional: rounded corners
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                      ),
                      child: const Text(
                        'APPLY NOW',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ],
              ),
             
            ],
          ),
        ),
      );
    },
  );
}

