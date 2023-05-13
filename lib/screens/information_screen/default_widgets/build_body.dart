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
                child: Text(
                  '¿Propósito?',
                  style: TextStyle(
                    height: 1.5,
                    color: getTextColors(context),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                alignment: Alignment.centerLeft,
                child: Text(
                  'El propósito de esta aplicación es ser una herramienta de ayuda para la alabanza y adoración a nuestro Señor.',
                  style: TextStyle(
                    height: 1.5,
                    color: getTextColors(context),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                alignment: Alignment.centerLeft,
                child: Text(
                  '¿Donde se creó esta herramienta?',
                  style: TextStyle(
                    height: 1.5,
                    color: getTextColors(context),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Esta herramienta fué desarrollada por hermanos de la Iglesia de Cristo en Alajuela, Costa Rica.',
                  style: TextStyle(
                    height: 1.5,
                    color: getTextColors(context),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                alignment: Alignment.centerLeft,
                child: Text(
                  '¿Cómo contactarnos?',
                  style: TextStyle(
                    height: 1.5,
                    color: getTextColors(context),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Si tiene alguna duda, sugerencia o comentario, puede escribirnos a nuestro correo electrónico:',
                  style: TextStyle(
                    height: 1.5,
                    color: getTextColors(context),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: getButtonColors(context),
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                    elevation: 15,
                  ),
                  onPressed: () {},
                  child: Text(
                    'bibliayopinion@gmail.com',
                    style: TextStyle(
                      height: 1.5,
                      color: getTextColors(context),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
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

Color getButtonColors(BuildContext context) {

  var themeData = Theme.of(context);

  if (themeData.primaryColor == AppTheme().oceanTheme.primaryColor) {
    return const Color(0xFF1E3670);
  } else if (themeData.primaryColor == AppTheme().lightTheme.primaryColor) {
    return const Color(0xFFA7B1F1);
  } else if (themeData.primaryColor == AppTheme().darkTheme.primaryColor) {
    return const Color(0xFF3C3C3C);
  }

  return Colors.white;
}

Color getTextColors(BuildContext context) {

  var themeData = Theme.of(context);

  if (themeData.primaryColor == AppTheme().oceanTheme.primaryColor) {
    return Colors.white;
  } else if (themeData.primaryColor == AppTheme().lightTheme.primaryColor) {
    return const Color(0xFF3A3A3A);
  } else if (themeData.primaryColor == AppTheme().darkTheme.primaryColor) {
    return Colors.white;
  }

  return Colors.white;
}