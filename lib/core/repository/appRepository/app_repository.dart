import 'package:atelier_so/core/local_storage/local_storage.dart';
import 'package:atelier_so/core/local_storage/user_local_helper.dart';
import 'package:atelier_so/core/modeles/user/user.dart';
import 'package:atelier_so/core/repository/userRepositories/user_repository.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class AppRepository extends ChangeNotifier {
  ContextDistributor contextDistributor;
  AppLocalData appLocalData;
  BuildContext get context => contextDistributor.context!;
  UserRepository userRepository;
  AppRepository(
      this.contextDistributor, this.appLocalData, this.userRepository) {
    appLocalData.init();
    loadUserLocalInfos();
    notifyListeners();
  }

  void setAppIsOpened() {
    appLocalData.saveAppOpen(true);
    notifyListeners();
  }

  bool get appIsOpened => appLocalData.getAppOpen();

  bool get hasAppBeenOpened => appLocalData.getAppOpen();

  Future<UserInterface?> loadUserLocalInfos() async {
    UserInterface? _userFromLocal = await appLocalData.getUser();
    userRepository.setUser(_userFromLocal);
    userRepository.loadDataFromLocal();
    return _userFromLocal;
  }

  setAppIsClosed() {
    appLocalData.saveAppOpen(false);
    notifyListeners();
  }

  void logout() async {
    userRepository.setUser(null);
    await appLocalData.clearUser();
    setAppIsClosed();
    notifyListeners();
  }
}
