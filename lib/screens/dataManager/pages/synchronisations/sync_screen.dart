import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/screens/dataManager/components/gestion_item.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:atelier_so/widgets/separator.dart';
import 'package:flutter/material.dart';

class SyncScreen extends StatefulWidget {
  const SyncScreen({super.key});

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: ThemeColors.white,
        surfaceTintColor: ThemeColors.white,
        title: const Text(
          'Synchronisations',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w300,
          ),
        ),
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CustomImageView(
                  alignment: Alignment.bottomCenter,
                  imagePath: Images.refresh,
                  fit: BoxFit.contain,
                  width: 200,
                  height: 150,
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text("Synchroniser les données",
                        style: TextStyle(color: ThemeColors.greyDeep)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child: Text(
                    "Attention : La synchronisation peut écraser vos données locales !  \nAssurez-vous d\'être prêt avant de continuer",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: ThemeColors.red,
                        ),
                  ),
                ),
                GestionItemCard(
                  onPress: () {},
                  icon: Icons.sync,
                  couleur: ThemeColors.redOrange,
                  titre: 'Synchroniser vos données',
                  subText: 'Exportez et mettez à jour vos données',
                  // isLocked: userRepo.user?.role != 'manager' &&
                  //     userRepo.user?.role != 'owner',
                ),
              ]),
        ),
      ),
    );
  }
}
