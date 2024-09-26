import 'package:atelier_so/core/repository/userRepositories/user_repository.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/screens/dashboard/controllers/MenuController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../responsive.dart';
// import '../../../controllers/MenuController.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: ThemeColors.greyDeep,
              ),
              onPressed: () {
                Navigator.pop(context);
              } //context.read<DashMenuController>().controlMenu,
              ),
        // if (!Responsive.isMobile(context))
        Text(
          "Dashboard",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Spacer(),
        // if (!Responsive.isMobile(context))
        //   Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        // Expanded(child: SearchField()),
        ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserRepository>(
      builder: (context, userRepo, child) => Container(
        margin: EdgeInsets.only(left: defaultPadding),
        padding: EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: ThemeColors.redOrange.withOpacity(0.2),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white),
        ),
        child: Row(children: [
          Image.asset(
            Images.afro_man_avatar,
            height: 38,
          ),
          if (!Responsive.isMobile(context))
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text(
                userRepo.user?.name ?? '---',
                style: TextStyle(color: Colors.black),
              ),
            ),
          const Icon(
            Icons.keyboard_arrow_down,
            color: ThemeColors.greyDeep,
          ),
        ]),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: ThemeColors.redOrange.withOpacity(0.2),
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: ThemeColors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset(
              "ressources/images/icons/dashboard/Search.svg",
              color: ThemeColors.redOrange,
            ),
          ),
        ),
      ),
    );
  }
}
