import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

class BuildChangeSongBookScreenAppbar extends StatelessWidget with PreferredSizeWidget {
  const BuildChangeSongBookScreenAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF3DBAA6),
      title: const Text(
        'Cambiar himnario',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF3A3A3A),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}