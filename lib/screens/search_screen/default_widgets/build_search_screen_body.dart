import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

class BuildSearchScreenBody extends StatefulWidget {
  const BuildSearchScreenBody({Key? key}) : super(key: key);

  @override
  State<BuildSearchScreenBody> createState() => _BuildSearchScreenBodyState();
}

class _BuildSearchScreenBodyState extends State<BuildSearchScreenBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: const [
        BuildSearchTextField(),
      ],
    );
  }
}
