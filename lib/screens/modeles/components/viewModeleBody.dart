// import 'dart:io';

// import 'package:atelier_so/core/modeles/data_modeles/modele/modele.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:tela/functions/randomString.dart';
// import 'package:tela/helper/dbHelper.dart';
// import 'package:tela/models/modele/Modele.dart';
// import 'package:tela/models/modele/modeleDeBase.dart';
// import 'package:tela/models/propriety.dart';
// import 'package:tela/screens/modeles/ViewModele.page.dart';
// import 'package:tela/screens/modeles/widgets/selecteProprietyAlert2.dart';
// import 'package:tela/widgets/Les_Alerts/askToDeleteModele.dart';
// import 'package:tela/widgets/loading.dart';

// class ViewModeleBody extends StatefulWidget {
//   final Function press;
//   Modele leModele;
//   ViewModeleBody({
//     Key? key,
//     required this.press,
//     required this.leModele,
//   });

//   @override
//   State<ViewModeleBody> createState() => _ViewModeleBodyState();
// }

// class _ViewModeleBodyState extends State<ViewModeleBody> {
//   File? imgFile;
//   String? image;
//   final imgPicker = ImagePicker();
//   String? fileName;
//   bool enable = false;

//   DatabaseHelper database = DatabaseHelper();

//   List<Propriety> Propieties = <Propriety>[];

//   final _formKey2 = GlobalKey<FormState>();
//   final TextEditingController nameCtrl = TextEditingController();

//   InitierAllData() {
//     setState(() {
//       enable = false;
//       nameCtrl.text = widget.leModele.modeleInfo!.name!;
//       if (widget.leModele.modeleInfo!.imgPath!.contains("assets/images/")) {
//         setState(() {
//           image = widget.leModele.modeleInfo!.imgPath!;
//         });
//       } else {
//         setState(() {
//           imgFile = File(widget.leModele.modeleInfo!.imgPath!);
//         });
//       }
//     });
//     print("porprietés:${widget.leModele.proprieties}");
//   }

//   Annuler() {
//     InitierAllData();
//   }

//   addPropriety(BuildContext context) {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           final _formKey = GlobalKey<FormState>();
//           final TextEditingController mesureItemCtrl = TextEditingController();
//           return AlertDialog(
//             scrollable: true,
//             title: const Text('Ajouter une Proprieté'),
//             content: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: <Widget>[
//                     TextFormField(
//                       controller: mesureItemCtrl,
//                       decoration: const InputDecoration(
//                         labelText: 'Nom',
//                         icon: Icon(
//                           Icons.input,
//                         ),
//                       ),
//                       validator: (text) {
//                         if (text!.isEmpty) {
//                           return 'Requis!';
//                         } else {
//                           return null;
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('Annuler'),
//               ),
//               TextButton(
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     // TODO submit
//                     LoadingDialog.show(context);
//                     final String nom = mesureItemCtrl.text;

//                     // Insert a new journal to the database

//                     await database
//                         .ajouterPropriety(Propriety(name: nom, value: ""))
//                         .then((value) {
//                       if (value != 0) {
//                         LoadingDialog.hide(context);
//                         ScaffoldMessenger.of(context)
//                             .showSnackBar(const SnackBar(
//                           content: Text('Proprieté ajoutée'),
//                           backgroundColor: Colors.green,
//                         ));
//                         getAllPropriety();

//                         Navigator.pop(context);
//                       } else {
//                         LoadingDialog.hide(context);
//                         ScaffoldMessenger.of(context)
//                             .showSnackBar(const SnackBar(
//                           content: Text('Erruer! Veuillez réessayer'),
//                           backgroundColor: Colors.red,
//                         ));
//                       }
//                     }).catchError((err) {
//                       LoadingDialog.hide(context);
//                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                         content: Text('Erruer! Veuillez réessayer'),
//                         backgroundColor: Colors.red,
//                       ));
//                     });
//                     setState(() {
//                       getAllPropriety();
//                     });
//                     Navigator.pop(context);
//                   }
//                 },
//                 child: const Text('Ajouter'),
//               ),
//             ],
//           );
//         });
//   }

