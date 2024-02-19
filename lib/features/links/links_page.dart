import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class LinksPage extends StatelessWidget {
  const LinksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              children: [
                Text(
                  'The shortest path to anywhere online',
                  style: ShadTheme.of(context).textTheme.h1Large,
                ),
                const SizedBox(height: 32),
                const ShadInput(
                  placeholder: Text('Enter a link to shorten it'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
