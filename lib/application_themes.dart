import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

class AppTheme {

  final ThemeData oceanTheme = ThemeData(
    primaryColor: const Color(0xFF3DBAA6),
    scaffoldBackgroundColor: const Color(0xFF1E2A47),
  );

  final ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xFF87CEEB),
    scaffoldBackgroundColor: const Color(0xFFC5CAE9),
  );

  final ThemeData darkTheme = ThemeData(
    primaryColor: const Color(0xFF3C3C3C),
    scaffoldBackgroundColor: const Color(0xFF121212),
  );
}

enum CustomThemes { oceanTheme, lightTheme, darkTheme }

