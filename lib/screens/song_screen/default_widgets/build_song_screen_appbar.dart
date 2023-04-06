import 'package:hdc_remake/app_dependencies.dart';

class BuildSongScreenAppbar extends StatelessWidget with PreferredSizeWidget {
  const BuildSongScreenAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fontSizeProvider = Provider.of<FontSizeProvider>(context);
    return AppBar(
      backgroundColor: const Color(0xFF3DBAA6),
      title: const Text(
        'Iglesia de Cristo.',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF3A3A3A),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 5),
          child: IconButton(
            onPressed: fontSizeProvider.increaseFontSize,
            icon: const Icon(
              Icons.add_circle,
              size: 35,
              color: Color(0xFF1E2A47),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: fontSizeProvider.decreaseFontSize,
            icon: const Icon(
              Icons.remove_circle,
              size: 35,
              color: Color(0xFF1E2A47),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

