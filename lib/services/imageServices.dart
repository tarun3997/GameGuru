import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gameguru/services/server/images_api.dart';

class ImageDisplay extends StatelessWidget {
  final String imageId;
  final ImageService imageService = ImageService();
  ImageDisplay({super.key, required this.imageId});

  @override
  Widget build(BuildContext context) {
    if (imageId.isEmpty) {
      return Icon(Icons.error); // Handle empty URL
    }

    return FutureBuilder<List<int>>(
      future: imageService.fetchImage(imageId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          final imageBytes = snapshot.data;
          return Image.memory(Uint8List.fromList(imageBytes!));
        } else if (snapshot.hasError) {
          return Icon(Icons.error); // Handle errors while fetching the image
        } else {
          return CircularProgressIndicator(); // Display a loading indicator while fetching the image.
        }
      },
    );
  }
}
