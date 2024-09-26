import 'package:atelier_so/core/repository/userRepositories/user_extensions/entreprise/employees_repository.ext.dart';
import 'package:atelier_so/core/repository/userRepositories/user_repository.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:atelier_so/screens/dataManager/pages/gestions/components/userCard.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:flutter/material.dart';
import 'package:atelier_so/core/modeles/employe/employe.dart';
import 'package:atelier_so/widgets/custom/loading.dart';

class AllEmployersScreen extends StatefulWidget {
  AllEmployersScreen({Key? key, this.selectedMode = false}) : super(key: key);

  final bool selectedMode;

  @override
  State<AllEmployersScreen> createState() => _AllEmployersScreenState();
}

class _AllEmployersScreenState extends State<AllEmployersScreen> {
  TextEditingController rechercheController = TextEditingController();
  UserRepository _userRepository =
      getIt<UserRepository>(); // Initialise ton repository

  List<Employe> _employesList = [];
  bool _isLoading = true;
  bool deleteMode = false;

  void deleteEmploye(String employeId) async {
    LoadingDialog.show(context);
    await _userRepository.deleteEmploye(employeId).then((_) {
      _refreshEmployes();
    }).whenComplete(() => LoadingDialog.hide(context));
  }

  void _refreshEmployes() async {
    final List<Employe> data =
        await _userRepository.listEmployes(_userRepository.user?.entrepriseId);
    setState(() {
      _employesList = data;
      _isLoading = false;
      rechercheController.text = "";
    });
  }

  void _rechercherEmployes(String mot) async {
    if (mot.trim().isNotEmpty) {
      setState(() {
        _employesList = _employesList
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
      });
    } else {
      _refreshEmployes();
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshEmployes();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getIt<ContextDistributor>().setContext(context);
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
    return Column(
      children: [
        Container(
          height: 55,
          margin: const EdgeInsets.all(5),
          child: Row(
            children: [
              Expanded(
                child: _Rechecher(),
              ),
              IconButton(
                icon: Container(
                  decoration: BoxDecoration(
                      color: ThemeColors.redOrange.withOpacity(0.4),
                      shape: BoxShape.circle),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.refresh,
                      color: ThemeColors.white,
                    ),
                  ),
                ),
                color: ThemeColors.redOrange.withOpacity(0.4),
                onPressed: () => _rechercherEmployes(""),
              ),
            ],
          ),
        ),
        _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _employesList.isEmpty
                ? Flexible(
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
                            "Aucun employé trouvé",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Speedee',
                              color: ThemeColors.greyDeep,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisExtent: 140,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: _employesList.length,
                      itemBuilder: (ctx, index) {
                        Employe employe = _employesList[index];
                        return CustomCard(
                          user: employe,
                          showDeleteBtn: true, // Ou condition pour afficher
                          onDelete: (String? elementId) {
                            if (elementId != null) {
                              deleteEmploye(elementId);
                            }
                          },
                        );
                      },
                    ),
                  ),
      ],
    );
  }

  Widget _Rechecher() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      color: Colors.grey.shade100,
      child: Container(
        height: 50.0,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 2,
            ),
            Expanded(
              child: TextField(
                onChanged: (value) {
                  _rechercherEmployes(value);
                },
                controller: rechercheController,
                decoration: const InputDecoration.collapsed(
                  border: InputBorder.none,
                  hintText: "Recherche par nom, adresse ou téléphone...",
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                rechercheController.text = "";
                _rechercherEmployes("");
              },
            ),
          ],
        ),
      ),
    );
  }
}
