
// Flutter
export 'package:shared_preferences/shared_preferences.dart';
export 'package:path_provider/path_provider.dart';
export 'package:audioplayers/audioplayers.dart';
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'package:sqflite/sqflite.dart';
export 'package:async/async.dart';
export 'dart:async';
export 'dart:math';
export 'dart:io';

// Application init
export 'package:hdc_remake/widgets/navigation_handle.dart';

// Screens

   // Select hymn screen
export 'package:hdc_remake/screens/select_hymn/default_widgets/build_select_hymn_body.dart';
export 'package:hdc_remake/screens/select_hymn/select_hymn.dart';

   // Home screen
export 'package:hdc_remake/screens/home_screen/default_widgets/build_home_screen_appbar.dart';
export 'package:hdc_remake/screens/home_screen/default_widgets/build_home_screen_body.dart';
export 'package:hdc_remake/screens/Home_Screen/home_screen.dart';
export 'package:hdc_remake/screens/home_screen/custom_widgets/build_songs_list.dart';
export 'package:hdc_remake/screens/home_screen/custom_widgets/build_search_by_number.dart';

   // Search screen
export 'package:hdc_remake/screens/search_screen/default_widgets/build_search_screen_appbar.dart';
export 'package:hdc_remake/screens/search_screen/default_widgets/build_search_screen_body.dart';
export 'package:hdc_remake/screens/search_screen/search_screen.dart';
export 'package:hdc_remake/screens/search_screen/custom_widgets/build_search_text_field.dart';

   // Settings screen
export 'package:hdc_remake/screens/settings_screen/settings_screen.dart';
export 'package:hdc_remake/screens/settings_screen/default_widgets/build_settings_screen_appbar.dart';
export 'package:hdc_remake/screens/settings_screen/default_widgets/build_settings_screen_body.dart';

   // Song screen
export 'package:hdc_remake/screens/song_screen/build_song.dart';

   // Information screen
export 'package:hdc_remake/screens/information_screen/default_widgets/build_appbar.dart';
export 'package:hdc_remake/screens/information_screen/default_widgets/build_body.dart';
export 'package:hdc_remake/screens/information_screen/information_screen.dart';

   // Change songbook screen
export 'package:hdc_remake/screens/change_songbook_screen/change_songbook_screen.dart';
export 'package:hdc_remake/screens/change_songbook_screen/default_widgets/build_appbar.dart';
export 'package:hdc_remake/screens/change_songbook_screen/default_widgets/build_body.dart';
export 'package:hdc_remake/screens/change_songbook_screen/custom_widgets/songbook_items_list.dart';

   // Change application theme screen
export 'package:hdc_remake/application_themes.dart';
export 'package:hdc_remake/screens/change_application_theme_screen/default_widgets/build_appbar.dart';
export 'package:hdc_remake/screens/change_application_theme_screen/default_widgets/build_body.dart';
export 'package:hdc_remake/screens/change_application_theme_screen/change_application_theme_screen.dart';

// Logic

   // Select hymn screen
export 'package:hdc_remake/screens/select_hymn/logic/popup.dart';

   // Home screen
export 'package:hdc_remake/screens/home_screen/logic/generate_filters_by_ranges.dart';

   // Search screen
export 'package:hdc_remake/screens/search_screen/logic/search_hymns.dart';

   // Settings screen
export 'package:hdc_remake/screens/settings_screen/custom_widgets/option_bubble.dart';

   // Change application theme screen
export 'package:hdc_remake/screens/change_application_theme_screen/custom_widgets/build_app_theme_colors.dart';

   // Change songbook screen
export 'package:hdc_remake/screens/change_songbook_screen/logic/on_hymnbook_changed.dart';
export 'package:hdc_remake/screens/change_songbook_screen/logic/get_icon_data.dart';
export 'package:hdc_remake/screens/change_songbook_screen/logic/download_hymns_for_songbook.dart';
export 'package:hdc_remake/screens/change_songbook_screen/logic/fetch_songbooks_and_update_download_status.dart';
export 'package:hdc_remake/screens/change_songbook_screen/logic/update_songbook_download_status.dart';
export 'package:hdc_remake/screens/change_songbook_screen/logic/is_hymnbook_downloaded.dart';

// Models
export 'package:hdc_remake/models/songbooks.dart';
export 'package:hdc_remake/models/songbook.dart';

// Global data
export 'package:hdc_remake/global_data/total_hymns.dart';

// Providers
export 'package:hdc_remake/providers/font_size_provider.dart';
export 'package:provider/provider.dart';
export 'package:hdc_remake/providers/hymn_model_provider.dart';
export 'package:diacritic/diacritic.dart';

// Database
export 'package:hdc_remake/database/database_helper.dart';
export 'package:flutter/services.dart';
export '../../models/hymn.dart';
export 'dart:convert';

// Services
export '../../../../services/audio_service.dart';
export '../api/songbook_api.dart';

// Packages
export 'package:hdc_remake/utils/share_preferences_manager.dart';
