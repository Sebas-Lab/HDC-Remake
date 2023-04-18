import '../home_screen_dependencies.dart';

typedef SongSelectedCallback = void Function(int index);

class SongList extends StatefulWidget {
  final SongSelectedCallback onSongSelected;
  final List<Hymn> hymns;
  const SongList({Key? key, required this.onSongSelected, required this.hymns}) : super(key: key);

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
    Hymn selectedHymn = widget.hymns[index - 1];
    Navigator.pushNamed(context, '/song', arguments: selectedHymn);
  }

  @override
  Widget build(BuildContext context) {
    return buildSongsList(context, start, end, widget.hymns, onSongSelected);
  }
}

Widget buildSongsList(BuildContext context, int start, int end, List<Hymn> hymns, SongSelectedCallback onSongSelected) {
  return Expanded(
    child: Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: end - start,
            itemBuilder: (BuildContext context, int index) {
              if (hymns.length <= index + start) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: Text('Error al cargar los himnarios.'),
                  ),
                );
              }

              Hymn hymn = hymns[index + start];

              return Container(
                padding: const EdgeInsets.only(left: 20, top: 7, bottom: 7, right: 20),
                margin: const EdgeInsets.only(bottom: 15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF1E2A47),
                    padding: const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
                    shadowColor: Colors.black,
                    elevation: 8,
                  ),
                  onPressed: () {
                    onSongSelected(index + start + 1);
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${index + start + 1} - ${hymn.name}',
                      style: const TextStyle(
                        height: 2,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
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