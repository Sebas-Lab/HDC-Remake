import 'package:hdc_remake/app_dependencies.dart';

Widget buildQuickInfo() {
  return const Align(
    alignment: Alignment.bottomCenter,
    child: Text(
      'Desarrollado por hermanos de la iglesia de Cristo en Alajuela.',
      textAlign: TextAlign.center,
      style: TextStyle(
        height: 1.8,
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}