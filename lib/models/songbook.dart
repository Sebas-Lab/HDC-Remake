class Songbook {
  final int id;
  final String name;
  final int songAmount;
  final String img;
  final String version;

  Songbook({
    required this.id,
    required this.name,
    required this.songAmount,
    required this.img,
    required this.version,
  });

  factory Songbook.fromJson(Map<String, dynamic> json) {
    return Songbook(
      id: json['id'],
      name: json['name'],
      songAmount: json['songamount'],
      img: json['img'],
      version: json['version'],
    );
  }
}