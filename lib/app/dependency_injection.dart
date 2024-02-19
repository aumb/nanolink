import 'package:get_it/get_it.dart';
import 'package:nanolink/features/clicks/clicks_cubit.dart';
import 'package:nanolink/features/links/create_link/create_link_cubit.dart';
import 'package:nanolink/features/links/links_cubit.dart';
import 'package:nanolink/features/links/services/links_local_data_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DependencyInjection {
  static Future<void> inject() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    final linksLocalDataService = LinksLocalDataService(sharedPreferences);

    GetIt.I
      ..registerSingleton<LinksLocalDataService>(linksLocalDataService)
      ..registerFactory<LinksCubit>(() => LinksCubit(linksLocalDataService))
      ..registerFactory<CreateLinkCubit>(
        () => CreateLinkCubit(linksLocalDataService),
      )
      ..registerFactory<ClicksCubit>(ClicksCubit.new);
  }
}
