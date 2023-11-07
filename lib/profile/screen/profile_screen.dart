import 'package:amandaleme_personal_app/app/theme/light_theme.dart';
import 'package:amandaleme_personal_app/profile/change_pass_page.dart';
import 'package:amandaleme_personal_app/profile/screen/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

import '../../app/common_widgets/common_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  final UserModel userModel;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel get _userModel => widget.userModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final firstName = _userModel.name.split(' ').first;
    final lastName = _userModel.name.split(' ').last;

    final firstLetter = firstName.substring(0, 1).toUpperCase();
    final fristLetterLastName = lastName.substring(0, 1).toUpperCase();

    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppHeaderWithTitleLeadinAndAction(
          title: 'Perfil',
          leadingButton: IconButton(
            icon: const Icon(
              Icons.chevron_left_rounded,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        const SizedBox(height: 48),
        _userModel.photoUrl?.isEmpty == true
            ? CircleWithInitialLetters(
                size: 95,
                initialLetters: '$firstLetter$fristLetterLastName',
              )
            : CicleImageWithIconCan(photoUrl: _userModel.photoUrl),
        const SizedBox(height: 13),
        Text(
          '$firstName $lastName',
          style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold, fontSize: 23),
        ),
        const SizedBox(height: 22),
        const Divider(),
        const SizedBox(height: 10),
        buildItem('Nome', _userModel.name),
        const SizedBox(height: 10),
        buildItem('E-mail', _userModel.email),
        const SizedBox(height: 10),
        buildItem('Contato', _userModel.phone ?? ''),
        const SizedBox(height: 10),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              style: ButtonStyle(
                alignment: Alignment.centerRight,
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.zero,
                ),
              ),
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordPage())),
              child: Text(
                'Alterar senha',
                style: textTheme.bodyLarge!.copyWith(
                  fontSize: 16,
                  color: secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildItem(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 35,
              child: Text(
                key,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: SizedBox(
              height: 35,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 16,
                        ),
                  ),
                  const Divider(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
