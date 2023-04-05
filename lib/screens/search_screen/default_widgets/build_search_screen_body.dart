import '../search_screen_dependencies.dart';

class BuildSearchScreenBody extends StatefulWidget {
  const BuildSearchScreenBody({Key? key}) : super(key: key);

  @override
  State<BuildSearchScreenBody> createState() => _BuildSearchScreenBodyState();
}

class _BuildSearchScreenBodyState extends State<BuildSearchScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildSearchTextField(context),
      ],
    );
  }
}
