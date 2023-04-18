import 'package:hdc_remake/app_dependencies.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  populateDatabase();
  runApp(
    ChangeNotifierProvider(
      create: (context) => HymnsModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FontSizeProvider>(
          create: (context) => FontSizeProvider(),
        ),
      ],
      child: MaterialApp(
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: Color(0xFF1E2A47)),
            ),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => const SelectHymnScreen(),
            '/song': (context) {
              final Hymn hymn = ModalRoute.of(context)!.settings.arguments as Hymn;
              return BuildSong(hymn: hymn);
            },
          }
      ),
    );
  }
}
