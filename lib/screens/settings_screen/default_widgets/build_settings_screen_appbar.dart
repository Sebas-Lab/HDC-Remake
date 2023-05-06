import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

class BuildSettingsAppbar extends StatelessWidget with PreferredSizeWidget {
  const BuildSettingsAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF3DBAA6),
      centerTitle: true,
      title: const Text(
        'Ajustes',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF3A3A3A),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

