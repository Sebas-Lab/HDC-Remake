import './home_screen_dependencies.dart';

Widget buildTextField(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    padding: const EdgeInsets.only(left: 20),
    width: MediaQuery.of(context).size.width * 0.8,
    child: TextField(
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        hintText: 'Ejem: Canta oh buen cristiano...',
        hintStyle: TextStyle(
          color: Colors.grey[600],
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      ),
    ),
  );
}