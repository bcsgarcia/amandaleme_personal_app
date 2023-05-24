import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_cubit/home_cubit.dart';

class DownloadProgressPage extends StatelessWidget {
  const DownloadProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Download Progress'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Download Progress:'),
              StreamBuilder<double>(
                stream: context.read<HomeCubit>().syncRepository.downloadProgressStream,
                builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const CircularProgressIndicator();
                    default:
                      return LinearProgressIndicator(
                        value: snapshot.data,
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
