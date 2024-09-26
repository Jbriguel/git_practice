import 'package:atelier_so/core/navigations/root_name.dart';
import 'package:atelier_so/init.dart';
import 'package:atelier_so/screens/Walkthrough/Walkthrough.dart';
import 'package:atelier_so/screens/accueil/accueil_screen.dart';
import 'package:atelier_so/screens/auth/login/login_screen.dart';
import 'package:atelier_so/screens/auth/passwordForget/password_forget_screen.dart';
import 'package:atelier_so/screens/auth/register/register_screen.dart';
import 'package:atelier_so/screens/clients/clients_screen.dart';
import 'package:atelier_so/screens/commande/add_commande_screen.dart';
import 'package:atelier_so/screens/commande/all_commandes_screen.dart';
import 'package:atelier_so/screens/commande/commande_of_day_screen.dart';
import 'package:atelier_so/screens/modeles/modeles.page.dart';
import 'package:go_router/go_router.dart';

class RootNavigator {
  final GoRouter makeRoutes = GoRouter(initialLocation: "/", routes: [
    // Route pour l'écran d'initialisation
    GoRoute(
      name: RootName.welcome_view,
      path: '/',
      builder: (context, state) => InitializationPage(),
    ),
    // Route pour l'écran de walkthrough
    GoRoute(
      name: RootName.login_view,
      path: RootName.login_path,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      name: RootName.register_view,
      path: RootName.register_path,
      builder: (context, state) => RegisterScreen(),
    ),
    //Route pour l'écran de password forget
    GoRoute(
      name: RootName.password_forget_view,
      path: RootName.password_forget_path,
      builder: (context, state) => PasswordForgetScreen(),
    ),
    //Route pour l'écran Accueil
    // GoRoute(
    //   name: RootName.home_view,
    //   path: RootName.home_path,
    //   builder: (context, state) => AccueilScreen(),
    // ),
    // // Route pour l'écran d'authentification
    // GoRoute(
    //   path: '/auth',
    //   builder: (context, state) => AuthenticationPage(),
    // ),
    // Routes pour l'application client

    GoRoute(
      name: RootName.home_view,
      path: RootName.home_path,
      // Toutes les routes pour le client commencent par /client/
      builder: (context, GoRouterState state) => const AccueilScreen(),
      routes: <RouteBase>[
        GoRoute(
          path: RootName.modeles_view,
          builder: (context, state) => AllModelsPage(),
        ),
        GoRoute(
          path: RootName.clients_view,
          builder: (context, state) => AllClientsScreen(),
        ),
        GoRoute(
          path: RootName.allCommandes_view,
          builder: (context, state) => const AllCommandesScreen(),
        ),
        GoRoute(
          path: RootName.addCommande_view,
          builder: (context, state) => AddCommandePage(),
        ),
        GoRoute(
          path: RootName.commandesOfDay_view,
          builder: (context, state) => CommandesOfDayScreen(),
        ),
        // GoRoute(
        //   name: client_login_view,
        //   path: 'login',
        //   builder: (context, state) => const LoginPage(),
        // ),
        // GoRoute(
        //   name: client_register_view,
        //   path: 'register',
        //   builder: (context, state) => const CustomerRegisterPage(),
        // ),
        // GoRoute(
        //   name: client_completProfil_view,
        //   path: 'completProfil',
        //   builder: (context, state) => const CustomerCompletProfilPage(),
        // ),
      ],
    ),
    // Routes pour l'application livreur
  ]);
}
