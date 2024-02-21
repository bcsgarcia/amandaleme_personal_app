import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../lib.dart';

class SyncMediaScreen extends StatelessWidget {
  const SyncMediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<SyncMediaPageCubit, SyncMadiaPageState>(
        builder: (context, state) {
          final isStateLoading = state.status == SyncPageStatus.loadInProgress;

          if (state.status == SyncPageStatus.loadSuccess) return Container();

          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(
                children: [
                  AnimatedPadding(
                    duration: const Duration(milliseconds: 300),
                    padding: isStateLoading ? const EdgeInsets.only(top: 180) : EdgeInsets.zero,
                    child: Lottie.network(
                      'https://assets4.lottiefiles.com/packages/lf20_o2zkdsfj.json',
                      height: 150,
                    ),
                  ),
                  if (!isStateLoading)
                    Text(
                      'Para avançarmos em direção ao nosso objetivo, por favor, faça o download das mídias do treino. Isso significa que você precisa baixar os arquivos de vídeo e imagens necessários para continuar.\n\nRecomendamos priorizar uma rede Wi-Fi para a conexão e não fechar o aplicativo durante o processo de download. Caso o download não seja feito, você pode não ter acesso aos vídeos dos treinos.',
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: blackColor,
                            height: 1.5,
                            fontSize: 16,
                          ),
                    ),
                  if (!isStateLoading)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 35),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: context.read<SyncMediaPageCubit>().sync,
                        child: const Text('Fazer download'),
                      ),
                    ),
                  if (isStateLoading) const DownloadProgressWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DownloadProgressWidget extends StatelessWidget {
  const DownloadProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<double>(
          stream: context.read<SyncMediaPageCubit>().syncRepository.downloadProgressStream,
          builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              default:
                return Column(
                  children: [
                    LinearProgressIndicator(
                      value: snapshot.data,
                      backgroundColor: const Color(0xffD9D9D9),
                    ),
                    const SizedBox(height: 10),
                    Builder(builder: (context) {
                      final downloadPercentagem = snapshot.data! * 100;

                      return Text(
                        'Realizando download... (${downloadPercentagem.toString().substring(0, 2)}%)',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                      );
                    }),
                  ],
                );
            }
          },
        ),
      ],
    );
  }
}
