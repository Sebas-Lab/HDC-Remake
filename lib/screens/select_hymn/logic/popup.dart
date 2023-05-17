import 'package:hdc_remake/application/application_dependencies.dart';

class PopupLogic {

  Future<void> showDownloadingDialog(BuildContext context, String title, bool showButton) async {
    Timer? timer;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Center(
              child: Text(title, textAlign: TextAlign.center),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    CircularProgressIndicator(),
                    Text('Descargando...'),
                  ],
                ),
              ),
              if (showButton)
                ElevatedButton(
                  onPressed: () {
                    timer?.cancel();
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Cancelar'),
                ),
            ],
          ),
        );
      },
    );

    // timer = Timer(const Duration(seconds: 4), () {
    //   Navigator.of(context).pop();
    //   if (showButton) {
    //     Navigator.of(context).pushAndRemoveUntil(
    //       MaterialPageRoute(
    //         builder: (BuildContext context) => const NavigationHandle(),
    //       ),
    //           (Route<dynamic> route) => false,
    //     );
    //   }
    // });
  }
}
