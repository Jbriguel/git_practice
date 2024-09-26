import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:flutter/material.dart';

class NoProprietyFound extends StatelessWidget {
  const NoProprietyFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CustomImageView(
            fit: BoxFit.contain,
            imagePath: Images.folder,
            height: 50,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Text(
              "Aucune propriété trouvée",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Speedee',
                color: ThemeColors.greyDeep,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
