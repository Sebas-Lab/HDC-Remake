import './home_screen_dependencies.dart';

Widget buildSongsList(BuildContext context) {
  return Expanded(
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20, bottom: 20, left: 30),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Buscar por título.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 369 - 1,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0XFF3a0ca3),
                  ),
                  onPressed: () {

                  },
                  child: Text(
                    '${index + 1}. - Nombre del himno.',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}