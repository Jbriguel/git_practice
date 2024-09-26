import 'package:atelier_so/core/modeles/manager/manager.dart';
import 'package:atelier_so/core/repository/userRepositories/user_extensions/entreprise/managers_repository.ext.dart';
import 'package:atelier_so/core/repository/userRepositories/user_repository.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:atelier_so/screens/dataManager/pages/gestions/components/userCard.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:atelier_so/widgets/custom/loading.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class AllManagersScreen extends StatefulWidget {
  AllManagersScreen({Key? key, this.selectedMode = false}) : super(key: key);

  bool selectedMode;

  @override
  State<AllManagersScreen> createState() => _AllManagersScreenState();
}

class _AllManagersScreenState extends State<AllManagersScreen> {
  TextEditingController searchController = TextEditingController();

  UserRepository _userRepository = getIt<UserRepository>();

  ScrollController _controller = ScrollController();

  List<Manager> _managersList = [];

  bool _isLoading = false;

  void deleteManager(String managerUid) async {
    LoadingDialog.show(context);
    await _userRepository
        .deleteManager(managerUid)
        .then((value) {})
        .whenComplete(() => LoadingDialog.hide(context));
    setState(() {});
  }

  void _refreshManagers() async {
    setState(() {
      _isLoading = true;
    });
    final List<Manager> data = await _userRepository
        .listManagersByEntreprise(_userRepository.user?.entrepriseId);
    setState(() {
      _managersList = data;
      _isLoading = false;
      searchController.text = "";
    });
  }

  void _searchManagers(String keyword) async {
    if (keyword.trim().isNotEmpty) {
      setState(() {
        _managersList = _managersList
            .where((manager) => (manager.name ?? '')
                .toLowerCase()
                .contains(keyword.toLowerCase().trim()))
            .toList();
      });
    } else {
      _refreshManagers();
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshManagers();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getIt<ContextDistributor>().setContext(context);
  }

  String _selectedSearchBy = 'searchByName';

  Widget _SearchWidget() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 0.0,
      color: Colors.grey.shade100,
      child: Container(
        height: 50.0,
        child: Row(
          children: <Widget>[
            PopupMenuButton(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              onSelected: (value) => setState(() => _selectedSearchBy = value),
              itemBuilder: (_) => [
                CheckedPopupMenuItem(
                  checked: _selectedSearchBy == 'searchByName',
                  value: 'searchByName',
                  child: const Text('Search by name'),
                ),
                // Add more search options if needed
              ],
            ),
            Expanded(
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchManagers(value);
                  });
                },
                controller: searchController,
                decoration: InputDecoration.collapsed(
                  border: InputBorder.none,
                  hintText:
                      "Search by ${_selectedSearchBy == 'searchByName' ? 'name' : '...'}",
                  focusColor: Colors.white,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.clear),
              iconSize: 20.0,
              color: ThemeColors.redOrange,
              onPressed: () {
                setState(() {
                  searchController.text = "";
                  _searchManagers("");
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  bool deleteMode = false;

  @override
  Widget build(BuildContext context) {
    final screen_size_width = MediaQuery.of(context).size.width;
    final screen_size_height = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = 300.0;
    final crossAxisCount = (screenWidth / cardWidth).floor();

    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1)),
      child: Column(children: [
        Container(
          height: 55,
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: _SearchWidget(),
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
                onPressed: () => _searchManagers(""),
              ),
            ],
          ),
        ),
        _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _managersList.isEmpty
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
                            "Aucun manager trouvé",
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
                : Flexible(
                    child: GridView.builder(
                        controller: _controller,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisExtent: 145 + (deleteMode ? 10 : 0),
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemCount: _managersList.length,
                        itemBuilder: (BuildContext ctx, index) {
                          Manager manager = _managersList[index];
                          return CustomCard(
                            user: manager,
                            showDeleteBtn: deleteMode,
                            onSelected: () {},
                            onDelete: (String? elementId) {
                              elementId != null
                                  ? deleteManager(elementId)
                                  : null;
                              _refreshManagers();
                            },
                          );
                        }),
                  ),
      ]),

      // ),
    );
  }
}
