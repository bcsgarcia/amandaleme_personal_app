import 'package:amandaleme_personal_app/home/cubit/home_cubit.dart';
import 'package:amandaleme_personal_app/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeCubit>().getHomePage();

    return Scaffold(
      body: BlocBuilder<HomeCubit, HomePageState>(
        builder: (context, state) {
          if (state.status == HomePageStatus.loadSuccess) {
            return HomeScreen(homeScreenModel: state.screenModel!);
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
