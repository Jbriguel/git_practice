// import 'package:atelier_so/core/theme/theme_colors.dart';
// import 'package:flutter/material.dart'; 

// const Color3 = Color.fromARGB(255, 18, 40, 70);

// class CustomBottomModalSheet extends StatelessWidget {
//   static void show(BuildContext context,
//           {Key? key, required Widget child, bool isDismissible = true}) =>
//       showModalBottomSheet(
//         enableDrag: true,
//         isScrollControlled: true,
//         isDismissible: isDismissible,
//         context: context,
//         constraints: BoxConstraints.expand(
//             height: MediaQuery.of(context).size.height * 0.9),
//         backgroundColor: Colors.black12,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadiusDirectional.only(
//             topEnd: Radius.circular(15),
//             topStart: Radius.circular(15),
//           ),
//         ),
//         builder: (context) => AnimatedContainer(
//           duration: const Duration(milliseconds: 200),
//           // margin: const EdgeInsets.all(5),
//           decoration: BoxDecoration(
//             color: ThemeColors.blue.withOpacity(0.6),
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(10),
//               topRight: Radius.circular(10),
//             ),
//             boxShadow: [
//               BoxShadow(
//                   color: ThemeColors.blue.withOpacity(0.5),
//                   offset: const Offset(1, 1),
//                   blurRadius: 10,
//                   spreadRadius: 4)
//             ],
//           ),

//           child: AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               margin: const EdgeInsets.only(top: 2),
//               padding: const EdgeInsetsDirectional.symmetric(
//                 horizontal: 5,
//                 vertical: 5,
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(10),
//                   topRight: Radius.circular(10),
//                 ),
//               ),
//               child: Padding(
//                 padding: MediaQuery.of(context).viewInsets,
//                 child: CustomBottomModalSheet(
//                   key: key,
//                   child: child,
//                 ),
//               )),
//         ),
//       ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

//   static void hide(BuildContext context) => Navigator.pop(context);

//   CustomBottomModalSheet({Key? key, required this.child}) : super(key: key);

//   Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
//         //Row(children: [closeIcon(context)]),
//         const SizedBox(
//           height: 20,
//         ),
//         Flexible(child: child)
//       ]),
//     );
//   }
// }

// GestureDetector closeIcon(BuildContext context, {Function? press}) =>
//     GestureDetector(
//       onTap: press != null
//           ? press as void Function()?
//           : () => Navigator.of(context).pop(),
//       child: Container(
//         height: 30,
//         width: 30,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           shape: BoxShape.circle,
//           border: Border.all(width: 1.5, color: Colors.white),
//         ),
//         child: const Center(
//           child: Icon(Icons.close, color: Color3),
//         ),
//       ),
//     );
