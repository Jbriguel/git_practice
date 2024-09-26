import 'package:atelier_so/components/default_btn/defaultButton.dart';
import 'package:atelier_so/core/functions/uid_generator.dart';
import 'package:atelier_so/core/modeles/data_modeles/propriety/propriety.dart';
import 'package:atelier_so/core/modeles/employe/employe.dart';
import 'package:atelier_so/core/repository/modeleRepository/propriety_repository.dart';
import 'package:atelier_so/core/repository/userRepositories/user_extensions/entreprise/employees_repository.ext.dart';
import 'package:atelier_so/core/repository/userRepositories/user_extensions/entreprise/managers_repository.ext.dart';
import 'package:atelier_so/core/repository/userRepositories/user_repository.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:atelier_so/screens/dataManager/pages/gestions/components/userCard_lineMode.dart';
import 'package:atelier_so/screens/modeles/widgets/rechercheCard.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:atelier_so/widgets/custom/cutomInput.dart';
import 'package:atelier_so/widgets/custom/loading.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddManagerPopUp extends StatefulWidget {
  AddManagerPopUp({super.key, required this.createPropriety});
  void Function() createPropriety;

  @override
  State<AddManagerPopUp> createState() => _ConfirmeDeconnexionAlertState();
}

class _ConfirmeDeconnexionAlertState extends State<AddManagerPopUp>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeInExpo);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
    _refreshEmployes();
  }

  TextEditingController rechercheController = TextEditingController();
  UserRepository _userRepository =
      getIt<UserRepository>(); // Initialise ton repository

  List<Employe> _employesList = [];
  List<Employe> _employesSelectedList = [];
  bool _isLoading = false;
  bool deleteMode = false;

  void promouvoirEmployer() async {
    if (_employesSelectedList.isEmpty) {
      return;
    }
    LoadingDialog.show(context);
    for (Employe employe in _employesSelectedList) {
      if (employe.uid != null) {
        await _userRepository.promoteToManager(employe.uid!);
      }
    }
    LoadingDialog.hide(context);
    _employesSelectedList.clear();
    setState(() {});
    _refreshEmployes();
  }

  void selectOrDeselectEmployer(Employe employe) {
    setState(() {
      if (_employesSelectedList.contains(employe)) {
        _employesSelectedList.remove(employe);
      } else {
        _employesSelectedList.add(employe);
      }
    });
  }

  bool _isSelected(Employe employe) {
    return _employesSelectedList.contains(employe);
  }

  void _refreshEmployes() async {
    setState(() {
      _isLoading = true;
    });
    final List<Employe> data =
        await _userRepository.listEmployes(_userRepository.user?.entrepriseId);
    setState(() {
      _employesList = data;
      _isLoading = false;
      rechercheController.text = "";
    });
  }

  List<Employe> getFilteredEmployes() {
    String mot = rechercheController.text;
    if (mot.trim().isNotEmpty) {
      return _employesList
          .where((employe) =>
              (employe.nom ?? '')
                  .toLowerCase()
                  .contains(mot.toLowerCase().trim()) ||
              (employe.adresse ?? '')
                  .toLowerCase()
                  .contains(mot.toLowerCase().trim()) ||
              (employe.phone ?? '')
                  .toLowerCase()
                  .contains(mot.toLowerCase().trim()))
          .toList();
    } else {
      return _employesList;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getIt<ContextDistributor>().setContext(context);
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1)),
        child: Center(
            child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
              scale: scaleAnimation,
              child: OrientationBuilder(builder: (context, orientation) {
                return SingleChildScrollView(
                  child: Container(
                    width: orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.width * 0.9
                        : MediaQuery.of(context).size.width * 0.75,
                    margin: const EdgeInsets.all(5.0),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      shadows: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  height: 20,
                                  child: Image.asset(
                                    Images.plus,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2.0, horizontal: 10.0),
                                  child: Text("Nouveau Manger",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Speedee',
                                          color: ThemeColors.greyDeep)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 55,
                            child: Row(
                              children: [
                                Expanded(
                                  child: RechercheBar(
                                    onChanged: (String value) {
                                      setState(() {
                                        rechercheController.text = value;
                                      });
                                    },
                                    onClear: () {
                                      setState(() {
                                        rechercheController.text = "";
                                      });
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: Container(
                                    decoration: BoxDecoration(
                                        color: ThemeColors.redOrange
                                            .withOpacity(0.2),
                                        shape: BoxShape.circle),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.refresh,
                                        color: ThemeColors.redOrange,
                                      ),
                                    ),
                                  ),
                                  color: ThemeColors.redOrange.withOpacity(0.2),
                                  onPressed: () {
                                    _refreshEmployes();
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 5),
                            child: Divider(
                              color: ThemeColors.greyDeep.withOpacity(0.1),
                            ),
                          ),
                          _isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : getFilteredEmployes().isEmpty
                                  ? Flexible(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 50),
                                            CustomImageView(
                                              fit: BoxFit.contain,
                                              imagePath: Images.folder,
                                              height: 50,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 10.0),
                                              child: Text(
                                                rechercheController.text.isEmpty
                                                    ? "Aucun Employé trouvé"
                                                    : "Aucun employé ne correspond à votre recherche",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Speedee',
                                                  color: ThemeColors.greyDeep,
                                                ),
                                              ),
                                            ),
                                            rechercheController.text.isNotEmpty
                                                ? const SizedBox.shrink()
                                                : DefaultButton(
                                                    paddingV: 5,
                                                    fontSize: 13,
                                                    height: 40,
                                                    textColor:
                                                        ThemeColors.white,
                                                    backColor:
                                                        ThemeColors.greyDeep,
                                                    text: " Actualiser "
                                                        .toUpperCase(),
                                                    press: () {
                                                      _refreshEmployes();
                                                    }),
                                            const SizedBox(height: 50),
                                          ]),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: getFilteredEmployes().length,
                                      itemBuilder: (context, index) {
                                        Employe employe =
                                            getFilteredEmployes()[index];
                                        return EmployeCardLineMode(
                                          user: employe,
                                          onSelected: selectOrDeselectEmployer,
                                          isSelected: _isSelected(employe),
                                        );
                                      }),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Row(children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    print('yes selected');
                                    Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      elevation: 1.0,
                                      surfaceTintColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      backgroundColor: Colors.white),
                                  child: const Text(
                                    "Annuler",
                                    style: TextStyle(
                                        fontFamily: "Speedee",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: ThemeColors.red),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 5),
                                child: Divider(
                                  color: ThemeColors.greyDeep.withOpacity(0.1),
                                ),
                              ),
                              Expanded(
                                  child: ElevatedButton(
                                onPressed: () async {
                                  if (_employesSelectedList.isEmpty) {
                                    return;
                                  } else {
                                    promouvoirEmployer();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  backgroundColor: _employesSelectedList.isEmpty
                                      ? ThemeColors.greyDisable
                                      : ThemeColors.redOrange,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                child: Text(
                                  "Promouvoir",
                                  style: TextStyle(
                                      fontFamily: "Speedee",
                                      fontSize: 12,
                                      color: _employesSelectedList.isEmpty
                                          ? ThemeColors.greyDeep
                                          : Colors.white),
                                ),
                              ))
                            ]),
                          ),
                        ]),
                  ),
                );
              })),
        )));
  }
}
