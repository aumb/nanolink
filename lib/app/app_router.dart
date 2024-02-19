import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:celest_backend/client.dart';
import 'package:celest_backend/models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nanolink/features/links/links_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/:id',
      builder: (context, state) {
        return const SizedBox.shrink();
      },
      redirect: (context, state) async {
        final id = state.pathParameters['id'];

        if (id?.isEmpty ?? true) {
          return '/';
        }

        final link = await celest.functions.links.getLink(id!);

        if (link == null) {
          return '/';
        }

        unawaited(
          celest.functions.clicks.addClick(
            ClickRequest(linkId: link.id),
          ),
        );

        html.window.location.replace(link.originalUrl);

        return null;
      },
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const LinksPage(),
    ),
  ],
);
