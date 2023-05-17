import 'package:hdc_remake/application/application_dependencies.dart';

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
      appBar: const BuildChangeAppThemesAppbar(),
      body: BuildChangeAppThemeBodyScreen(setTheme: widget.setTheme),
    );
  }
}
