import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

import '../../../application_themes.dart';

typedef FilterAppliedCallback = void Function(int start, int end);

class BuildSearchByNumber extends StatefulWidget {
  final FilterAppliedCallback onFilter;
  final ValueNotifier<int> totalHymns;

  const BuildSearchByNumber({
    Key? key,
    required this.onFilter,
    required this.totalHymns,
  }) : super(key: key);

  @override
  State<BuildSearchByNumber> createState() => _BuildSearchByNumberState();
}

class _BuildSearchByNumberState extends State<BuildSearchByNumber> {

  @override
  void initState() {
    super.initState();
    widget.totalHymns.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    widget.totalHymns.removeListener(() {
      setState(() {});
    });
    super.dispose();
  }

  int selectedButtonIndex = 0;
  List<String> get filterByNumber => generateFilterRanges(widget.totalHymns.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      padding: const EdgeInsets.only(left: 5, right: 5),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 25, top: 30),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Selecciona un grupo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).primaryColor == AppTheme().lightTheme.primaryColor ? const Color(0xFF3A3A3A): Colors.white,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5),
            child: Divider(
              thickness: 1.5,
              color: getDividerColors(context),
              indent: 15,
              endIndent: 50,
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filterByNumber.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Center(
                    child: SizedBox(
                      width: 120,
                      child: ElevatedButton(
                        onPressed: () => {
                          widget.onFilter(index * 50 + 1, (index + 1) * 50),
                          setState(() {
                            selectedButtonIndex = index; // actualizar el índice del botón seleccionado
                          }),
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          primary: selectedButtonIndex == index ? Colors.orange : Theme.of(context).primaryColor, // cambiar el color del botón seleccionado
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          shadowColor: Colors.black,
                          elevation: 8,
                        ),
                        child: Text(
                          filterByNumber[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: getTextButtonColors(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Color getTextButtonColors(BuildContext context) {

  var themeData = Theme.of(context);

  if (themeData.primaryColor == AppTheme().oceanTheme.primaryColor) {
    return const Color(0xFF3A3A3A);
  } else if (themeData.primaryColor == AppTheme().lightTheme.primaryColor) {
    return const Color(0xFF3A3A3A);
  } else if (themeData.primaryColor == AppTheme().darkTheme.primaryColor) {
    return Colors.white;
  }

  return Colors.white;
}

Color getDividerColors(BuildContext context) {

  var themeData = Theme.of(context);

  if (themeData.primaryColor == AppTheme().oceanTheme.primaryColor) {
    return const Color(0xFF3DBAA6);
  } else if (themeData.primaryColor == AppTheme().lightTheme.primaryColor) {
    return const Color(0xFF009BFF);
  } else if (themeData.primaryColor == AppTheme().darkTheme.primaryColor) {
    return Colors.white;
  }

  return Colors.white;
}