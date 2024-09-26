// import 'dart:io';

// import 'package:flutter/material.dart'; 
// import 'package:tela/models/modele/Modele.dart';
// import 'package:tela/screens/modeles/components/viewModeleBody.dart'; 
// import 'package:tela/models/propriety.dart'; 
 

// class _MyInheritedForViewModele extends InheritedWidget {
//   _MyInheritedForViewModele({
//     Key? key,
//     required this.leModele,
//     required Widget child,
//     required this.data,
//   }) : super(key: key, child: child);

//   final MyInheritedForViewModeleWidgetState data;
//   final Modele leModele;
//   @override
//   bool updateShouldNotify(_MyInheritedForViewModele oldWidget) {
//     return true;
//   }
// }

// class MyInheritedForViewModeleWidget extends StatefulWidget {
//   MyInheritedForViewModeleWidget({
//     Key? key,
//     required this.child,
//     required this.leModele,
//   }) : super(key: key);

//   final Widget child;
//   final Modele leModele;

//   @override
//   MyInheritedForViewModeleWidgetState createState() =>
//       MyInheritedForViewModeleWidgetState();

//   static MyInheritedForViewModeleWidgetState of(BuildContext context) {
//     return (context
//                 .dependOnInheritedWidgetOfExactType<_MyInheritedForViewModele>()
//             as _MyInheritedForViewModele)
//         .data;
//   }
// }

// class MyInheritedForViewModeleWidgetState
//     extends State<MyInheritedForViewModeleWidget> {
//   List<Propriety> _proprietiesSelected = <Propriety>[];

//   void selectPropriety(Propriety propriety) {
//     setState(() {
//       _proprietiesSelected.add(propriety);
//     });
//   }

//   void getProprietiesSelected() {
//     setState(() {
//       _proprietiesSelected = _proprietiesSelected;
//     });
//   }

// // All Propriety
//   List<Propriety> proprieties_selected = [];
//   List<String> filters = [];

//   reInit() {
//     proprieties_selected = [];
//     filters = [];
//   }

//   initData() {
//     setState(() {
//       proprieties_selected = [];
//       filters = [];
//       proprieties_selected = widget.leModele.proprieties;
//     });
//   }

//   Widget inputChips(Propriety propriety, int index) {
//     return InputChip(
//       padding: EdgeInsets.all(2.0),
//       elevation: 6.0,
//       backgroundColor: Colors.white,
//       shape: const StadiumBorder(
//           side: BorderSide(
//         width: 1,
//         color: Colors.blueAccent,
//       )),
//       avatar: CircleAvatar(
//         child: Text(propriety.name![0].toUpperCase()),
//       ),
//       label: Text('${propriety.name}'),
//       onDeleted: () {
//         setState(() {
//           proprieties_selected.removeAt(index);
//           getProprietiesSelected();
//         });
//       },
//     );
//   }

//   Widget inputChipsView(Propriety propriety, int index) {
//     return InputChip(
//       padding: EdgeInsets.all(2.0),
//       elevation: 6.0,
//       backgroundColor: Colors.white,
//       shape: const StadiumBorder(
//           side: BorderSide(
//         width: 1,
//         color: Colors.blueAccent,
//       )),
//       avatar: CircleAvatar(
//         child: Text(propriety.name![0].toUpperCase()),
//       ),
//       label: Text('${propriety.name}'),
//       onPressed: (() {}),
//     );
//   }

//   @override
//   void dispose() {
//     // TODO: implement disposeù
//     reInit();

//     super.dispose();
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     initData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _MyInheritedForViewModele(
//       data: this,
//       leModele: widget.leModele,
//       child: widget.child,
//     );
//   }
// }

// class ViewModelePage extends StatefulWidget {
//   final Function press;
//   Modele leModele;
//   ViewModelePage({
//     Key? key,
//     required this.leModele,
//     required this.press,
//   });

//   @override
//   State<ViewModelePage> createState() => _ViewModelePageState();
// }

// class _ViewModelePageState extends State<ViewModelePage> {
//   @override
//   Widget build(BuildContext context) {
//     return MyInheritedForViewModeleWidget(
//       leModele: widget.leModele,
//       child: ViewModeleBody(
//         press: (() => widget.press()),
//         leModele: widget.leModele,
//       ),
//     );
//   }
// }
