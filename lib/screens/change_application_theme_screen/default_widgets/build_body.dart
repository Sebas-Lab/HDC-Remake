import 'dart:math';
import 'package:hdc_remake/screens/settings_screen/settings_screen_dependencies.dart';

import '../../../application_themes.dart';

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

        buildOptionBubble(context, height, 20, 'Oceano',
          CustomPaint(size: const Size(50, 50), painter: DiagonalHalfCirclePainter(upColor: const Color(0xFF345197), downColor: const Color(0xFF3DBAA6))),
          onTap: () {widget.setTheme(CustomThemes.oceanTheme);},
        ),

        buildOptionBubble(context, 20, 20, 'Claro',
          CustomPaint(size: const Size(50, 50), painter: DiagonalHalfCirclePainter(upColor: const Color(0xFFF5F5DC), downColor: const Color(0xFF2EBFF9))),
          onTap: () {widget.setTheme(CustomThemes.lightTheme);},
        ),

        buildOptionBubble(context, 20, 20, 'Oscuro',
          CustomPaint(size: const Size(50, 50), painter: DiagonalHalfCirclePainter(upColor: const Color(0xFF121212), downColor: const Color(0xFF2B2B2B))),
          onTap: () {widget.setTheme(CustomThemes.darkTheme);}
        ),
      ],
    );
  }
}

class DiagonalHalfCirclePainter extends CustomPainter {

  Color upColor;
  Color downColor;

  DiagonalHalfCirclePainter({required this.upColor, required this.downColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = downColor
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = upColor
      ..style = PaintingStyle.fill;

    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      pi / 2,
      pi * 1.5,
      false,
      paint2,
    );

    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      pi * -0.25,
      pi * 0.9,
      false,
      paint1,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}