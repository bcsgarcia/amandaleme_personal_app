import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/theme/light_theme.dart';
import '../../cubit/login_cubit.dart';
import 'widgets.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          const LoginHeader(),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              'Bem vindo!',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          // const SizedBox(
          //   height: 10,
          // ),
          // Center(
          //   child: Text(
          //     'Vamos treinar?',
          //     style: Theme.of(context).textTheme.headlineMedium!.copyWith(
          //           color: blackColor,
          //           fontWeight: FontWeight.bold,
          //         ),
          //   ),
          // ),
          const SizedBox(
            height: 30,
          ),
          BlocProvider(
            create: (_) => LoginCubit(context.read<Authentication>()),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: LoginForm(),
            ),
          ),
        ],
      ),
    );
  }
}
