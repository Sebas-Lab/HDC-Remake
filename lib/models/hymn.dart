class Hymn {
  int id;
  String name;
  String lyrics;
  int songbookId;

  Hymn({
    required this.id,
    required this.name,
    required this.lyrics,
    required this.songbookId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'lyrics': lyrics,
      'songbookId': songbookId,
    };
  }

  factory Hymn.fromMap(Map<String, dynamic> map) {
    return Hymn(
      id: map['id'] ?? 0,
      name: map['name'] ?? map['title'] ?? '',
      lyrics: map['lyrics'] ?? '',
      songbookId: map['songbookId'] ?? 0,
    );
  }
}
