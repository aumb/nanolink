import 'package:go_router/go_router.dart';
import 'package:nanolink/features/links/links_page.dart';

final goRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LinksPage(),
    ),
  ],
);
