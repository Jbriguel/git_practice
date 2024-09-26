import 'package:atelier_so/core/configuration/configuration.dart';
import 'package:atelier_so/core/functions/crypte.dart';
import 'package:atelier_so/core/local_storage/local_storage.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:atelier_so/core/services/firebase/firebase_client.dart';
import 'package:atelier_so/core/services/image_client/image_client.dart';
import 'package:atelier_so/core/services/image_client/image_cropper_client.dart';
import 'package:atelier_so/core/services/image_client/image_picker_client.dart';
import 'package:injectable/injectable.dart' hide Environment;

@module
abstract class GlobalDependenciesModule {
  // @preResolve
  // Future<SharedPreferencesClient> get sharedPreferenceClient =>
  //     SharedPreferencesClient.init();

  // @preResolve
  // Future<RSAService> get rsaService => RSAService.initializeEncrypter();

  @preResolve
  Future<Configuration> get configuration => Configuration.init();

  @lazySingleton
  ContextDistributor get buildContextService => ContextDistributor();

  @lazySingleton
  ImageClient get imageClient => ImageClient.init();

  @lazySingleton
  ImageCropperClient get imageCropperClient => ImageCropperClient.init();

  @lazySingleton
  ImagePickerClient get imagePickerClient => ImagePickerClient.init();

  @preResolve
  Future<FirebaseClient> get firebaseClient => FirebaseClient.init();
// await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
// );
  // @preResolve
  // Future<AppInfoClient> get appInfoClient => AppInfoClient.init();
}
