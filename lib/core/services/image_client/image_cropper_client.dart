import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:image_cropper/image_cropper.dart'; 

class ImageCropperClient {
  static late ImageCropper _instance;

  static ImageCropperClient init() {
    _instance = ImageCropper();
    return ImageCropperClient();
  }

  Future<CroppedFile?> cropImage({
    required String imagePath,
  }) async {
    CroppedFile? croppedFile = await _instance.cropImage(
      sourcePath: imagePath,
      aspectRatio: const CropAspectRatio(ratioX: 9, ratioY: 8),
      uiSettings: [
        AndroidUiSettings(
          toolbarColor: ThemeColors.black,
          toolbarWidgetColor: ThemeColors.white,
          showCropGrid: false,
          statusBarColor: ThemeColors.black,
          lockAspectRatio: true,
          hideBottomControls: true,
        ),
        IOSUiSettings(
          hidesNavigationBar: false,
        ),
      ],
    );
    return croppedFile;
  }
}