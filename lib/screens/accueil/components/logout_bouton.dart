import 'package:atelier_so/core/repository/userRepositories/user_repository.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:atelier_so/widgets/PopUps/logout.popUp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class logoutBouton extends StatelessWidget {
  const logoutBouton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(
          CupertinoIcons.power,
          color: Colors.black,
        ),
        color: Colors.black,
        onPressed: () {
          showDialog(
              context: context,
              useSafeArea: true,
              barrierDismissible: true,
              builder: (context) {
                return ConfirmeDeconnexionAlert(press: () async {
                  getIt<UserRepository>().logout();
                  context.go('/');
                });
              });
        });
  }
}
