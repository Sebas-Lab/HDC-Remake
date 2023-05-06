import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

class NavigationHandle extends StatefulWidget {
  const NavigationHandle({Key? key}) : super(key: key);

  @override
  NavigationHandleState createState() => NavigationHandleState();
}

class NavigationHandleState extends State<NavigationHandle> {

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const SearchScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: const Color(0xFF1E2A47),
        unselectedItemColor: Colors.grey[800],
        backgroundColor: const Color(0xFF3DBAA6),
        currentIndex: _selectedIndex,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        selectedIconTheme: const IconThemeData(
          size: 24,
        ),
        unselectedIconTheme: const IconThemeData(
          size: 20,
        ),
      ),
    );
  }
}