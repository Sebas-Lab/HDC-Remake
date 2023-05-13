import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

class BuildChangeAppThemeBodyScreen extends StatefulWidget {
  final Function(CustomThemes) setTheme;
  const BuildChangeAppThemeBodyScreen({Key? key, required this.setTheme}) : super(key: key);

  @override
  State<BuildChangeAppThemeBodyScreen> createState() => BuildChangeAppThemeBodyScreenState();
}

class BuildChangeAppThemeBodyScreenState extends State<BuildChangeAppThemeBodyScreen> {

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height * 0.05;

    return ListView(
      children: [
        buildOptionBubble(context, height, 20, 'Oceano', CustomPaint(size: const Size(50, 50), painter: DiagonalHalfCirclePainter(upColor: const Color(0xFF345197), downColor: const Color(0xFF3DBAA6))), onTap: () {widget.setTheme(CustomThemes.oceanTheme);}),
        buildOptionBubble(context, 20, 20, 'Claro', CustomPaint(size: const Size(50, 50), painter: DiagonalHalfCirclePainter(upColor: const Color(0xFFF5F5DC), downColor: const Color(0xFF2EBFF9))), onTap: () {widget.setTheme(CustomThemes.lightTheme);}),
        buildOptionBubble(context, 20, 20, 'Oscuro', CustomPaint(size: const Size(50, 50), painter: DiagonalHalfCirclePainter(upColor: const Color(0xFF121212), downColor: const Color(0xFF2B2B2B))), onTap: () {widget.setTheme(CustomThemes.darkTheme);}),
      ],
    );
  }
}