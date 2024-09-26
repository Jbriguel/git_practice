// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:developer';

import 'package:atelier_so/core/repository/appRepository/app_repository.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../di/global_dependencies.dart';

class InitializeAppData {
  Future<bool?> initialize() async {
    BuildContext? context = getIt<ContextDistributor>().context;
    if (context == null) {
      log("#################### ici ");
      return null;
    }
    await _loadSettings(context);

    await getIt<AppRepository>().loadUserLocalInfos();
    bool appHasBeenOpened = getIt<AppRepository>().appIsOpened;
    log("#################### appHasBeenOpened $appHasBeenOpened ");
    await _registerServices();

    return appHasBeenOpened;
  }

  static _registerServices() async {
    print("debut chargement service");
    await Future.delayed(const Duration(seconds: 2));

    print("debut chargement");
    print("fin chargement service");
  }

  static _loadSettings(BuildContext context) async {
    print("debut chargement setting");
    await Future.delayed(const Duration(seconds: 2));
    print("debut chargement");
    print("fin chargement setting");
  }
}
