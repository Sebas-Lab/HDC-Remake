import 'package:hdc_remake/screens/settings_screen/settings_screen_dependencies.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E2A47),
      appBar: const BuildSettingsAppbar(),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 35, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Expanded(
              child: BuildSettingsBody(),
            ),
            buildQuickInfo(),
          ],
        ),
      ),
    );
  }
}
