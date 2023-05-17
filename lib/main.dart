import 'package:hdc_remake/application/application_dependencies.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => HymnsModel()),
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => FontSizeProvider()),
    ],
    child: const HDCRemakeApp(),
  ));
}

class HDCRemakeApp extends StatefulWidget {
  const HDCRemakeApp({Key? key}) : super(key: key);

  @override
  HDCRemakeAppState createState() => HDCRemakeAppState();
}

class HDCRemakeAppState extends State<HDCRemakeApp> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider<FontSizeProvider>(create: (context) => FontSizeProvider())],
      child: AnimatedTheme(
        data: Provider.of<ThemeProvider>(context).currentTheme,
        duration: const Duration(seconds: 5),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Himnario digital',
            theme: Provider.of<ThemeProvider>(context).currentTheme,
            routes: {
            '/': (context) => const SelectHymnScreen(),
            '/song': (context) { final Hymn hymn = ModalRoute.of(context)!.settings.arguments as Hymn; return BuildSong(hymn: hymn);},
            '/home': (context) => const NavigationHandle(),
            '/information': (context) => const InformationScreen(),
            '/change_songbook': (context) => const ChangeSongBookScreen(),
            '/change_app_theme': (context) => ChangeAppThemeScreen(setTheme: Provider.of<ThemeProvider>(context).setTheme),
          }
        ),
      ),
    );
  }
}