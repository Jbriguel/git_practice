// import 'package:atelier_so/core/modeles/data_modeles/modele_base/modelebase.dart';

// extension ModeleBaseConversion on ModeleBase {
//   Map<String, dynamic> toMap() {
//     return {
//       'uid': uid,
//       'imgPath': imgPath,
//       'name': name,
//       'genderType': genderType,
//       'creatorId': creatorId,
//       'createdAt': createdAt.toIso8601String(),
//       'modifiedAt': modifiedAt?.toIso8601String(),
//     };
//   }

  
//   static ModeleBase fromMap(Map<String, dynamic> map) {
//     return ModeleBase((b) => b
//       ..uid = map['uid']
//       ..imgPath = map['imgPath']
//       ..name = map['name']
//       ..genderType = map['genderType']
//       ..creatorId = map['creatorId']
//       ..createdAt = DateTime.parse(map['createdAt'])
//       ..modifiedAt =
//           map['modifiedAt'] != null ? DateTime.parse(map['modifiedAt']) : null);
//   }
// }
