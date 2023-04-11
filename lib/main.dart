import 'package:hdc_remake/app_dependencies.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Color(0xFF1E2A47)),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const NavigationHandle(),
      routes: {
        '/song': (context) => const SongScreen(),
      }
    );
  }
}
