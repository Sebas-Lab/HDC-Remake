import 'package:hdc_remake/application_dependencies/app_dependencies.dart';
import 'package:hdc_remake/local_data/songbook_version.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class SelectHymnScreen extends StatefulWidget {
  const SelectHymnScreen({Key? key}) : super(key: key);

  @override
  State<SelectHymnScreen> createState() => _SelectHymnScreenState();
}

class _SelectHymnScreenState extends State<SelectHymnScreen> {

  @override
  void initState() {
    super.initState();
    fetchSongs().then((songbooks) {
      checkAppStatus(songbooks);
    });
  }

  void checkAppStatus(List<Songbook> songbooks) async {
    SharedPreferencesManager sharedPreferencesManager = SharedPreferencesManager();
    int? selectedHymnbookId = await sharedPreferencesManager.getSelectedHymnbookId();

    if (selectedHymnbookId == null) {

    }

    bool firstTime = await sharedPreferencesManager.isFirstTime();

    if (!firstTime) {
      int? selectedHymnbookId = await sharedPreferencesManager.getSelectedHymnbookId();

      if (selectedHymnbookId != null) {
        DatabaseHelper dbHelper = DatabaseHelper.instance;
        List<Hymn> hymns = await dbHelper.getHymnsBySongbookId(selectedHymnbookId);

        // Compara la versión temporal con la versión del himnario en línea
        Songbook selectedHymnbook = songbooks.firstWhere((songbook) => songbook.id == selectedHymnbookId);

        // Usa la versión temporal del himnario
        String? localVersion = await sharedPreferencesManager.getHymnbookVersion(selectedHymnbookId, songbooks);

        if (localVersion == null || localVersion != selectedHymnbook.version) {
          // Si las versiones son diferentes, muestra un diálogo al usuario e inicia la actualización
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: const Color(0xFF1E2A47),
                title: const Text(
                  "Actualización disponible",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: const Text(
                  "Hay una nueva versión del himnario. ¿Desea actualizar?",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Cancelar",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: TextButton(
                      onPressed: () async {
                        // Iniciar la actualización del himnario aquí
                        Completer<void> completer = Completer();
                        await downloadHymns(selectedHymnbook.id, scaffoldKey, songbooks);
                        await completer.future;
                        if (mounted) {
                          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                        }
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Actualizar",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          // 5. Si las versiones son iguales, carga los himnos locales y navega al HomeScreen
          List<Hymn> localHymns = await DatabaseHelper.instance.loadLocalHymns(selectedHymnbook.id);
          hymnsNotifier.value = List<Hymn>.from(localHymns);
          if (mounted) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF1E2A47),
      body: BuildSelectHymnBody(),
    );
  }
}
