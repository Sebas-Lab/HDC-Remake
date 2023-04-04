import './home_screen_dependencies.dart';

Widget buildChangeVersion (BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(top: 20, left: 30),
    width: MediaQuery.of(context).size.width * 0.8,
    child: Align(
      alignment: Alignment.centerLeft,
      child: ElevatedButton(
        onPressed: () {
          print('Cambiar version');
        },
        style: ElevatedButton.styleFrom(
          primary: const Color(0XFFf72585),
          padding: const EdgeInsets.only(top: 13, bottom: 13, right: 20, left: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        child: const Text(
          'Cambiar versión',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    )
  );
}