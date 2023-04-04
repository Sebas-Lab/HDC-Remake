import 'package:hdc_remake/app_dependencies.dart';

import './home_screen_dependencies.dart';

Widget buildSearchByNumber() {

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
    height: 120,
    padding: const EdgeInsets.only(left: 5, right: 5),
    child: Column(
      children: [
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: buttonNames.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.only(left: 20),
                child: Center(
                  child: Container(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        primary: const Color(0xFFf72585),
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      child: Text(
                        buttonNames[index],
                        textAlign: TextAlign.center,
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