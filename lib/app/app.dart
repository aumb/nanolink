import 'package:flutter/material.dart';
import 'package:nanolink/app/app_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp.router(
      routerConfig: goRouter,
      themeMode: ThemeMode.dark,
      darkTheme: ShadThemeData(
        brightness: Brightness.dark,
        colorScheme: const ShadZincColorScheme.dark(),
      ),
      builder: (_, child) => Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(16),
              child: const ShadAvatar(
                'https://github.githubassets.com/assets/GitHub-Mark-ea2971cee799.png',
              ),
            ),
            Expanded(
              child: child ?? const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
