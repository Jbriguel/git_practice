import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/screens/dataManager/pages/gestions/employees/add_employer_screen.dart';
import 'package:atelier_so/screens/dataManager/pages/gestions/employees/all_employers_screen.dart';
import 'package:atelier_so/screens/dataManager/pages/gestions/managers/all_managers_screen.dart';
import 'package:atelier_so/widgets/PopUps/add_manager.popUp.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:atelier_so/widgets/tabs/flutter_advanced_segment.dart';
import 'package:flutter/material.dart';

class MonPersonnelScreen extends StatefulWidget {
  const MonPersonnelScreen({super.key});

  @override
  State<MonPersonnelScreen> createState() => _MonPersonnelScreenState();
}

class _MonPersonnelScreenState extends State<MonPersonnelScreen>
    with TickerProviderStateMixin {
  final _selectedSegment = ValueNotifier('Employés');
  Map<String, String> menuData = {
    'Employés': ' Employés ',
    'Managers': ' Managers '
  };
  bool showAddButtonEmployer = true;
  bool showAddButtonManager = true;
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // getUserCurrentLocation();
      setState(() {});
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Mon Personnel",
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: ThemeColors.redOrange,
          elevation: 2.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: () {
            if (tabController.index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddUpdateEmployerScreen(
                    onSave: () {
                      setState(() {});
                    },
                    updateMode: false,
                  ),
                ),
              );
            }
            if (tabController.index == 1) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddManagerPopUp(
                      createPropriety: () {
                        setState(() {});
                      },
                    );
                  }).then(
                (value) {
                  setState(() {
                    // getA();
                  });
                },
              );
            }
          },
          mini: false,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //----------------------//
              TabBar(
                controller: tabController,
                labelColor: ThemeColors.redOrange,
                unselectedLabelColor: Colors.grey.shade600,
                dividerColor: Colors.grey.shade200,
                indicatorColor: ThemeColors.redOrange,
                labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                tabs: const [
                  Tab(text: "Mes Employés"),
                  Tab(text: "Mes Managers"),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: TabBarView(controller: tabController, children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: AllEmployersScreen(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: AllManagersScreen(),
                  ),
                ]),
              )
            ]),
      ),
    );
  }
}
