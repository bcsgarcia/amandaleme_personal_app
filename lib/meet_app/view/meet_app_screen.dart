import 'package:amandaleme_personal_app/login/view/widgets/widgets.dart';
import 'package:company_repository/company_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/meet_app_cubit.dart';
import 'widgets/widgets.dart';

class MeetAppScreen extends StatefulWidget {
  const MeetAppScreen({super.key});

  @override
  State<MeetAppScreen> createState() => _MeetAppScreenState();
}

class _MeetAppScreenState extends State<MeetAppScreen> {
  late MeetAppCubit _meetAppCubit;

  int activePage = 0;

  @override
  void initState() {
    super.initState();
    _meetAppCubit = MeetAppCubit(context.read<CompanyRepository>());
    _meetAppCubit.retrieveMeetAppScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<MeetAppCubit, MeetAppState>(
        bloc: _meetAppCubit,
        builder: (context, state) {
          if (state.status == MeetAppStatus.inProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.status == MeetAppStatus.success) {
            return ListView(
              children: [
                const LoginHeader(),
                const SizedBox(height: 20),
                AmandaApresentation(
                  aboutCompanyModel: state.screenModel!.aboutCompany,
                ),
                const SizedBox(height: 20),
                Center(
                  child: CompanyVideo(
                    videoUrl: state.screenModel!.aboutCompany.videoUrl,
                  ),
                ),
                const SizedBox(height: 20),
                const CallToActionButton(
                  text: 'Quero treinar com a Amanda',
                ),
                const SizedBox(height: 20),
                MyClassVideo(
                  videoUrl: state.screenModel!.aboutCompany.videoUrl,
                ),
                const SizedBox(height: 20),
                Testimonies(
                  testimonies: state.screenModel!.testemonies,
                ),
                const SizedBox(height: 20),
                ResultsBeforeAndAfter(
                  images: state.screenModel!.photosBeforeAndAfter,
                ),
                const SizedBox(height: 20),
                const CallToActionButton(
                  text: 'Quero treinar com a Amanda',
                ),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}
