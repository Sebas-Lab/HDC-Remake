import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

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