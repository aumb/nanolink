import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nanolink_app/features/home/presentation/view/home_page.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute<dynamic>(page: HomePage, initial: true),
  ],
)
class AppRouter extends _$AppRouter {}
