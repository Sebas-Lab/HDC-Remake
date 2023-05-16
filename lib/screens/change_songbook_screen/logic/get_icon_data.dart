import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

IconData getIconData(SongBooks songbook, bool isSelected) {
  IconData iconData;
  if (isSelected && songbook.isDownloaded) {
    iconData = Icons.check_box; // Icono de checkbox con el check
  } else if (songbook.isDownloaded) {
    iconData = Icons.check_box_outline_blank; // Icono de checkbox sin el check
  } else {
    iconData = Icons.download; // Icono de descarga
  }
  return iconData;
}