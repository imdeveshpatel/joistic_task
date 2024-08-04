import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joistic_task/core/constants/string_constant.dart';
import 'package:joistic_task/core/model/photo_model.dart';
import 'package:joistic_task/view/homepage/card_clipper.dart';
import 'package:joistic_task/core/services/auth_service.dart';
import 'package:joistic_task/controller/photo_controller.dart';
import 'package:joistic_task/view/login/login_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final PhotoViewModel photoViewModel = Get.put(PhotoViewModel());
  final AuthService authService = Get.find<AuthService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (photoViewModel.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                _buildTitle(),
                _buildPhotoList(),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    photoViewModel.isSearchVisible.value =
                        !photoViewModel.isSearchVisible.value;
                    if (!photoViewModel.isSearchVisible.value) {
                      photoViewModel.searchController.clear();
                    }
                  },
                ),
                // IconButton(
                //   icon: const Icon(Icons.logout),
                //   onPressed: () {
                //     authService.signOut();
                //       Get.offAll(() => const LoginScreen());
                //   },
                // ),
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    authService.signOut();

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Row(
                            children: [
                              Icon(Icons.exit_to_app,
                                  color: Colors.red, size: 30),
                              SizedBox(width: 10),
                              Text('Logout'),
                            ],
                          ),
                          content:
                              const Text('Are you sure you want to logout?'),
                          backgroundColor: Colors.grey[100],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.offAll(() => const LoginScreen());
                              },
                              child: const Text('Yes',
                                  style: TextStyle(color: Colors.red)),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('No',
                                  style: TextStyle(color: Colors.blue)),
                            ),
                          ],
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ],
        ),
        if (photoViewModel.isSearchVisible.value)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
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
                trailing: Obx(() => Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: photo.isSelected.value
                              ? Colors.green
                              : const Color.fromARGB(255, 122, 33, 238),
                          width: 7,
                        ),
                      ),
                    )),
                onTap: () {
                  _showPhotoDialog(context, photo);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _showPhotoDialog(BuildContext context, Photo photo) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return ClipPath(
          clipper: TopArcClipper(),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 160),
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(photo.thumbnailUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: photo.isSelected.value
                          ? () {
                              Get.snackbar(
                                'Already Applied',
                                'You have already applied for this Job.',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.orange,
                                colorText: Colors.white,
                              );
                              Navigator.pop(context);
                            }
                          : () {
                              photo.isSelected.value = true;
                              Navigator.pop(context);
                              Get.snackbar(
                                'Success',
                                'Applied successfully',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: photo.isSelected.value
                            ? Colors.grey
                            : const Color.fromARGB(255, 122, 33, 238),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                      ),
                      child: Text(
                        photo.isSelected.value
                            ? 'ALREADY APPLIED'
                            : 'APPLY NOW',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
