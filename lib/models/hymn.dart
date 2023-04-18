class Hymn {
  int id;
  String name;
  String lyrics;

  Hymn({required this.id, required this.name, required this.lyrics});

  // Convert a Hymn object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'lyrics': lyrics,
    };
  }

  // Convert a Map object into a Hymn object
  factory Hymn.fromMap(Map<String, dynamic> json) => Hymn(
    id: json["id"],
    name: json["title"] ?? "",
    lyrics: json["lyrics"] ?? "",
  );
}
