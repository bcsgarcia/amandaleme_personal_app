import 'package:amandaleme_personal_app/app/theme/light_theme.dart';
import 'package:flutter/material.dart';

class HowToTakePictureScreen extends StatelessWidget {
  const HowToTakePictureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 30),
        Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: IconButton(
                  icon: const Icon(
                    Icons.chevron_left_rounded,
                    size: 30,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(right: 60.0),
                child: Text(
                  'Para uma boa análise postural, por favor, siga estes passos:',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 29),
        const HowTakePictureItem(
          index: '1',
          description: 'O local precisa estar bem iluminado;',
        ),
        const HowTakePictureItem(
          index: '2',
          description:
              'Peça a quem for fotografar que se coloque rigorosamente perpendicular a você, e a câmera a altura da boca do estômago;',
        ),
        const HowTakePictureItem(
          index: '3',
          description:
              'Enquadre todo o corpo para que nenhuma parte seja cortada;',
        ),
        const HowTakePictureItem(
          height: 168,
          index: '4',
          description:
              'As fotos deverão sempre serem feitas e repetidas com a mesma roupa: \n- Meninas: short curto e colado ao corpo, ou biquíni completo, ou top de alcinha sem cruzar atrás (que permitam a visualização do meio das costas)\n- Meninos: sunga de praia;',
        ),
        const HowTakePictureItem(
          index: '5',
          description: 'Esteja descalço(a);',
        ),
        const HowTakePictureItem(
          index: '6',
          description:
              'Em casos de cabelos longos, fazer um coque para não atrapalhar a visualização das costas.',
        ),
        const SizedBox(height: 20),
        const Divider(),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Importante:',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              const SizedBox(height: 10),
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 16,
                        color: Colors.black,
                        height: 1.5,
                      ),
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'Caso as fotos sejam para ',
                    ),
                    TextSpan(
                      text: 'preparação competitiva',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                    ),
                    const TextSpan(
                      text:
                          ', use sempre o mesmo biquíni (colocando as alças laterais altas a altura das espinhas ilíacas) e nas fotos de costas, retire a parte de cima.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

class HowTakePictureItem extends StatelessWidget {
  const HowTakePictureItem({
    super.key,
    required this.index,
    required this.description,
    this.height,
  });

  final String index;
  final String description;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Row(
        children: [
          SizedBox(
            height: height,
            child: Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                backgroundColor: secondaryColor,
                child: Text(
                  index,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            flex: 4,
            child: Text(
              description,
              textAlign: TextAlign.justify,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 16, color: Colors.black, height: 1.5),
            ),
          )
        ],
      ),
    );
  }
}
