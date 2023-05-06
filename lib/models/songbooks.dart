class SongBooks {
  int id;
  String name;
  int songAmount;
  String img;
  String version;
  bool isDownloaded;
  bool isSelected;

  SongBooks({
    required this.id,
    required this.name,
    required this.songAmount,
    required this.img,
    required this.version,
    this.isDownloaded = false,
    this.isSelected = false,
  });

  factory SongBooks.fromJson(Map<String, dynamic> json) {
    return SongBooks(
      id: json['id'],
      name: json['name'],
      songAmount: json['songamount'],
      img: json['img'],
      version: json['version'],
      isDownloaded: json['isDownloaded'] ?? false,
      isSelected: json['isSelected'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'songamount': songAmount,
      'img': img,
      'version': version,
      'isDownloaded': isDownloaded,
      'isSelected': isSelected,
    };
  }
}