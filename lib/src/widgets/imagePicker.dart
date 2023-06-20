import 'dart:io';
import 'package:cers/src/utils/app_const.dart';
import 'package:cers/src/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_imageFile != null) ...[
          Image.file(
            _imageFile!,
            width: 150,
            height: 150,
          ),
          SizedBox(height: 10),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppButton(
                onPress: () => _pickImage(ImageSource.camera),
                label: 'Take a Photo',
                borderRadius: 15,
                textColor: AppConst.secondary,
                bcolor: AppConst.primary),
            AppButton(
                onPress: () => _pickImage(ImageSource.gallery),
                label: 'Choose from Gallery',
                borderRadius: 15,
                textColor: AppConst.secondary,
                bcolor: AppConst.primary),
          ],
        ),
      ],
    );
  }
}
