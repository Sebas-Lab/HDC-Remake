import 'package:hdc_remake/app_dependencies.dart';

PreferredSizeWidget buildAppbar() {
  return AppBar(
    backgroundColor: const Color(0xFFf72585),
    centerTitle: true,
    title: const Text(
      'Himnario digital',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}