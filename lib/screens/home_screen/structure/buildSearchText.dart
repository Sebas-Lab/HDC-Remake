import './home_screen_dependencies.dart';

Widget buildSearchText(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(left: 30, top: 20),
    width: MediaQuery.of(context).size.width * 0.8,
    child: const Text(
      'Buscar himno.',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.white,
      ),
    ),
  );
}