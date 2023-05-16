import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

class ChangeAppThemeScreen extends StatefulWidget {
  final Function(CustomThemes) setTheme;
  const ChangeAppThemeScreen({Key? key, required this.setTheme}) : super(key: key);

  @override
  State<ChangeAppThemeScreen> createState() => _ChangeAppThemeScreenState();
}

class _ChangeAppThemeScreenState extends State<ChangeAppThemeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Selecciona un tema',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor == AppTheme().darkTheme.primaryColor ? Colors.white : const Color(0xFF3A3A3A),
          ),
        ),
      ),
      body: BuildChangeAppThemeBodyScreen(setTheme: widget.setTheme),
    );
  }
}
