import 'package:atelier_so/core/services/image_client/image_cropper_client.dart';
import 'package:atelier_so/core/services/image_client/image_picker_client.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'image_client.dart';
 

extension ImageClientExtension on ImageClient {
  Future<XFile?> selectImage() async {
    final XFile? result =
        await getIt<ImagePickerClient>().selectImage(ImageSource.gallery);
    final CroppedFile? croppedFile = await _cropFile(result);
    final XFile? compressedFile = await _compressFile(croppedFile, result);
    return compressedFile;
  }

  Future<XFile?> takePhoto() async {
    final XFile? result =
        await getIt<ImagePickerClient>().selectImage(ImageSource.camera);
    final CroppedFile? croppedFile = await _cropFile(result);
    final XFile? compressedFile = await _compressFile(croppedFile, result);
    return compressedFile;
  }

  Future<CroppedFile?> _cropFile(XFile? file) async {
    if (file == null) return null;
    return getIt.get<ImageCropperClient>().cropImage(imagePath: file.path);
  }

  Future<XFile?> _compressFile(CroppedFile? file, XFile? source) async {
    if (file != null && source != null) {
      final imgPath = file.path;
      final imgPathCache = imgPath.substring(0, imgPath.lastIndexOf("/"));

      final imgOriginalSize = await source.length();
      int quality = 0;

      if (imgOriginalSize > 0 && imgOriginalSize < 500) {
        quality = 70;
      } else if (imgOriginalSize > 500 && imgOriginalSize < 1000) {
        quality = 65;
      } else if (imgOriginalSize > 1000 && imgOriginalSize < 2000) {
        quality = 60;
      } else if (imgOriginalSize > 2000 && imgOriginalSize < 3000) {
        quality = 50;
      } else if (imgOriginalSize > 3000 && imgOriginalSize < 5000) {
        quality = 45;
      } else {
        quality = 40;
      }

      return FlutterImageCompress.compressAndGetFile(
          imgPath, "$imgPathCache/${source.name.split(".")[0]}.jpg",
          quality: quality);
    }

    return null;
  }
}