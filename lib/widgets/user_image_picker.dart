import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onPickedImage});

  final void Function(File pickedImage) onPickedImage;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile; // This stores the picked or default image file.

  @override
  void initState() {
    super.initState();
    // Load the default image when the widget initializes.
    _loadDefaultImage();
  }

  void _loadDefaultImage() {
    // Replace 'assets/images/default_image.png' with your actual default image path.
    setState(() {
      _pickedImageFile =
          File('/Users/azizhilal/imagine-swe/assets/images/default-user1.png');
    });
  }

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.onPickedImage(
        _pickedImageFile!); // Callback to notify the parent widget.
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey,
          foregroundImage: _pickedImageFile != null
              ? FileImage(_pickedImageFile!)
              : null, // Display picked or default image.
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image_rounded),
          label: Text(
            "Add Icon",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        )
      ],
    );
  }
}
