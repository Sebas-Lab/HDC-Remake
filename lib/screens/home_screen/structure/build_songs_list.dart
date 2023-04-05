import '../home_screen_dependencies.dart';

Widget buildSongsList(BuildContext context) {
  return Expanded(
    child: Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 369 - 1,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF1E2A47),
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    shadowColor: Colors.black,
                    elevation: 8,
                  ),
                  onPressed: () {},
                  child: Text(
                    '${index + 1}. - Nombre del himno.',
                    style: const TextStyle(
                      height: 2,
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