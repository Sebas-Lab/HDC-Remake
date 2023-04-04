import 'package:hdc_remake/app_dependencies.dart';

Widget dividerLine(double dividerThickness, double dividerLarge, Color color, double paddingTop, double paddingLeft, BuildContext context) {
  return Container(
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.only(top: paddingTop, left: paddingLeft),
    width: MediaQuery.of(context).size.width * 0.8,
    child: Divider(
      thickness: dividerThickness,
      color: color,
    ),
  );
}