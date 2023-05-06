import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

class BuildInformationScreenBody extends StatefulWidget {
  const BuildInformationScreenBody({Key? key}) : super(key: key);

  @override
  State<BuildInformationScreenBody> createState() => BuildInformationScreenBodyState();
}

class BuildInformationScreenBodyState extends State<BuildInformationScreenBody> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          width:  double.infinity,
          margin: EdgeInsets.only(left: 25, right: 25, top: MediaQuery.of(context).size.height * 0.06, bottom: 50),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  '¿Propósito?',
                  style: TextStyle(
                    height: 1.5,
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'El propósito de esta aplicación es ser una herramienta de ayuda para la alabanza y adoración a nuestro Señor.',
                  style: TextStyle(
                    height: 1.5,
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                alignment: Alignment.centerLeft,
                child: const Text(
                  '¿Donde se creó esta herramienta?',
                  style: TextStyle(
                    height: 1.5,
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Esta herramienta fué desarrollada por hermanos de la Iglesia de Cristo en Alajuela.',
                  style: TextStyle(
                    height: 1.5,
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                alignment: Alignment.centerLeft,
                child: const Text(
                  '¿Cómo contactarnos?',
                  style: TextStyle(
                    height: 1.5,
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Si tienes alguna duda, sugerencia o comentario, puedes escribirnos a nuestro correo electrónico:',
                  style: TextStyle(
                    height: 1.5,
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'bibliayopinion@gmail.com',
                  style: TextStyle(
                    height: 1.5,
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}