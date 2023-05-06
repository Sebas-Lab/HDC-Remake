import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF1E2A47),
      appBar: BuildSearchScreenAppbar(),
      body: BuildSearchScreenBody(),
      // bottomNavigationBar: GlobalNavigationBar(),
    );
  }
}
