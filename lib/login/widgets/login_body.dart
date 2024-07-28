import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';

import '../../app/theme/light_theme.dart';
import '../cubit/login_cubit.dart';
import 'widgets.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 170,
            bottom: 0,
            left: 0,
            right: 0,
            child: ListView(
              children: [
                const SizedBox(height: 45),
                Center(
                  child: Text(
                    'Bem vindo!',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 20,
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
          ),
        ],
      ),
    );
  }
}
