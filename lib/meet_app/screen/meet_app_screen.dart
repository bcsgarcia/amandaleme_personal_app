import 'package:amandaleme_personal_app/app/common_widgets/error_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpers/helpers.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cubit/meet_app_cubit.dart';
import '../widgets/widgets.dart';

class MeetAppScreen extends StatelessWidget {
  const MeetAppScreen({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    if (!context.read<MeetAppCubit>().isClosed) {
      context.read<MeetAppCubit>().retrieveMeetAppScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<MeetAppCubit, MeetAppState>(
        listener: (context, state) {
          if (state.status == MeetAppStatus.failure) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(
                  buttonPressed: () {
                    Navigator.of(context).pop();
                    context.read<MeetAppCubit>().retrieveMeetAppScreen();
                  },
                );
              },
            );
          }
        },
        child: Stack(
          children: [
            Positioned(
              top: 170,
              bottom: 86,
              left: 0,
              right: 0,
              child: BlocBuilder<MeetAppCubit, MeetAppState>(
                builder: (context, state) {
                  if (state.status == MeetAppStatus.inProgress) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: _buildSkeleton(),
                    );
                  }

                  return _buildContent(context, state);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildSkeleton() {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 183,
                  width: 137,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: 40.0,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: 220.0,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: 140.0,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 32.0,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                ),
                Container(
                  width: 200,
                  height: 32.0,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, MeetAppState state) {
    return RefreshIndicator(
      onRefresh: () => _onRefresh(context),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            CompanyPresentationWidget(
              aboutCompanyModel: state.screenModel!.aboutCompany,
            ),
            const SizedBox(height: 20),
            Center(
              child: CompanyVideoWidget(
                videoUrl: state.screenModel!.aboutCompany.videoUrl,
              ),
            ),
            const SizedBox(height: 20),
            CallToActionButtonWidget(
              text: 'Quero treinar com a Amanda',
              onPressed: _queroTreinarButtonPressed,
            ),
            const SizedBox(height: 20),
            MyClassVideoWidget(
              videoUrl: state.screenModel!.aboutCompany.secondVideoUrl,
            ),
            const SizedBox(height: 20),
            TestimoniesWidget(
              testimonies: state.screenModel!.testemonies,
            ),
            const SizedBox(height: 20),
            ResultsBeforeAndAfterWidget(
              images: state.screenModel!.photosBeforeAndAfter,
            ),
            const SizedBox(height: 20),
            CallToActionButtonWidget(
              text: 'Quero treinar com a Amanda',
              onPressed: _queroTreinarButtonPressed,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _queroTreinarButtonPressed() async {
    String message = Uri.encodeComponent("Olá Amanda, gostaria de treinar com você!\n Me mande seus planos!!");
    String whatsappUrlString = "whatsapp://send?phone=${Environment.phoneNumber}&text=$message";

    Uri whatsappUri = Uri.parse(whatsappUrlString);

    try {
      await launchUrl(whatsappUri);
    } catch (_) {
      String emailUrlString = 'mailto:${Environment.email}?subject=Consulta&body=$message';
      Uri emailUri = Uri.parse(emailUrlString);

      await launchUrl(emailUri);
    }
  }
}
