import 'package:hdc_remake/application_themes.dart';
import 'package:hdc_remake/screens/settings_screen/settings_screen_dependencies.dart';

Widget buildOptionBubble(BuildContext context, double marginTop, double marginBottom, String title, Widget icon, {String routeName = '', Function? onTap}) {
  return GestureDetector(
    onTap: () {
      if (routeName != '') {
        Navigator.pushNamed(context, routeName);
      } else {
        onTap!();
      }
    },
    child: Container(
      margin: EdgeInsets.only(left: 25, right: 25, top: marginTop, bottom: marginBottom),
      width: double.infinity,
      height: 90,
      decoration: BoxDecoration(
        color: getContainerColor(context),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            blurRadius: getBlueContainer(context),
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: getTextColor(context),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 5),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: IconButton(
                  onPressed: () {
                    if (routeName != '') {
                      Navigator.pushNamed(context, routeName);
                    }
                  },
                  icon: icon,
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 8, left: 20, right: 20),
            width: double.infinity,
            child: Divider(
              thickness: 1,
              color: getDividerColor(context),
            ),
          ),
        ],
      ),
    ),
  );
}

Color getContainerColor(BuildContext context) {

  var themeData = Theme.of(context);

  if (themeData.primaryColor == AppTheme().oceanTheme.primaryColor) {
    return const Color(0xFF1E2A47);
  } else if (themeData.primaryColor == AppTheme().lightTheme.primaryColor) {
    return const Color(0xFF87CEEB);
  } else if (themeData.primaryColor == AppTheme().darkTheme.primaryColor) {
    return const Color(0xFF3C3C3C);
  }

  return Colors.white;
}

Color getTextColor(BuildContext context) {

  var themeData = Theme.of(context);

  if (themeData.primaryColor == AppTheme().oceanTheme.primaryColor) {
    return Colors.white;
  } else if (themeData.primaryColor == AppTheme().lightTheme.primaryColor) {
    return const Color(0xFF3A3A3A);
  } else if (themeData.primaryColor == AppTheme().darkTheme.primaryColor) {
    return Colors.white;
  }

  return Colors.white;
}

Color getDividerColor(BuildContext context) {

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

Color getIconsColorss(BuildContext context) {

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

double getBlueContainer(BuildContext context) {

  var themeData = Theme.of(context);

  if (themeData.primaryColor == AppTheme().oceanTheme.primaryColor) {
    return 10;
  } else if (themeData.primaryColor == AppTheme().lightTheme.primaryColor) {
    return 10;
  } else if (themeData.primaryColor == AppTheme().darkTheme.primaryColor) {
    return 5;
  }

  return 10;
}

