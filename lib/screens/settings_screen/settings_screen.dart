import 'package:hdc_remake/screens/settings_screen/settings_screen_dependencies.dart';

import '../../application_themes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const BuildSettingsAppbar(),
      body: const BuildSettingsBody(),
    );
  }
}
