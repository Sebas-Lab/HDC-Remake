import 'package:hdc_remake/application/application_dependencies.dart';

class ThemeProvider extends ChangeNotifier {
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
    _currentTheme = newTheme;
    _customTheme = theme;
    notifyListeners();
  }
}