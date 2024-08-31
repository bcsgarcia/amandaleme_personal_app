import 'dart:io';

import 'package:amandaleme_personal_app/profile/cubit/change_photo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repositories/repositories.dart';

import '../../lib.dart';

typedef OnPickImageCallback = void Function(double? maxWidth, double? maxHeight, int? quality);

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.userModel,
  });

  final UserModel userModel;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel get _userModel => widget.userModel;

  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  late ChangePhotoCubit _changePhotoCubit;

  @override
  void initState() {
    super.initState();

    _changePhotoCubit = ChangePhotoCubit(
      userRepository: RepositoryProvider.of<UserRepository>(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final firstName = _userModel.name.split(' ').first;
    final lastName = _userModel.name.split(' ').last;

    final firstLetter = firstName.substring(0, 1).toUpperCase();
    final fristLetterLastName = lastName.substring(0, 1).toUpperCase();

    final textTheme = Theme.of(context).textTheme;

    return BlocListener<ChangePhotoCubit, ChangePhotoState>(
      bloc: _changePhotoCubit,
      listener: (context, state) async {
        if (state.status == ChangePhotoStatusEnum.success) {
          clearImageCache();
          context.read<PhotoDrawerCubit>().updatePhotoDrawer();
        }
      },
      child: BlocBuilder<ChangePhotoCubit, ChangePhotoState>(
        bloc: _changePhotoCubit,
        builder: (context, state) {
          return Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 48),
                // click to change photo
                GestureDetector(
                  onTap: () async {
                    final source = await _pickImage();

                    if (source != null) {
                      final pickedFile = await ImagePicker().pickImage(source: source);
                      if (pickedFile != null) {
                        // ignore: use_build_context_synchronously
                        await _changePhotoCubit.uploadPhoto(File(pickedFile.path));
                      }
                    }
                  },
                  child: _userModel.photoUrl?.isEmpty == true
                      ? CircleWithInitialLettersWidget(
                          size: 95,
                          initialLetters: '$firstLetter$fristLetterLastName',
                        )
                      : CicleImageWithIconCanWidget(photoUrl: _userModel.photoUrl),
                ),

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
                        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
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
            ),
            if (state.status == ChangePhotoStatusEnum.inProgress)
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                bottom: 0,
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
          ]);
        },
      ),
    );
  }

  Future<ImageSource?> _pickImage() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          'Acessar a galeria ou tirar uma foto nova?',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          TextButton(
            child: Text(
              'Camera',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            onPressed: () => Navigator.pop(context, ImageSource.camera),
          ),
          TextButton(
            child: Text(
              'Galeria de fotos',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
          ),
        ],
      ),
    );
  }

  Widget buildItem(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const SizedBox(
            height: 36,
          ),
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
