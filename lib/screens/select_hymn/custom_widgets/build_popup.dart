import 'package:hdc_remake/application/application_dependencies.dart';

Widget buildPopup(BuildContext context) {
  PopupLogic popupLogic = PopupLogic();
  double pt = MediaQuery.of(context).size.height * 0.38;

  return Scaffold(
    backgroundColor: const Color(0xFF1E2A47),
    body: Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            margin: EdgeInsets.only(top: pt),
            child: const Text(
              'Elige un himnario.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...List<Widget>.generate(1, (int index) {
            return Center(
              child: GestureDetector(
                onTap: () async {
                  await popupLogic.showDownloadingDialog(
                      context, 'Descargando Himnario', true);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF3DBAA6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(
                      bottom: 16, top: 16, right: 50, left: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '${index + 1}. - Cánticos espirituales.',
                        style: const TextStyle(
                          color: Color(0xFF1E2A47),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(
                        Icons.download_rounded,
                        color: Color(0xFF1E2A47),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    ),
  );
}