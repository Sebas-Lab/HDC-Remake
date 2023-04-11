import '../home_screen_dependencies.dart';

typedef SongSelectedCallback = void Function(int index);

class SongList extends StatefulWidget {
  final SongSelectedCallback onSongSelected;
  const SongList({Key? key, required this.onSongSelected}) : super(key: key);

  @override
  State<SongList> createState() => SongListState();
}

class SongListState extends State<SongList> {

  int start = 0;
  int end = 50;

  void applyFilter(int newStart, int newEnd) {
    setState(() {
      start = newStart - 1;
      end = newEnd;
    });
  }

  void onSongSelected(int index) {
    Navigator.pushNamed(context, '/song');
  }

  @override
  Widget build(BuildContext context) {
    return buildSongsList(context, start, end, onSongSelected);
  }
}

Widget buildSongsList(BuildContext context, int start, int end, SongSelectedCallback onSongSelected) {
  return Expanded(
    child: Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: end - start,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
                margin: const EdgeInsets.only(top: 5, bottom: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF1E2A47),
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    shadowColor: Colors.black,
                    elevation: 8,
                  ),
                  onPressed: () {
                    onSongSelected(index + start + 1);
                  },
                  child: Text(
                    '${index + start + 1}. - Nombre del himno.',
                    style: const TextStyle(
                      height: 2,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
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