//   void getAllPropriety() async {
//     final List<Propriety> data = await database.listerProprieties();
//     setState(() {
//       setState(() {
//         Propieties = data;
//         print("All client: $data");
//       });
//     });
//   }

//   SelectPropriety(
//       BuildContext context, MyInheritedForViewModeleWidgetState state) {
//     return showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (_) => SelectProprietyAlert2(
//         entrerPropriety: (() => setState(() {
//               addPropriety(context);
//             })),
//         state: state,
//       ),
//     );
//   }

//   void openCamera() async {
//     var imgCamera = await imgPicker.pickImage(source: ImageSource.camera);
//     setState(() {
//       image = null;
//       imgFile = File(imgCamera!.path);
//       fileName = imgCamera.name;
//     });
//   }

//   void openGallery() async {
//     var imgGallery = await imgPicker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       image = null;
//       imgFile = File(imgGallery!.path);
//       fileName = imgGallery.name;
//     });
//   }

//   List<String> images = [
//     "assets/images/modele/m1.png",
//     "assets/images/modele/m2.png",
//     "assets/images/modele/m3.png",
//     "assets/images/modele/m4.png",
//     "assets/images/modele/m5.png",
//     "assets/images/modele/m6.png",
//     "assets/images/modele/m7.png",
//     "assets/images/modele/m8.png",
//     "assets/images/modele/m9.png",
//   ];
//   choisirIcones(String img) {
//     setState(() {
//       image = img;
//       isChoice(img);
//     });
//     // change();
//   }

//   isChoice(String img) {
//     if (img == image) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   choisirImage() {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           final _formKey = GlobalKey<FormState>();
//           final TextEditingController mesureItemCtrl = TextEditingController();
//           return AlertDialog(
//             scrollable: true,
//             title: const Text('Utiliser une Icon'),
//             content: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//                   child: Container(
//                     height: 300,
//                     child: GridView.builder(
//                       gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                           maxCrossAxisExtent: 80,
//                           mainAxisExtent: 80,
//                           childAspectRatio: 1,
//                           crossAxisSpacing: 5,
//                           mainAxisSpacing: 5),
//                       itemCount: images.length,
//                       itemBuilder: (BuildContext ctx, index) {
//                         final item = images[index];
//                         return GestureDetector(
//                           onTap: () => setState(() {
//                             choisirIcones(item);
//                             Navigator.pop(context);
//                           }),
//                           child: Container(
//                             width: double.infinity,
//                             child: Card(
//                               clipBehavior: Clip.antiAlias,
//                               color:
//                                   isChoice(item) ? Colors.blue : Colors.white,
//                               elevation: 5.0,
//                               shadowColor: Colors.lightBlueAccent.shade100,
//                               child: Image.asset(
//                                 item,
//                                 color:
//                                     isChoice(item) ? Colors.white : Colors.blue,
//                                 fit: BoxFit.contain,
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 )
//               ]),
//             ),
//           );
//         });
//   }

//   void modifierModele(MyInheritedForViewModeleWidgetState state) async {
//     LoadingDialog.show(context);
//     // Step 2: Check for valid file
//     if (imgFile == null && image == null) {
//       LoadingDialog.hide(context);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: const Text(
//           'Erreur! Veuillez ajouter d\'image au modele',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.grey.shade900,
//       ));
//       return;
//     }
//     if (!_formKey2.currentState!.validate()) {
//       LoadingDialog.hide(context);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: const Text(
//           'Erreur! Veuillez ajouter un nom au modele',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.grey.shade900,
//       ));
//       return;
//     }
//     if (state.proprieties_selected.isEmpty) {
//       LoadingDialog.hide(context);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: const Text(
//           'Erreur! Veuillez ajouter des proprietés au modele',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.grey.shade900,
//       ));
//       return;
//     }

