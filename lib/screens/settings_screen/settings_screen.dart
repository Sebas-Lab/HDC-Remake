import 'package:hdc_remake/screens/settings_screen/settings_screen_dependencies.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF1E2A47),
      appBar: BuildSettingsAppbar(),
      body: BuildSettingsBody(),
    );
  }
}
