// import 'package:flutter/material.dart';
// import 'package:tela/helper/dbHelper.dart';
// import 'package:tela/models/propriety.dart';
// import 'package:tela/screens/modeles/ViewModele.page.dart'; 
// import 'package:tela/screens/modeles/widgets/rechercheCard.dart';
// import 'package:tela/utiles/colors.dart';

// class SelectProprietyAlert2 extends StatefulWidget {
//   final Function entrerPropriety;
//   // All Propriety
  
//   MyInheritedForViewModeleWidgetState state;
//   SelectProprietyAlert2({
//     Key? key,
//     required this.state,
//     required this.entrerPropriety,
//   }) : super(key: key);
//   @override
//   State<StatefulWidget> createState() => SelectProprietyAlertState();
// }

// class SelectProprietyAlertState extends State<SelectProprietyAlert2>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;
//   late Animation<double> scaleAnimation;

//   DatabaseHelper database = DatabaseHelper();

//   String nomSearched = "";

//   // All Propriety
//   List<Propriety> _proprieties = [];
//   List<Propriety> data = [];

//   void getAllPropriety() async {
//     data = await database.listerProprieties();
//     setState(() {
//       setState(() {
//         _proprieties = data;
//         data = _proprieties;
//       });
//     });
//   }

//   Rechercher(String value) {
//     if (nomSearched.trim().isNotEmpty) {
//       setState(() {
//         _proprieties = data
//             .where((propriety) => propriety.name!
//                 .toLowerCase()
//                 .contains(value.toLowerCase().trim()))
//             .toList();
//       });
//     } else {
//       setState(() {
//         _proprieties = data;
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();

//     controller = AnimationController(
//         duration: const Duration(milliseconds: 450), vsync: this);
//     scaleAnimation =
//         CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

//     controller.addListener(() {
//       setState(() {});
//     });

//     controller.forward();

//     getAllPropriety();
//   }

//   @override
//   void dispose() {
//     // Additional disposal code

//     super.dispose();
//   }

//   /* Widget actionChips(Propriety propriety) {
//     return ActionChip(
//       elevation: 6.0,
//       padding: EdgeInsets.all(2.0), backgroundColor: Colors.white,  shape: StadiumBorder(
//           side: BorderSide(
//         width: 1,
//         color: Colors.blueAccent,
//       )),
//       avatar: CircleAvatar(
//         backgroundColor: Colors.green[60],
//         child: Icon(Icons.call),
//       ),
//       label: Text("${propriety.name!}"),
//       onPressed: () => widget.state.selectPropriety(propriety),
     
    
//     );
//   }
// */

//   Widget inputChip(Propriety propriety, bool _isSelected) {
//     return InputChip(
//       elevation: 6.0,
//       padding: EdgeInsets.all(2.0),
//       avatar: Icon(
//         Icons.attach_file_sharp,
//         color: Colors.blue.shade600,
//       ),
//       backgroundColor: Colors.white,
//       shape: StadiumBorder(
//           side: BorderSide(
//         width: 1,
//         color: Colors.blueAccent,
//       )),
//       label: Text("${propriety.name!}"),
//       selectedColor: Colors.green,
//       selected: _isSelected,
//       onPressed: () {
//         setState(() {
//           _isSelected = !_isSelected;
//         });
//       },
//     );
//   }

//   isSelected(String name) {
//     if (widget.state.filters.contains(name)) return true;
//     for (Propriety prop in widget.state.proprieties_selected) {
//       if (prop.name! == name) {
//         return true;
//       }
//     }
//     return false;
//   }

