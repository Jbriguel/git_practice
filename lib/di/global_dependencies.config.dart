// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:atelier_so/core/configuration/configuration.dart' as _i3;
import 'package:atelier_so/core/database/database_hepler.dart' as _i7;
import 'package:atelier_so/core/local_storage/local_storage.dart' as _i5;
import 'package:atelier_so/core/repository/abonnementRepository/abonnement_repository.dart'
    as _i16;
import 'package:atelier_so/core/repository/appRepository/app_repository.dart'
    as _i19;
import 'package:atelier_so/core/repository/clientRepository/client_repository.dart'
    as _i13;
import 'package:atelier_so/core/repository/commandeRepository/commande_repository.dart'
    as _i18;
import 'package:atelier_so/core/repository/dbExportRepository/DbExportRepository.dart'
    as _i15;
import 'package:atelier_so/core/repository/fileRepository/file_repository.dart'
    as _i6;
import 'package:atelier_so/core/repository/modeleRepository/modele_repository.dart'
    as _i14;
import 'package:atelier_so/core/repository/modeleRepository/propriety_repository.dart'
    as _i12;
import 'package:atelier_so/core/repository/userRepositories/user_repository.dart'
    as _i17;
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart'
    as _i8;
import 'package:atelier_so/core/services/firebase/firebase_client.dart' as _i4;
import 'package:atelier_so/core/services/image_client/image_client.dart' as _i9;
import 'package:atelier_so/core/services/image_client/image_cropper_client.dart'
    as _i10;
import 'package:atelier_so/core/services/image_client/image_picker_client.dart'
    as _i11;
import 'package:atelier_so/di/global_dependencies_module.dart' as _i20;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final globalDependenciesModule = _$GlobalDependenciesModule();
    await gh.factoryAsync<_i3.Configuration>(
      () => globalDependenciesModule.configuration,
      preResolve: true,
    );
    await gh.factoryAsync<_i4.FirebaseClient>(
      () => globalDependenciesModule.firebaseClient,
      preResolve: true,
    );
    gh.singleton<_i5.AppLocalData>(() => _i5.AppLocalData());
    gh.singleton<_i6.FileRepository>(() => _i6.FileRepository());
    gh.lazySingleton<_i7.DatabaseHelper>(() => _i7.DatabaseHelper());
    gh.lazySingleton<_i8.ContextDistributor>(
        () => globalDependenciesModule.buildContextService);
    gh.lazySingleton<_i9.ImageClient>(
        () => globalDependenciesModule.imageClient);
    gh.lazySingleton<_i10.ImageCropperClient>(
        () => globalDependenciesModule.imageCropperClient);
    gh.lazySingleton<_i11.ImagePickerClient>(
        () => globalDependenciesModule.imagePickerClient);
    gh.singleton<_i12.ProprietyRepository>(() => _i12.ProprietyRepository(
          gh<_i8.ContextDistributor>(),
          gh<_i7.DatabaseHelper>(),
        ));
    gh.singleton<_i13.ClientRepository>(() => _i13.ClientRepository(
          gh<_i8.ContextDistributor>(),
          gh<_i7.DatabaseHelper>(),
          gh<_i6.FileRepository>(),
        ));
    gh.singleton<_i14.ModeleRepository>(() => _i14.ModeleRepository(
          gh<_i8.ContextDistributor>(),
          gh<_i7.DatabaseHelper>(),
          gh<_i6.FileRepository>(),
        ));
    gh.singleton<_i15.DbExportRepository>(() => _i15.DbExportRepository(
          gh<_i8.ContextDistributor>(),
          gh<_i7.DatabaseHelper>(),
          gh<_i6.FileRepository>(),
        ));
    gh.singleton<_i16.AbonnementRepository>(() => _i16.AbonnementRepository(
          gh<_i4.FirebaseClient>(),
          gh<_i8.ContextDistributor>(),
          gh<_i5.AppLocalData>(),
        ));
    gh.singleton<_i17.UserRepository>(() => _i17.UserRepository(
          gh<_i4.FirebaseClient>(),
          gh<_i8.ContextDistributor>(),
          gh<_i5.AppLocalData>(),
          gh<_i16.AbonnementRepository>(),
        ));
    gh.singleton<_i18.CommandeRepository>(() => _i18.CommandeRepository(
          gh<_i8.ContextDistributor>(),
          gh<_i7.DatabaseHelper>(),
          gh<_i6.FileRepository>(),
          gh<_i13.ClientRepository>(),
        ));
    gh.singleton<_i19.AppRepository>(() => _i19.AppRepository(
          gh<_i8.ContextDistributor>(),
          gh<_i5.AppLocalData>(),
          gh<_i17.UserRepository>(),
        ));
    return this;
  }
}

class _$GlobalDependenciesModule extends _i20.GlobalDependenciesModule {}
