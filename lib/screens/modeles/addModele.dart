import 'dart:io';

import 'package:atelier_so/core/modeles/data_modeles/modele/modele.dart';
import 'package:atelier_so/core/modeles/data_modeles/propriety/propriety.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:atelier_so/screens/modeles/components/editerModeleBody.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'components/addModeleBody.dart';
import 'widgets/selecteProprietyAlert2.dart';

class _MyInherited extends InheritedWidget {
  _MyInherited({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  final MyInheritedWidgetState data;

  @override
  bool updateShouldNotify(_MyInherited oldWidget) {
    return true;
  }
}

class MyInheritedWidget extends StatefulWidget {
  MyInheritedWidget({
    Key? key,
    this.modele,
    required this.child,
  }) : super(key: key);

  final Widget child;
  Modele? modele;

  @override
  MyInheritedWidgetState createState() => MyInheritedWidgetState();

  static MyInheritedWidgetState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_MyInherited>()
            as _MyInherited)
        .data;
  }
}

class MyInheritedWidgetState extends State<MyInheritedWidget> {
  /// List of Items
  List<Propriety> _proprietiesSelected = <Propriety>[];

  void selectPropriety(Propriety propriety) {
    setState(() {
      _proprietiesSelected.add(propriety);
    });
  }

  void getProprietiesSelected() {
    setState(() {
      _proprietiesSelected = _proprietiesSelected;
    });
  }

// All Propriety
  List<Propriety> proprieties_selected = [];
  List<String> filters = [];

  Widget inputChips(Propriety propriety, int index) {
    return InputChip(
      padding: EdgeInsets.all(2.0),
      elevation: 6.0,
      backgroundColor: Colors.white,
      shape: const StadiumBorder(
          side: BorderSide(
        width: 1,
        color: Colors.blueAccent,
      )),
      avatar: CircleAvatar(
        child: Text(propriety.name![0].toUpperCase()),
      ),
      label: Text('${propriety.name}'),
      onDeleted: () {
        setState(() {
          proprieties_selected.removeAt(index);
          getProprietiesSelected();
        });
      },
    );
  }

  Widget actionChips() {
    return ActionChip(
      elevation: 6.0,
      padding: EdgeInsets.all(2.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.green[60],
        child: Icon(Icons.call),
      ),
      label: Text('Call'),
      onPressed: () {},
      backgroundColor: Colors.white,
      shape: StadiumBorder(
          side: BorderSide(
        width: 1,
        color: Colors.blueAccent,
      )),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose

    filters.clear();
    proprieties_selected.clear();

    super.dispose();
  }

  void init() {
    if (widget.modele != null) {
      proprieties_selected = (widget.modele?.proprieties.asList()) ??
          []; // Initialisation à partir du modèle
      filters = proprieties_selected.map((e) => e.name ?? '--').toList();
    } else {
      proprieties_selected = [];
      filters = [];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      filters = [];
      proprieties_selected = [];
    });
    init();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Mettre à jour le contexte ici
    getIt<ContextDistributor>().setContext(context);
  }

  @override
  Widget build(BuildContext context) {
    return _MyInherited(
      data: this,
      child: widget.child,
    );
  }
}

class AddModelePage extends StatefulWidget {
  final Function press;
  bool editeMode;
  Modele? modele;
  AddModelePage({required this.press, this.editeMode = false, this.modele});

  @override
  State<AddModelePage> createState() => _AddModelePageState();
}

class _AddModelePageState extends State<AddModelePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Mettre à jour le contexte ici
    getIt<ContextDistributor>().setContext(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: MyInheritedWidget(
        modele: widget.modele,
        child: widget.editeMode
            ? EditerModeleBody(
                press: () => widget.press(),
                modele: widget.modele!,
              )
            : AddModeleBody(press: (() => widget.press())),
      ),
    );
  }
}
