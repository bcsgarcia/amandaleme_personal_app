import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../lib.dart';

// ignore: must_be_immutable
class MeetAppScreenContentWidget extends StatelessWidget {
  MeetAppScreenContentWidget({
    super.key,
    required this.onRefresh,
    required this.state,
  }) : contactButtonCubit = ContactButtonCubit();

  final Future<void> Function() onRefresh;
  final MeetAppState state;
  late ContactButtonCubit contactButtonCubit;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
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
            BlocBuilder<ContactButtonCubit, bool>(
              bloc: contactButtonCubit,
              builder: (context, canSendMessage) => canSendMessage
                  ? CallToActionButtonWidget(
                      text: 'Quero treinar com a Amanda',
                      onPressed: contactButtonCubit.sendMessage,
                    )
                  : const SizedBox.shrink(),
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
            BlocBuilder<ContactButtonCubit, bool>(
              bloc: contactButtonCubit,
              builder: (context, canSendMessage) => canSendMessage
                  ? CallToActionButtonWidget(
                      text: 'Quero treinar com a Amanda',
                      onPressed: contactButtonCubit.sendMessage,
                    )
                  : const SizedBox.shrink(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
