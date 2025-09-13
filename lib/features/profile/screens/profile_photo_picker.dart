import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePhotoPicker extends StatefulWidget {
  final void Function(String path) onImageSelected;
  const ProfilePhotoPicker({required this.onImageSelected, Key? key}) : super(key: key);

  @override
  State<ProfilePhotoPicker> createState() => _ProfilePhotoPickerState();
}

class _ProfilePhotoPickerState extends State<ProfilePhotoPicker> {
  String? _imagePath;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imagePath = picked.path;
      });
      widget.onImageSelected(picked.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 48,
          backgroundImage: _imagePath != null ? FileImage(File(_imagePath!)) : null,
          child: _imagePath == null ? const Icon(Icons.person, size: 48) : null,
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: _pickImage,
          child: const Text('Fotoğraf Yükle'),
        ),
      ],
    );
  }
}
