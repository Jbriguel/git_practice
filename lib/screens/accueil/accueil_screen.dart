import 'dart:io';

import 'package:atelier_so/animations/delay_animation.dart';
import 'package:atelier_so/core/functions/date_manipulation.dart';
import 'package:atelier_so/core/navigations/root_name.dart';
import 'package:atelier_so/core/repository/userRepositories/user_repository.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:atelier_so/screens/clients/clients_screen.dart';
import 'package:atelier_so/screens/commande/add_commande_screen.dart';
import 'package:atelier_so/screens/commande/all_commandes_screen.dart';
import 'package:atelier_so/screens/commande/commande_of_day_screen.dart';
import 'package:atelier_so/screens/dataManager/data_manager_screen.dart';
import 'package:atelier_so/screens/modeles/modeles.page.dart';
import 'package:atelier_so/widgets/PopUps/logout.popUp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'components/logout_bouton.dart';
import 'components/option_card.dart';

class AccueilScreen extends StatefulWidget {
  const AccueilScreen({super.key});

  @override
  State<AccueilScreen> createState() => _AccueilScreenState();
}

class _AccueilScreenState extends State<AccueilScreen>
    with SingleTickerProviderStateMixin {
  static late DateTime dateTime = DateTime.now();
  List<Map<String, String>> dateList = [];

  ScrollController _controller = ScrollController();

  bool? permissionGranted;
  ///////////////////////////////////////////////////////////////////////////

  Future _getStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      setState(() {
        permissionGranted = true;
      });
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.storage.request().isDenied) {
      setState(() {
        permissionGranted = false;
      });
    }
  }

///////////////////////////////////////////////////////////////////////////
  Map<String, dynamic> feedbacks = {};
  // List<Message> _messages = [];

  final _formKey = GlobalKey<FormState>();

/////////////////////////////////////////////////////////////////////////////
  void showInSnackBar(String value) {
    // Scaffold.of(context).showSnackBar( SnackBar(content:  Text(value)));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }

//##################################################################################//

  @override
  void initState() {
    super.initState();
    //getContact();
    _getStoragePermission();
  }

  @override
  void dispose() {
    super.dispose();
  }

////////////////////////////////////////////////////////////////////////////////////

  List<Widget> _getData() {
    List<Widget> list = [
      /*#####################ADD COMMANDE########################### */
      optionCard(
        image: Images.add_commande,
        titre: "Ajouter Commande",
        subTitle: "Nouvelle commande",
        press: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCommandePage(),
            ),
          );
        },
      ),

      /*#####################Les Commandes########################### */
      optionCard(
          image: Images.thread_2,
          titre: "Les Commandes",
          subTitle: "Commandes des Clients",
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AllCommandesScreen(),
              ),
            );
          }),
      /*#####################All CLIENTS########################### */
      optionCard(
        image: Images.clients,
        titre: "Mes Clients",
        subTitle: "Afficher tous mes clients",
        press: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AllClientsScreen(),
            ),
          );
        },
      ),

      /*#####################CALENDRIER########################### */
      Card(
        color: Colors.white,
        elevation: 2.0,
        shadowColor: Colors.grey.shade400,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1.2, color: Colors.white12),
          borderRadius: BorderRadius.circular(8.0),
        ),
        //color: Colors.transparent,
        child: Stack(children: [
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  Images.init_back_3,
                ),
              ),
            ),
          ),
          Opacity(
            opacity: 0.6,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Column(children: <Widget>[
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "${dateTime.day}",
                  style: TextStyle(
                      fontFamily: 'Speedee',
                      fontSize: (MediaQuery.of(context).size.width * 0.4) / 3,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "${stringMonth("${dateTime.month}")} -${dateTime.year}",
                      style: const TextStyle(
                          fontFamily: 'Speedee',
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w500),
                    ),
                    const Text(
                      "",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ]),
      ),

      /*#####################Modeles########################### */

      optionCard(
        image: Images.shirts,
        titre: "Mes modèles",
        subTitle: "Nos Différents modèles",
        press: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AllModelsPage(),
            ),
          );
        },
      ),
      /*#####################Commande du jour########################### */
      optionCard(
        image: Images.calendar_2,
        titre: "Commande du Jour",
        subTitle: "Les rendez-vous du jour",
        press: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CommandesOfDayScreen(),
            ),
          );
        },
      ),
      /*#####################PARAMETRE########################### */

      //  Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ParametrePage(),
      //   ),
      // ),

      optionCard(
        image: Images.setting,
        titre: "Paramètre",
        subTitle: "Paramatrer l'application",
        press: () {},
      ),
      /*#####################Gestion de données########################### */

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => DataManagerScreen(),
      //   ),
      // ),

      optionCard(
        image: Images.data_manager,
        titre: "Gestion de données",
        subTitle: "Manipulation de données",
        press: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DataManagerScreen(),
            ),
          );
        },
      ),
    ];
    return list;
  }

  Future<bool> showExitPopup(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Voulez vous fermer l'application?"),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print('yes selected');
                            exit(0);
                          },
                          child: Text("Quitter"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade800),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          print('no selected');
                          Navigator.of(context).pop();
                        },
                        child:
                            Text("Non", style: TextStyle(color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Mettre à jour le contexte ici
    getIt<ContextDistributor>().setContext(context);
  }

  @override
  Widget build(BuildContext context) {
    dateList = daysOfWeek(dateTime);
    final screen_size_width = MediaQuery.of(context).size.width;
    final screen_size_height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Consumer<UserRepository>(builder: (context, userRepo, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            leadingWidth: 40,
            leading: Image.asset(
              Images.logo2,
              fit: BoxFit.contain,
              height: 40,
              width: 40,
            ),
            /*  title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    Images.logo2,
                    fit: BoxFit.contain,
                    height: 40,
                    width: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      /*Text(
                      'Te',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      'La',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),*/
                    ],
                  ),
                ],
              ),
            ),*/
            title: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Bonjour 👋\n",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                  TextSpan(
                    text: userRepo.user?.getFullName() ?? '--',
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              logoutBouton(),
            ],
          ),
          body: Stack(children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Images.init_back_2), fit: BoxFit.cover),
              ),
            ),
            Opacity(
              opacity: 0.5,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
              ),
            ),
            DelayedAnimation(
              delay: 1000,
              child: Column(children: [
                Expanded(
                  child: GridView.builder(
                    controller: _controller,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 250,
                            childAspectRatio: 9 / 10,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 8),
                    itemCount: _getData().length,
                    itemBuilder: (BuildContext ctx, index) {
                      return _getData()[index];
                    },
                  ),
                ),
              ]),
            ),
          ]),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniStartDocked,
          bottomNavigationBar: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 8,
            ),
            child: Text(
              "©copyright | 2022 | ---",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Speedee',
                fontSize: 10,
                color: ThemeColors.black.withOpacity(0.7),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }),
    );
  }
}
