import 'package:get_it/get_it.dart';
import 'package:nanolink/features/links/services/create_link_service.dart';
import 'package:nanolink/features/links/services/links_local_data_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DependencyInjection {
  static Future<void> inject() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    final linksLocalDataService = LinksLocalDataService(sharedPreferences);
    final createLinkService = CreateLinkService(linksLocalDataService);

    GetIt.I
      ..registerSingleton<LinksLocalDataService>(linksLocalDataService)
      ..registerSingleton<CreateLinkService>(createLinkService);
  }
}
