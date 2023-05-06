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

        // Usa la versión temporal del himnario
        String localVersion = hymnbookVersions[selectedHymnbookId]!;

        // Compara la versión temporal con la versión del himnario en línea
        Songbook selectedHymnbook = songbooks.firstWhere((songbook) => songbook.id == selectedHymnbookId);
        if (localVersion != selectedHymnbook.version) {
          // Si las versiones son diferentes, muestra un diálogo al usuario e inicia la actualización
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Actualización disponible"),
                content: const Text("Hay una nueva versión del himnario. ¿Desea actualizar?"),
                actions: [
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      // Iniciar la actualización del himnario aquí
                      Completer<void> completer = Completer();
                      await downloadHymns(selectedHymnbook.id, scaffoldKey, songbooks);
                      await completer.future;
                      if (mounted) {
                        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                      }
                    },
                    child: const Text("Actualizar"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancelar"),
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
