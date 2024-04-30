import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';
import 'package:social_share/social_share.dart';

import '../../lib.dart';

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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 52),
            child: Column(
              children: [
                BlocBuilder<PhotoDrawerCubit, PhotoDrawerState>(
                  builder: (context, state) {
                    return PhotoAndNameDrawer(userModel: drawerScreenModel.userModel);
                  },
                ),
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
                // DrawerOption(
                //   iconName: 'partnership',
                //   name: 'Parcerias',
                //   function: () => _goToPartnershipPage(context),
                // ),
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
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: Colors.transparent, // Define o fundo como transparente.
          child: InkWell(
            splashColor: Colors.orange.withOpacity(0.8), // Aqui você pode personalizar a cor do efeito.
            onTap: function,
            child: Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
              color: Colors.white.withOpacity(0.5),
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
          ),
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
    var photoImage =
        userModel.photoUrl != null ? Image.network(userModel.photoUrl!) : Image.asset('assets/images/icons/user.png');

    return Column(
      children: [
        CircleAvatar(
          radius: 55,
          backgroundImage: photoImage.image,
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
