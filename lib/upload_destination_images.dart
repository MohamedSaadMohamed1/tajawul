import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:tajawul/custom_drawer.dart';

class UploadDestinationImages extends StatefulWidget {
  @override
  _UploadDestinationImagesState createState() =>
      _UploadDestinationImagesState();
}

class _UploadDestinationImagesState extends State<UploadDestinationImages> {
  File? _coverImage;
  List<File> _destinationImages = [];

  Future<void> _pickCoverImage() async {
    final picked = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked != null) {
      setState(() => _coverImage = File(picked.path));
    }
  }

  Future<void> _pickDestinationImages() async {
    final picked = await ImagePicker().pickMultiImage(imageQuality: 80);
    if (picked != null && picked.length <= 5) {
      setState(
          () => _destinationImages = picked.map((e) => File(e.path)).toList());
    }
  }

  void _submitImages() {
    if (_coverImage == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Cover image is required')));
      return;
    }

    // Handle image upload logic here
    print("Cover Image: ${_coverImage?.path}");
    print(
        "Destination Images: ${_destinationImages.map((e) => e.path).toList()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: Text("Images for Your Destination"),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Accepted formats: JPG, JPEG, PNG, WEBP",
                style: TextStyle(color: Colors.teal)),
            Text("Maximum file size: 2MB",
                style: TextStyle(color: Colors.teal)),
            const SizedBox(height: 20),
            Text("Cover Image *",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text("Upload a cover image for your destination."),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: _pickCoverImage,
              icon: Icon(Icons.image),
              label: Text("Upload Cover"),
            ),
            if (_coverImage != null) Image.file(_coverImage!, height: 100),
            const SizedBox(height: 30),
            Text("Destination Images",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text("You can upload up to 5 additional images."),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: _pickDestinationImages,
              icon: Icon(Icons.image),
              label: Text("Upload Images"),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: _destinationImages
                  .map((img) =>
                      Image.file(img, height: 60, width: 60, fit: BoxFit.cover))
                  .toList(),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: _submitImages,
                child: Text("Submit Images", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
