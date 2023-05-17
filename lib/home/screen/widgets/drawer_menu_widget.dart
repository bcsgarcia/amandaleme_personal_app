import 'package:amandaleme_personal_app/app/bloc/app_bloc.dart';
import 'package:amandaleme_personal_app/company_information/company_information_page.dart';
import 'package:amandaleme_personal_app/partnerships/partnership_page.dart';
import 'package:amandaleme_personal_app/postural_pattern/postural_pattern_page.dart';
import 'package:amandaleme_personal_app/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_repository/home_repository.dart';
import 'package:social_share/social_share.dart';
import 'package:user_repository/user_repository.dart';

class HomeDrawerMenu extends StatelessWidget {
  const HomeDrawerMenu({super.key, required this.drawerScreenModel});

  final DrawerScreenModel drawerScreenModel;

  _goToProfilePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(
          userModel: drawerScreenModel.userModel,
        ),
      ),
    );
  }

  _goToCompanyInformationPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CompanyInformationPage(
          informations: drawerScreenModel.informations,
        ),
      ),
    );
  }

  _goToPosturalPatternPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PosturalPatternPage(
          posturalPatterns: drawerScreenModel.posturalPatterns,
        ),
      ),
    );
  }

  _goToPartnershipPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PartnershipPage(
          partnerships: drawerScreenModel.partnerships,
        ),
      ),
    );
  }

  _logout(BuildContext context) {
    context.read<AppBloc>().add(const AppLogoutRequested());
  }

  shareSocial() {
    SocialShare.shareOptions("texto de share!!");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.3,
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 52),
            child: Column(
              children: [
                PhotoAndNameDrawer(userModel: drawerScreenModel.userModel),
                const SizedBox(height: 40),
                DrawerOption(
                  iconName: 'user',
                  name: 'Perfil',
                  function: () => _goToProfilePage(context),
                ),
                DrawerOption(
                  iconName: 'info',
                  name: 'Informações',
                  function: () => _goToCompanyInformationPage(context),
                ),
                DrawerOption(
                  iconName: 'camera',
                  name: 'Padrões Posturais',
                  function: () => _goToPosturalPatternPage(context),
                ),
                DrawerOption(
                  iconName: 'partnership',
                  name: 'Parcerias',
                  function: () => _goToPartnershipPage(context),
                ),
                DrawerOption(
                  iconName: 'log-out',
                  name: 'Sair',
                  function: () => _logout(context),
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 24),
                DrawerOption(
                  iconName: 'user-plus',
                  name: 'Convide um amigo',
                  function: () => shareSocial(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerOption extends StatelessWidget {
  const DrawerOption({
    super.key,
    required this.iconName,
    required this.name,
    this.function,
  });

  final String iconName;
  final String name;
  final void Function()? function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Image.asset(
              'assets/images/icons/$iconName.png',
              height: iconName == 'partnership' ? 27 : 22,
            ),
            SizedBox(
              width: iconName == 'partnership' ? 9 : 14,
            ),
            Text(
              name,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class PhotoAndNameDrawer extends StatelessWidget {
  const PhotoAndNameDrawer({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 55,
          backgroundImage: NetworkImage(userModel.photoUrl!),
          backgroundColor: Colors.white,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          userModel.name,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
