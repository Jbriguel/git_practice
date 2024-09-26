import 'dart:async';
import 'dart:io';

import 'package:atelier_so/core/local_storage/local_storage.dart';
import 'package:atelier_so/core/modeles/message_event/message_event.dart';
import 'package:atelier_so/core/navigations/root_navigator.dart';
import 'package:atelier_so/core/repository/appRepository/app_repository.dart';
import 'package:atelier_so/core/repository/fileRepository/file_repository.dart';
import 'package:atelier_so/core/repository/userRepositories/user_repository.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:atelier_so/core/services/message_event_manager/messageEventManager.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:atelier_so/init.dart';
import 'package:atelier_so/screens/Walkthrough/Walkthrough.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'screens/dashboard/controllers/MenuController.dart';

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Charger les variables d'environnement avant de lancer l'application
    //await dotenv.load(fileName: "ressources/.env");

    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );

    HttpOverrides.global = new PostHttpOverrides();

    await configureDependencies();
    getIt<ContextDistributor>();
    await getIt<FileRepository>().initAppFiles();

    //Blockage de l'app en mode portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) {
              ContextDistributor contextService = getIt<ContextDistributor>();
              contextService.setContext(_);
              // getIt<IntercepteurRepository>().initInterceptor(_);
              // getIt<SyncService>().init(_);
            },
          ),
          ChangeNotifierProvider(create: (_) => getIt<AppLocalData>()),
          ChangeNotifierProvider(create: (_) => getIt<UserRepository>()),
          ChangeNotifierProvider(create: (_) => getIt<AppRepository>()),
          ChangeNotifierProvider(create: (_) => DashMenuController()),
        ],
        builder: ((context, child) => const AtelierSoApp()),
      ),
    );
    // runApp(
    //   const AtelierSoApp(),
    // );
  }, (error, stackTrace) {
    print("############# [ Erreur s'est produite ] ######################");
    if (error is MessageEvent) {
      BuildContext context = error.context!;
      // Gérer l'erreur personnalisée
      print('Une erreur personnalisée s\'est produite: $error');
      ErrorMessageManager.showMessage(error, stackTrace, context);
    } else {
      // Gérer d'autres types d'erreurs
      print('Une erreur inattendue s\'est produite: $error');
    }
  });
}

class AtelierSoApp extends StatefulWidget {
  const AtelierSoApp({super.key});

  @override
  State<AtelierSoApp> createState() => _AtelierSoAppState();
}

class _AtelierSoAppState extends State<AtelierSoApp> {
  late final GoRouter _rootNavigator;

  @override
  void initState() {
    super.initState();
    _rootNavigator = RootNavigator().makeRoutes;
  }

  @override
  void dispose() {
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1)),
      child: MaterialApp.router(
        routerConfig: _rootNavigator,
        title: 'Atelier So',
        theme: ThemeData(
          dividerTheme:
              DividerThemeData(color: ThemeColors.greyDeep.withOpacity(0.2)),
          fontFamily: "Speedee",
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: ThemeColors.redOrange)
              .copyWith(surface: ThemeColors.white, background: Colors.white),
        ),
        // home: const Walkthrough() //InitializationPage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