// // Step 3: Get directory where we can duplicate selected file.
//     final Directory directory = await getApplicationDocumentsDirectory();

// // Step 4: Copy the file to a application document directory.
//     /*final String dossierName = generateRandomString(10);
//     Directory('${directory.path}/tela/modeles/$dossierName')
//         .create(recursive: true);*/
//     File localImage;
//     if (image != null) {
//       localImage = File(image!);
//     } else {
//       localImage = imgFile!.path != widget.leModele.modeleInfo!.imgPath
//           ? await imgFile!.copy('${directory.path}/tela/modeles/$fileName')
//           : File(widget.leModele.modeleInfo!.imgPath!);
//     }
//     // TODO submit
//     setState(() {
//       final String nom = nameCtrl.text;
//     });
//     database.ModifierModele(Modele(
//             modeleInfo: modele(
//                 id: widget.leModele.modeleInfo!.id,
//                 imgPath: localImage.path,
//                 name: nameCtrl.text),
//             proprieties: state.proprieties_selected))
//         .then((value) {
//       LoadingDialog.hide(context);
//       if (value["ok"]) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(
//             value["message"],
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Colors.green,
//         ));
//         setState(() {
//           widget.press();
//         });
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(
//             value["message"],
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Colors.red,
//         ));
//       }
//     }).catchError((err) {
//       LoadingDialog.hide(context);
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text(
//           'Erreur! Veuillez réessayer',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.red,
//       ));
//     });
//     LoadingDialog.hide(context);
//     //Navigator.pop(context);
//     setState(() {
//       widget.press();
//     });

//     Navigator.pop(context);
//   }

//   Widget displayImage() {
//     if (imgFile == null && image == null) {
//       return Container(
//         width: 140.0,
//         height: 140.0,
//         decoration: const BoxDecoration(
//           shape: BoxShape.rectangle,
//           image: DecorationImage(
//             image: ExactAssetImage('assets/images/modele.png'),
//             fit: BoxFit.cover,
//           ),
//         ),
//       );
//     } else {
//       return image != null
//           ? Container(
//               height: 200,
//               width: MediaQuery.of(context).size.width * 0.7,
//               decoration: BoxDecoration(
//                   shape: BoxShape.rectangle,
//                   borderRadius: BorderRadius.circular(8.0),
//                   border: Border.all(color: Colors.blue, width: 2),
//                   color: Colors.white),
//               padding: EdgeInsets.all(2),
//               child: Image.asset(
//                 image!,
//                 color: Colors.blue,
//                 fit: BoxFit.contain,
//               ),
//             )
//           : Container(
//               height: 200,
//               width: MediaQuery.of(context).size.width * 0.7,
//               decoration: BoxDecoration(
//                   shape: BoxShape.rectangle,
//                   borderRadius: BorderRadius.circular(8.0),
//                   border: Border.all(color: Colors.blue, width: 2),
//                   color: Colors.white),
//               padding: EdgeInsets.all(2),
//               child: Image(
//                 image: FileImage(imgFile!),
//                 fit: BoxFit.contain,
//                 loadingBuilder: (context, child, loadingProgress) {
//                   if (loadingProgress == null) {
//                     debugPrint('image loading null');
//                     return child;
//                   }
//                   debugPrint('image loading...');
//                   return const Center(child: CircularProgressIndicator());
//                 },
//               ));
//     }
//   }

//   supprimerModele() async {
//     LoadingDialog.show(context);
//     database.supprimer_modele(widget.leModele.modeleInfo!.id!).then((value) {
//       LoadingDialog.hide(context);

//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text(
//           "SuppressionOk!",
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.green,
//       ));
//     }).catchError((err) {
//       LoadingDialog.hide(context);
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text(
//           'Erreur! Veuillez réessayer',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.red,
//       ));
//     });
//     setState(() {
//       widget.press();
//     });
//     Navigator.pop(context);
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     getAllPropriety();
//     InitierAllData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final MyInheritedForViewModeleWidgetState state =
//         MyInheritedForViewModeleWidget.of(context);
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             widget.leModele.modeleInfo!.name!,
//             overflow: TextOverflow.ellipsis,
//             maxLines: 1,
//             softWrap: false,
//             style: TextStyle(color: Colors.black),
//           ),
//           iconTheme: IconThemeData(color: Colors.black),
//           centerTitle: true,
//           backgroundColor: Colors.white,
//           elevation: 0.0,
//           actions: [
//             // saveModele(state);
//             !enable
//                 ? IconButton(
//                     icon: const Icon(
//                       Icons.delete_forever_outlined,
//                       color: Colors.red,
//                     ),
//                     color: Colors.black,
//                     onPressed: () async {
//                       print("ici4");
//                       showDialog(
//                         context: context,
//                         builder: (_) => AskToDeleteModeleAlert(
//                           nomModele: widget.leModele.modeleInfo!.name!,
//                           buttonHandler: (() => supprimerModele()),
//                         ),
//                       );
//                       // Navigator.pop(context);
//                       setState(() {});
//                     })
//                 : const Text(""),
//           ],
//         ),
//         body:
//             enable ? bodyToEdite(state, context) : bodyToShow(state, context));
//   }

//   Widget bodyToShow(
//           MyInheritedForViewModeleWidgetState state, BuildContext context) =>
//       SingleChildScrollView(
//         child: Form(
//           key: _formKey2,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(height: 10),
//               displayImage(),
//               SizedBox(height: 20),

//               /////////////////////Add name //////////////////////
//               Row(
//                 children: <Widget>[
//                   const Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 15),
//                       child: Divider(
//                         height: 1,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     color: Colors.transparent,
//                     child: const Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 5,
//                         vertical: 8,
//                       ),
//                       child: Text(
//                         "Information",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontFamily: 'Speedee',
//                           fontSize: 14,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const Expanded(
//                       child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 15),
//                     child: Divider(
//                       height: 1,
//                       color: Colors.black,
//                     ),
//                   )),
//                 ],
//               ),
//               ////////////////////////////////////////////////////
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
//                 child: Center(
//                   child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           "Nom du modèle :",
//                           style: TextStyle(
//                               fontSize: 16.0, fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           nameCtrl.text,
//                           style: TextStyle(
//                               fontSize: 16.0, fontWeight: FontWeight.bold),
//                         ),
//                       ]),
//                 ),
//               ),
//               ////////////////////////////////////////////////////
//               Row(
//                 children: <Widget>[
//                   const Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 15),
//                       child: Divider(
//                         height: 1,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     color: Colors.transparent,
//                     child: const Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 5,
//                         vertical: 8,
//                       ),
//                       child: Text(
//                         "Les mesures",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontFamily: 'Speedee',
//                           fontSize: 14,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const Expanded(
//                       child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 15),
//                     child: Divider(
//                       height: 1,
//                       color: Colors.black,
//                     ),
//                   )),
//                 ],
//               ),
//               Padding(
//                 padding: EdgeInsets.only(
//                     left: 5.0, right: 5.0, top: 10, bottom: 15.0),
//                 child: Wrap(
//                   spacing: 5,
//                   children:
//                       List.generate(state.proprieties_selected.length, (index) {
//                     Propriety propiety = state.proprieties_selected[index];
//                     print("propiety: $propiety");
//                     /* state.proprieties_selected = widget.leModele.proprieties;

//                     setState(() {
//                       state.filters = [];
//                     });*/
//                     return state.inputChipsView(propiety, index);
//                   }),
//                 ),
//               ),
//               //Add button
//               ElevatedButton.icon(
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green.shade400),
//                 onPressed: () => setState(() {
//                   enable = true;
//                 }),
//                 label: const Text('Modifier les données'),
//                 icon: const Icon(Icons.mode_edit_outline_outlined),
//               ),
//             ],
//           ),
//         ),
//       );

//   Widget bodyToEdite(
//           MyInheritedForViewModeleWidgetState state, BuildContext context) =>
//       SingleChildScrollView(
//         child: Form(
//           key: _formKey2,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               SizedBox(height: 10),
//               displayImage(),
//               SizedBox(height: 20),
//               Wrap(
//                 alignment: WrapAlignment.center,
//                 children: [
//                   ElevatedButton.icon(
//                     onPressed: () => openGallery(),
//                     label: const Text('Choisir Image'),
//                     icon: const Icon(Icons.image),
//                   ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   ElevatedButton.icon(
//                     onPressed: () => choisirImage(),
//                     label: const Text('Utiliser Icons'),
//                     icon: const Icon(Icons.art_track_rounded),
//                   ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   ElevatedButton.icon(
//                     onPressed: () => openCamera(),
//                     label: const Text('Prendre Photo'),
//                     icon: const Icon(Icons.camera_alt_outlined),
//                   ),
//                 ],
//               ),
//               /////////////////////Add name //////////////////////
//               Row(
//                 children: <Widget>[
//                   const Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 15),
//                       child: Divider(
//                         height: 1,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     color: Colors.transparent,
//                     child: const Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 5,
//                         vertical: 8,
//                       ),
//                       child: Text(
//                         "Information",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontFamily: 'Speedee',
//                           fontSize: 14,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const Expanded(
//                       child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 15),
//                     child: Divider(
//                       height: 1,
//                       color: Colors.black,
//                     ),
//                   )),
//                 ],
//               ),
//               ////////////////////////////////////////////////////
//               Container(
//                 width: 300,
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Nom du modèle",
//                         style: TextStyle(
//                             fontSize: 16.0, fontWeight: FontWeight.bold),
//                       ),
//                       TextFormField(
//                         key: widget.key,
//                         keyboardType: TextInputType.text,
//                         controller: nameCtrl,
//                         decoration:
//                             const InputDecoration(hintText: "Entrer le nom..."),
//                         validator: (text) {
//                           if (text!.isEmpty) {
//                             return 'Requis!';
//                           } else {
//                             return null;
//                           }
//                         },
//                       ),
//                     ]),
//               ),
//               ////////////////////////////////////////////////////
//               Row(
//                 children: <Widget>[
//                   const Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 15),
//                       child: Divider(
//                         height: 1,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     color: Colors.transparent,
//                     child: const Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 5,
//                         vertical: 8,
//                       ),
//                       child: Text(
//                         "Les mesures",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontFamily: 'Speedee',
//                           fontSize: 14,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const Expanded(
//                       child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 15),
//                     child: Divider(
//                       height: 1,
//                       color: Colors.black,
//                     ),
//                   )),
//                 ],
//               ),
//               Padding(
//                 padding: EdgeInsets.only(
//                     left: 5.0, right: 5.0, top: 10, bottom: 15.0),
//                 child: Wrap(
//                   spacing: 5,
//                   children:
//                       List.generate(state.proprieties_selected.length, (index) {
//                     Propriety propiety = state.proprieties_selected[index];
//                     return state.inputChips(propiety, index);
//                   }),
//                 ),
//               ),
//               //Add button
//               ElevatedButton.icon(
//                 onPressed: () => SelectPropriety(context, state),
//                 label: const Text('Ajouter Proprieté'),
//                 icon: const Icon(Icons.add_circle_outline),
//               ),
//               SizedBox(height: 20),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           print('yes selected');
//                           Annuler();
//                         },
//                         child: Text("Annuler",
//                             style: TextStyle(color: Colors.white)),
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.red.shade400),
//                       ),
//                     ),
//                     SizedBox(width: 15),
//                     Expanded(
//                         child: ElevatedButton(
//                       onPressed: () {
//                         modifierModele(state);
//                         // Navigator.of(context).pop();
//                       },
//                       child: Text("Sauvegarder",
//                           style: TextStyle(color: Colors.white)),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green.shade400,
//                       ),
//                     ))
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
// }
