// ignore_for_file: avoid_classes_with_only_static_members 

import 'package:atelier_so/core/services/image_client/image_cropper_client.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageClient {
  static ImageClient init() => ImageClient();

  static Future<CroppedFile?> cropImage({
    required String imagePath,
  }) async {
    CroppedFile? croppedFile =
        await getIt<ImageCropperClient>().cropImage(imagePath: imagePath);

    return croppedFile;
  }
}