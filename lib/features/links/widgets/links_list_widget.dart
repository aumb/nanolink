import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanolink/app/base_status.dart';
import 'package:nanolink/features/links/links_cubit.dart';
import 'package:nanolink/features/links/widgets/link_card.dart';

class LinksListWidget extends StatelessWidget {
  const LinksListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select((LinksCubit c) => c.state);

    return Container(
      alignment: Alignment.centerLeft,
      constraints: const BoxConstraints(maxWidth: 1200),
      child: state.status.isLoading
          ? const CircularProgressIndicator()
          : Wrap(
              runSpacing: 8,
              spacing: 16,
              children: state.links.map((e) => LinkCard(link: e)).toList(),
            ),
    );
  }
}
