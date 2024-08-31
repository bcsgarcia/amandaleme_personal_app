import 'package:amandaleme_personal_app/app/common_widgets/error_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../meet_app.dart';

// ignore: must_be_immutable
class MeetAppScreen extends StatelessWidget {
  const MeetAppScreen({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    if (!context.read<MeetAppCubit>().isClosed) {
      context.read<MeetAppCubit>().retrieveMeetAppScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MeetAppCubit, MeetAppState>(
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
      child: BlocBuilder<MeetAppCubit, MeetAppState>(
        builder: (context, state) {
          if (state.status == MeetAppStatus.inProgress) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: const MeetAppScreenSkeletonLoadingWidget(),
              ),
            );
          }

          return MeetAppScreenContentWidget(
            onRefresh: () => _onRefresh(context),
            state: state,
          );
        },
      ),
    );
  }
}
