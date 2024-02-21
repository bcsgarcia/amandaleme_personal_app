import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../lib.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static Page<void> page() => const MaterialPage<void>(
        child: SplashScreen(),
      );

  @override
  Widget build(BuildContext context) {
    context.read<AppBloc>().add(AppVerifyUser());

    return Scaffold(
      backgroundColor: blackColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 140),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Image.asset('assets/images/logos/logo-black-white.png'),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => context.read<AppBloc>().add(AppVerifyUser()),
              child: const Text('Entrar'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => context.read<AppBloc>().add(const AppLogoutRequested()),
              child: Text(
                'Sair',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
