import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileImage extends StatefulWidget {
  final double radius;
  const ProfileImage({Key? key, this.radius = 50.0}) : super(key: key);

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  File? _imageFile;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _loadFirebaseImage();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _loadFirebaseImage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.photoURL != null) {
      setState(() {
        _imageUrl = user.photoURL;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;

    if (_imageFile != null) {
      imageProvider = FileImage(_imageFile!);
    } else if (_imageUrl != null) {
      imageProvider = NetworkImage(_imageUrl!);
    } else {
      imageProvider = const AssetImage('assets/default_profile.png');
    }

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: widget.radius,
          backgroundImage: imageProvider,
        ),
        GestureDetector(
          onTap: _pickImage,
          child: CircleAvatar(
            radius: 15,
            backgroundColor: Colors.orange,
            child: const Icon(Icons.edit, size: 16, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
