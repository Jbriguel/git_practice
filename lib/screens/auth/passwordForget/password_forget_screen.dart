import 'package:atelier_so/components/cards/option_card.dart';
import 'package:atelier_so/components/default_btn/defaultButton.dart';
import 'package:atelier_so/core/navigations/root_name.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PasswordForgetScreen extends StatefulWidget {
  const PasswordForgetScreen({super.key});

  @override
  State<PasswordForgetScreen> createState() => _PasswordForgetScreenState();
}

class _PasswordForgetScreenState extends State<PasswordForgetScreen> {
  final ScrollController _controller = ScrollController();
  List<OptionCard> _getData() {
    List<OptionCard> list = [
      OptionCard(
          image: Images.question,
          titre: "Demande de renouvellement de mot de passe",
          subText: "---",
          press: () {
            setState(() {});
          }),
      OptionCard(
          image: Images.request,
          titre: "Contacter le service Support pour changer le mot de passe",
          subText: "---",
          press: () {
            setState(() {});
          }),
    ];
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double height = mediaQueryData.size.height;
    final double width = mediaQueryData.size.width;

    return Scaffold(
      backgroundColor: ThemeColors.white,
      // appBar: AppBar(
      //   surfaceTintColor: ThemeColors.white,
      //   backgroundColor: ThemeColors.white,
      //   elevation: 0.2,
      //   automaticallyImplyLeading: false,
      //   centerTitle: true,
      //   title: Text(
      //     "Connexion",
      //     style: GoogleFonts.poppins(
      //       textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
      //           fontWeight: FontWeight.normal, color: ThemeColors.black),
      //     ),
      //   ),
      // ),
      body: OrientationBuilder(builder: (context, orientation) {
        return Container(
          height: height,
          width: orientation == Orientation.portrait ? width : width * 0.7,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Images.init_back_3),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(children: [
            Container(
              color: Colors.black12,
            ),
            Align(
              alignment: Alignment.center,
              child: Card(
                clipBehavior: Clip.antiAlias,
                color: Colors.black.withOpacity(0.2),
                shadowColor: Colors.black38,
                surfaceTintColor: Colors.transparent,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 10.0, vertical: 10.0),
                      //   child: CustomImageView(
                      //     imagePath: Images.logo,
                      //     fit: BoxFit.contain,
                      //     width: 250,
                      //   ),
                      // ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: AutoSizeText(
                          "Mot de passe oublié",
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontFamily: "Speedee",
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: ThemeColors.white),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: AutoSizeText(
                          """Veuillez renseigner les informations pour vous connecter!""",
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style:
                              TextStyle(fontSize: 15, color: ThemeColors.white),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                        child: GridView.builder(
                          controller: _controller,
                          primary: false,
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            // maxCrossAxisExtent: 120,
                            //childAspectRatio: 8 / 9,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 5,
                          ),
                          itemCount: _getData().length,
                          itemBuilder: (BuildContext ctx, index) {
                            OptionCard option = _getData()[index];
                            return Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: option);
                          },
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      DefaultButton(
                          paddingV: 10,
                          fontSize: 14,
                          height: 50,
                          textColor: ThemeColors.greyDeep,
                          backColor: ThemeColors.white,
                          text: "Retour".toUpperCase(),
                          press: () {
                            context.goNamed(RootName.login_view);
                          }),
                      // Or(
                      //   color: ThemeColors.white,
                      // ),
                    ]),
              ),
            )
          ]),
        );
      }),
    );
  }
}
