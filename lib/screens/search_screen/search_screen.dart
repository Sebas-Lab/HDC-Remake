import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const BuildSearchScreenAppbar(),
      body: const BuildSearchScreenBody(),
      // bottomNavigationBar: GlobalNavigationBar(),
    );
  }
}
