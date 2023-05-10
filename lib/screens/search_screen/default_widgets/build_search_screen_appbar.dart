import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

import '../../../application_themes.dart';

class BuildSearchScreenAppbar extends StatelessWidget with PreferredSizeWidget {
  const BuildSearchScreenAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: true,
      title: Text(
        'Búsqueda',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor == AppTheme().darkTheme.primaryColor ? Colors.white : const Color(0xFF3A3A3A),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

