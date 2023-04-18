import 'package:hdc_remake/app_dependencies.dart';

class SelectHymnScreen extends StatefulWidget {
  const SelectHymnScreen({Key? key}) : super(key: key);

  @override
  State<SelectHymnScreen> createState() => _SelectHymnScreenState();
}

class _SelectHymnScreenState extends State<SelectHymnScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF1E2A47),
      body: BuildSelectHymnBody(),
    );
  }
}
