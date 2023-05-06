import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({Key? key}) : super(key: key);

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF1E2A47),
      appBar: BuildInformationScreenAppbar(),
      body: BuildInformationScreenBody(),
    );
  }
}
