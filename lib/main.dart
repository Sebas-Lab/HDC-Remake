import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    ChangeNotifierProvider(
      create: (context) => HymnsModel(),
      child: const HDCRemakeApp(),
    ),
  );
}

class HDCRemakeApp extends StatefulWidget {
  const HDCRemakeApp({Key? key}) : super(key: key);

  @override
  HDCRemakeAppState createState() => HDCRemakeAppState();
}

class HDCRemakeAppState extends State<HDCRemakeApp> {

  ThemeData _currentTheme = AppTheme().oceanTheme;
  CustomThemes _customTheme = CustomThemes.oceanTheme;

  ThemeData get currentTheme => _currentTheme;
  CustomThemes get currentCustomTheme => _customTheme;

  void setTheme(CustomThemes theme) {
    ThemeData newTheme;
    switch (theme) {
      case CustomThemes.oceanTheme:
        newTheme = AppTheme().oceanTheme;
        break;
      case CustomThemes.lightTheme:
        newTheme = AppTheme().lightTheme;
        break;
      case CustomThemes.darkTheme:
        newTheme = AppTheme().darkTheme;
        break;
      default:
        newTheme = ThemeData.light();
        break;
    }
    setState(() {
      _currentTheme = newTheme;
      _customTheme = theme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FontSizeProvider>(
          create: (context) => FontSizeProvider(),
        ),
      ],
      child: AnimatedTheme(
        data: _currentTheme,
        duration: const Duration(seconds: 5),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Himnario digital',
            theme: currentTheme,
            routes: {
            '/': (context) => const SelectHymnScreen(),
            '/song': (context) { final Hymn hymn = ModalRoute.of(context)!.settings.arguments as Hymn; return BuildSong(hymn: hymn);},
            '/home': (context) => const NavigationHandle(),
            '/information': (context) => const InformationScreen(),
            '/change_songbook': (context) => const ChangeSongBookScreen(),
            '/change_app_theme': (context) => ChangeAppThemeScreen(setTheme: setTheme),
          }
        ),
      ),
    );
  }
}
