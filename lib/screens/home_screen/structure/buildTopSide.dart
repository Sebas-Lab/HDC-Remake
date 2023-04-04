import 'package:hdc_remake/app_dependencies.dart';

Widget buildTopSide (BuildContext context) {
  return Container(
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.only(top: 20, bottom: 20),
    child: Column(
      children: [
        buildSearchText(context),
        dividerLine(2, 200, const Color(0XFF4cc9f0), 10, 20, context),
        buildTextField(context),
        buildChangeVersion(context),
      ],
    ),
  );
}