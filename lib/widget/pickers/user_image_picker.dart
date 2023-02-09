import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class UserImagePicker extends StatefulWidget {
  final void Function(XFile pickedImage) imagePickFn;
   UserImagePicker(this.imagePickFn);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {

File? _pickedImage;

void _pickImage () async {
  final pick = ImagePicker();
 final pickedImage = await pick.pickImage(source: ImageSource.camera,maxWidth: 150,imageQuality: 50,);
 setState(() {
   _pickedImage = File(pickedImage!.path);
   widget.imagePickFn(pickedImage);
 });

}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage:_pickedImage != null ? FileImage(_pickedImage!) : null,
          radius: 40,
        ),
        TextButton.icon(
            style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.primary)),
            onPressed: null,
            icon: Icon(Icons.image),
            label: Text('Add Image')),
      ],
    );
  }
}
