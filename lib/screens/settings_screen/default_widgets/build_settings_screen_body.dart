import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

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
        buildOptionBubble(context, MediaQuery.of(context).size.height * 0.07, 30, 'Cambiar himnario', Icon(Icons.library_books, size: 35, color: getIconsColors(context)), routeName: '/change_songbook'),
        buildOptionBubble(context, 10, 30, 'Información', Icon(Icons.email, size: 35, color: getIconsColors(context)), routeName: '/information'),
        buildOptionBubble(context, 10, 30, 'Temas', Icon(Icons.palette, size: 35, color: getIconsColors(context)), routeName: '/change_app_theme'),
      ],
    );
  }

  Color getIconsColors(BuildContext context) {

    var themeData = Theme.of(context);

    if (themeData.primaryColor == AppTheme().oceanTheme.primaryColor) {
      return const Color(0xFF3DBAA6);
    } else if (themeData.primaryColor == AppTheme().lightTheme.primaryColor) {
      return const Color(0xFF006CFF);
    } else if (themeData.primaryColor == AppTheme().darkTheme.primaryColor) {
      return Colors.white;
    }

    return Colors.white;
  }
}
