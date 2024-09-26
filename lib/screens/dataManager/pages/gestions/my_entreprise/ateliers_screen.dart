import 'package:atelier_so/components/default_btn/defaultButton.dart';
import 'package:atelier_so/core/modeles/atelier/atelier.dart';
import 'package:atelier_so/core/repository/userRepositories/user_extensions/atelier/atelier_repository.ext.dart';
import 'package:atelier_so/core/repository/userRepositories/user_repository.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:atelier_so/screens/dataManager/pages/gestions/components/atelierCard.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:flutter/material.dart';

class MesAteliersScreen extends StatefulWidget {
  const MesAteliersScreen({super.key});

  @override
  State<MesAteliersScreen> createState() => _MesAteliersScreenState();
}

class _MesAteliersScreenState extends State<MesAteliersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ScrollController _controller = ScrollController();

  final _formKey2 = GlobalKey<FormState>();
  Atelier? atelierSelected;
//------------------------------------------------------

  void initData() {
    /// numeroSerieCtrl.text = generateRandomString(10);
    getAteliers();
  }

//------------------------------------------------------

  bool _isLoading = true;
  //Get all Atelierrs
  List<Atelier> _ateliersList = [];
  void getAteliers() async {
    setState(() {
      _isLoading = true;
    });
    _ateliersList = await _userRepository
        .listAteliersByEntreprise(_userRepository.user!.entrepriseId);
    setState(() {
      _isLoading = false;
    });
  }

  Widget displayImage() {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white),
      padding: const EdgeInsets.all(2),
      child: CustomImageView(
        imagePath: Images.afro_man_avatar,
        fit: BoxFit.cover,
      ),
    );
  }

  //////////////////////////////////////////////////////////////

  /////////////////////////////////////////////////////////////

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    initData();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen_size_width = MediaQuery.of(context).size.width;
    final screen_size_height = MediaQuery.of(context).size.height;
    // Calculer la largeur de l'écran
    final screenWidth = MediaQuery.of(context).size.width;
    // Définir une largeur fixe pour chaque carte
    final cardWidth = 300.0;
    // Calculer le nombre de colonnes basé sur la largeur de l'écran
    final crossAxisCount = (screenWidth / cardWidth).floor();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mes ateliers",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          Image.asset(
            Images.logo2,
            fit: BoxFit.contain,
            height: 40,
            width: 40,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _ateliersList.isEmpty
              ? Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomImageView(
                          fit: BoxFit.contain,
                          imagePath: Images.folder,
                          height: 50,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          child: Text(
                            "Aucun Atelier trouvé",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Speedee',
                              color: ThemeColors.greyDeep,
                            ),
                          ),
                        ),
                        DefaultButton(
                            paddingV: 5,
                            fontSize: 13,
                            height: 40,
                            textColor: ThemeColors.white,
                            backColor: ThemeColors.greyDeep,
                            text: " Actualiser ".toUpperCase(),
                            press: () {
                              getAteliers();
                            }),
                      ]),
                )
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Flexible(
                    child: GridView.builder(
                        controller: _controller,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisExtent: 140,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemCount: _ateliersList.length,
                        itemBuilder: (BuildContext ctx, index) {
                          Atelier atelier = _ateliersList[index];
                          return AtelierCard(
                            atelier: atelier,
                            showDeleteBtn: false,
                            selectionMode: false,
                            isSelected: atelierSelected == atelier,
                            onSelected: (Atelier atlr) {
                              setState(() {
                                atelierSelected = atlr;
                              });
                            },
                            onDelete: null,
                          );
                        }),
                  ),
                ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Mettre à jour le contexte ici
    getIt<ContextDistributor>().setContext(context);
  }

  UserRepository _userRepository = getIt<UserRepository>();
}
