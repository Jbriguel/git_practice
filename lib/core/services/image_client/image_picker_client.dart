// ignore_for_file: avoid_classes_with_only_static_members

import 'package:image_picker/image_picker.dart';

class ImagePickerClient {
  static late ImagePicker _instance;

  static ImagePickerClient init() {
    _instance = ImagePicker();
    return ImagePickerClient();
  }

  Future<XFile?> selectImage(ImageSource imageSource) =>
      _instance.pickImage(source: imageSource);
}