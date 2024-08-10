import 'dart:io';

import 'package:flutter/material.dart';
import 'package:t168/src/presentation/partners_screen/pages/widgets/action_buttom.dart';

class ImagePickerWidget extends StatelessWidget {
  final File? image;
  final VoidCallback onPickImage;

  const ImagePickerWidget({
    super.key,
    required this.image,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPickImage,
      child: Center(
        child: Container(
          width: 125,
          height: 125,
          decoration: BoxDecoration(
            color: const Color(0xFF272727),
            image: image != null
                ? DecorationImage(
                    image: FileImage(image!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: image == null
              ? const Icon(
                  Icons.person,
                  size: 90,
                  color: Colors.white,
                )
              : null,
        ),
      ),
    );
  }
}

class AddPhotoButton extends StatelessWidget {
  final VoidCallback onPickImage;

  const AddPhotoButton({
    super.key,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPickImage,
      icon: const Icon(Icons.camera_alt, color: Colors.grey),
      label: const Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'ADD ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
            TextSpan(
              text: 'PHOTO',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      style: TextButton.styleFrom(backgroundColor: Colors.black),
    );
  }
}

class EditRemoveButtons extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onRemove;

  const EditRemoveButtons({
    super.key,
    required this.onEdit,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ActionButton(
          label: 'EDIT PHOTO',
          color: Colors.red,
          onTap: onEdit,
        ),
        ActionButton(
          label: 'REMOVE PHOTO',
          color: const Color(0xFF272727),
          onTap: onRemove,
        ),
      ],
    );
  }
}
