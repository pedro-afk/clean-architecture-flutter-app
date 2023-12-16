import 'dart:io';
import 'package:image_picker/image_picker.dart';

abstract class ServiceImagePicker {
  Future<File?> get pickImageFromCamera;
  Future<File?> get pickImageFromGallery;
}

class ServiceImagePickerImpl implements ServiceImagePicker {
  final ImagePicker _imagePicker;

  ServiceImagePickerImpl(this._imagePicker);

  @override
  Future<File?> get pickImageFromCamera async {
    XFile? file = await _imagePicker.pickImage(source: ImageSource.camera);
    if (file == null) return null;
    return File(file.path);
  }

  @override
  Future<File?> get pickImageFromGallery async {
    XFile? file = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) return null;
    return File(file.path);
  }
}