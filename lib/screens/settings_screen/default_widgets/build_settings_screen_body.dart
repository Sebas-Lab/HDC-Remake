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
        buildOptionBubble(context, MediaQuery.of(context).size.height * 0.07, 'Cambiar himnario', Icons.library_books, routeName: '/change_songbook'),
        buildOptionBubble(context, 30, 'Información', Icons.email, routeName: '/information'),
      ],
    );
  }
}
