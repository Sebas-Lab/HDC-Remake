import '../settings_screen_dependencies.dart';

class BuildSettingsBody extends StatefulWidget {
  const BuildSettingsBody({Key? key}) : super(key: key);

  @override
  State<BuildSettingsBody> createState() => _BuildSettingsBodyState();
}

class _BuildSettingsBodyState extends State<BuildSettingsBody> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        buildChangeVersionButton(context),
      ],
    );
  }
}
