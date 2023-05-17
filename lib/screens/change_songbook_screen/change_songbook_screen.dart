import 'package:hdc_remake/application/application_dependencies.dart';

class ChangeSongBookScreen extends StatefulWidget {
  const ChangeSongBookScreen({Key? key}) : super(key: key);

  @override
  State<ChangeSongBookScreen> createState() => _ChangeSongBookScreenState();
}

class _ChangeSongBookScreenState extends State<ChangeSongBookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Cambiar himnario',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor == AppTheme().darkTheme.primaryColor ? Colors.white : const Color(0xFF3A3A3A),
          ),
        ),
      ),
      body: const BuildChangeSongBookScreenBody(),
    );
  }
}
