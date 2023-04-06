import 'package:hdc_remake/app_dependencies.dart';

Widget buildSearchByNumber(BuildContext context, Function(int start, int end) onFilter) {

  final List<String> buttonNames = [
    '1 - 50',
    '51 - 100',
    '101 - 150',
    '151 - 200',
    '201 - 250',
    '251 - 300',
    '301 - 350',
    '351 - 368',
  ];

  return Container(
    height: 160,
    padding: const EdgeInsets.only(left: 5, right: 5),
    margin: const EdgeInsets.only(bottom: 30),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 25, top: 30),
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
        ),
        Container(
          padding: const EdgeInsets.only(top: 5),
          child: const Divider(
            thickness: 1.5,
            color: Color(0xFF3DBAA6),
            indent: 15,
            endIndent: 50,
          ),
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: buttonNames.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Center(
                  child: SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () => onFilter(index * 50 + 1, (index + 1) * 50),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        primary: const Color(0xFF3DBAA6),
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        shadowColor: Colors.black,
                        elevation: 8,
                      ),
                      child: Text(
                        buttonNames[index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF3A3A3A),
                        ),
                      ),
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