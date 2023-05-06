import 'package:hdc_remake/screens/settings_screen/settings_screen_dependencies.dart';

Widget buildOptionBubble(BuildContext context, double marginTop, String title, IconData icon, {String routeName = ''}) {
  return InkWell(
    onTap: () {
      if (routeName != '') {
        Navigator.pushNamed(context, routeName);
      }
    },
    child: Container(
      margin: EdgeInsets.only(left: 25, right: 25, top: marginTop),
      width: double.infinity,
      height: 90,
      decoration: BoxDecoration(
        color: const Color(0xFF1E2A47),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            blurRadius: 10,
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
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.white
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
                  icon: Icon(
                    icon,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 8, left: 20, right: 20),
            width: double.infinity,
            child: const Divider(
              thickness: 1,
              color: Color(0xFF3DBAA6),
            ),
          ),
        ],
      ),
    ),
  );
}