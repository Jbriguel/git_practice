import 'dart:developer';
import 'package:atelier_so/core/modeles/user/user.dart';
import 'package:atelier_so/core/repository/appRepository/initializeApp.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:atelier_so/screens/accueil/accueil_screen.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:flutter/material.dart';

import 'core/repository/userRepositories/user_repository.dart';
import 'screens/Walkthrough/Walkthrough.dart';
import 'screens/auth/login/login_screen.dart';

class InitializationPage extends StatefulWidget {
  InitializationPage({Key? key}) : super(key: key);

  @override
  State<InitializationPage> createState() => _InitializationPageState();
}

class _InitializationPageState extends State<InitializationPage> {
  @override
  void initState() {
    super.initState();
    // _initializeFuture = InitializeAppData().initialize(context);
    getIt<ContextDistributor>().setContext(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Mettre à jour le contexte ici
    getIt<ContextDistributor>().setContext(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool?>(
      future: InitializeAppData().initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          //if (snapshot.hasData) {
          bool? data = snapshot.data;
          log("############################### data $data");
          if (data == true) {
            UserInterface? user = getIt<UserRepository>().user;
            log("Initialize ${user.toString()}");
            if (user != null) {
              return const AccueilScreen();
            } else {
              return  const LoginScreen();
            }
          } else {
            return Walkthrough();
          }
        }

        return const SplashScreen();
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.stop();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.white,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath: Images.logo,
                height: 200,
                width: 200,
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: SizedBox.square(
            dimension: 40,
            child: Image.asset(
              Images.loading,
              fit: BoxFit.contain,
              gaplessPlayback: true,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (_controller.isAnimating) {
                  return child;
                } else {
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      _controller.forward(from: 0);
                    },
                    child: child,
                  );
                }
              },
              semanticLabel: 'GIF',
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
