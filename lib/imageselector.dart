import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Imageselector extends StatefulWidget {
  const Imageselector({super.key});

  @override
  State<Imageselector> createState() => _ImageselectorState();
}

class _ImageselectorState extends State<Imageselector> {
  final ImagePicker picker = ImagePicker();
  var pickedimage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          pickedimage == null ? Text("pick an image") : Image.file(pickedimage),
          ElevatedButton(
            onPressed: () async {
              final XFile? photo = await picker.pickImage(
                source: ImageSource.camera,
              );
              setState(() {
                pickedimage = File(photo!.path);
              });
            },
            child: Text("camera"),
          ),
        ],
      ),
    );
  }
}
