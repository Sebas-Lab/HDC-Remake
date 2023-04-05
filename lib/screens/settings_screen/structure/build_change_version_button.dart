import 'package:hdc_remake/app_dependencies.dart';

Widget buildChangeVersionButton(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 40),
    child: Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Container(
          padding: const EdgeInsets.only(top: 15, bottom: 10, right: 10, left: 10),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF3DBAA6),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: (){},
                    child: const Text(
                      'Cambiar versión del himnario.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3A3A3A),
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                thickness: 2,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}