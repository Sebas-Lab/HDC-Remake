import './home_screen_dependencies.dart';

Widget buildSearchByNumberText() {
  return Container(
    padding: const EdgeInsets.only(left: 30, top: 20),
    child: const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Buscar por número.',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    ),
  );
}