//   @override
//   // ignore: missing_return
//   Widget build(BuildContext context) {
//     // final MyInheritedWidgetState state = MyInheritedWidget.of(context);
//     return Center(
//       child: Material(
//         color: Colors.transparent,
//         child: ScaleTransition(
//             scale: scaleAnimation,
//             child: OrientationBuilder(builder: (context, orientation) {
//               return SingleChildScrollView(
//                 child: Container(
//                   width: orientation == Orientation.portrait
//                       ? MediaQuery.of(context).size.width
//                       : MediaQuery.of(context).size.width * 0.6,
//                   margin: const EdgeInsets.all(20.0),
//                   //padding: const EdgeInsets.all(20.0),
//                   decoration: ShapeDecoration(
//                     color: Colors.white,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0)),
//                     shadows: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.3),
//                         spreadRadius: 3,
//                         blurRadius: 7,
//                         offset: Offset(0, 3), // changes position of shadow
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 10.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Center(
//                               child: Padding(
//                                 padding:
//                                     EdgeInsets.only(top: 10.0, bottom: 10.0),
//                                 child: Text("Selectionner Proprieté",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black)),
//                               ),
//                             ),
//                             IconButton(
//                                 icon: const Icon(
//                                   Icons.cancel_outlined,
//                                 ),
//                                 color: Colors.black,
//                                 onPressed: () {
//                                   widget.state.filters.clear();
//                                   Navigator.pop(context);
//                                 }),
//                           ],
//                         ),
//                       ),
//                       RechercheBar(
//                         onChanged: (String value) {
//                           setState(() {
//                             nomSearched = value;
//                             Rechercher(value);
//                           });
//                         },
//                         onClear: () {
//                           setState(() {
//                             nomSearched = "";
//                             Rechercher("");
//                           });
//                         },
//                       ),
//                       Divider(),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             left: 5.0, right: 5.0, top: 10, bottom: 15.0),
//                         child: _proprieties.isNotEmpty
//                             ? Wrap(
//                                 spacing: 5,
//                                 children:
//                                     List.generate(_proprieties.length, (index) {
//                                   Propriety propriety = _proprieties[index];

//                                   return Padding(
//                                     padding: const EdgeInsets.all(4.0),
//                                     child: FilterChip(
//                                       elevation: 6.0,
//                                       padding: EdgeInsets.all(2.0),
//                                       backgroundColor: Colors.white,
//                                       shape: const StadiumBorder(
//                                           side: BorderSide(
//                                         width: 1,
//                                         color: Colors.blueAccent,
//                                       )),
//                                       showCheckmark: false,
//                                       avatar: CircleAvatar(
//                                         child: isSelected(propriety.name!)
//                                             ? Icon(
//                                                 Icons.check,
//                                               )
//                                             : Text(propriety.name![0]
//                                                 .toUpperCase()),
//                                       ),
//                                       label: Text(propriety.name!),
//                                       selected: isSelected(propriety.name!),
//                                       selectedColor: Colors.green.shade300,
//                                       onSelected: (bool selected) {
//                                         setState(() {
//                                           if (selected == true) {
//                                             widget.state.filters
//                                                 .add(propriety.name!);
//                                             print(
//                                                 "_filters ici2 :${widget.state.filters.length}");
//                                           } else {
//                                             widget.state.filters
//                                                 .removeWhere((String name) {
//                                               return name == propriety.name!;
//                                             });
//                                             print(
//                                                 "_filters ici1 :${widget.state.filters.length}");
//                                           }
//                                         });
//                                       },
//                                     ),
//                                   );
//                                 }),
//                               )
//                             : const Text(
//                                 "Aucune Proprieté",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black),
//                               ),
//                       ),
//                       Divider(),
//                       SizedBox(height: 20),
//                       Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 10),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       widget.entrerPropriety();
//                                       widget.state.getProprietiesSelected();
//                                       getAllPropriety();
//                                     });
                                    
//                                   },
//                                   child: Text("Créer Proprieté",
//                                       style: TextStyle(color: Colors.white)),
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.blue,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 15),
//                               Expanded(
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     print('yes selected');
//                                     //widget.state.proprieties_selected = [];
//                                     widget.state.filters.forEach((name) {
//                                       bool exist = false;
//                                       widget.state.proprieties_selected
//                                           .forEach((prop) {
//                                         if (prop.name! == name) {
//                                           setState(() {
//                                             exist = true;
//                                           });
//                                         }
//                                       });
//                                       if (exist == false) {
//                                         setState(() {
//                                           widget.state.proprieties_selected.add(
//                                               Propriety(name: name, value: ""));
//                                         });
//                                       }
//                                     });
//                                     setState(() {
//                                       widget.state.getProprietiesSelected();
//                                       widget.state.filters = [];
//                                     });

//                                     Navigator.of(context).pop();
//                                   },
//                                   child: Text("Ajouter",
//                                       style: TextStyle(color: Colors.black)),
//                                   style: ElevatedButton.styleFrom(
//                                       primary: Colors.white),
//                                 ),
//                               ),
//                             ],
//                           )),
//                     ],
//                   ),
//                 ),
//               );
//             })),
//       ),
//     );
//   }
// }
