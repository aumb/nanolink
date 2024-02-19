import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nanolink/app/base_status.dart';
import 'package:nanolink/app/widgets/toastification.dart';
import 'package:nanolink/features/links/create_link/create_link_cubit.dart';
import 'package:nanolink/features/links/links_cubit.dart';
import 'package:nanolink/features/links/widgets/link_card.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class LinksPage extends StatelessWidget {
  const LinksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GetIt.I<LinksCubit>()..fetchLinks(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<CreateLinkCubit>(),
        ),
      ],
      child: BlocListener<CreateLinkCubit, CreateLinkViewModel>(
        listener: (context, state) {
          final status = state.status;

          switch (status) {
            case LoadedStatus<CreateLinkViewModel>():
              showSuccessToast(
                context,
                'Created a new link for ${state.url}',
              );
              context.read<LinksCubit>().fetchLinks();
            case ErrorStatus<CreateLinkViewModel>(error: final e):
              showErrorToast(context, e);
            case InitialStatus<CreateLinkViewModel>():
            case LoadingStatus<CreateLinkViewModel>():
            case EmptyStatus<CreateLinkViewModel>():
              break;
          }
        },
        child: const LinksView(),
      ),
    );
  }
}

class LinksView extends StatelessWidget {
  const LinksView({super.key});

  @override
  Widget build(BuildContext context) {
    final links = context.select((LinksCubit c) => c.state.links);
    final createLinkState = context.select((CreateLinkCubit c) => c.state);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'The shortest path to anywhere online',
                  style: ShadTheme.of(context).textTheme.h1Large,
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ShadInput(
                        placeholder: const Text('Enter a link to shorten it'),
                        onChanged: context.read<CreateLinkCubit>().updateUrl,
                        onSubmitted: (_) =>
                            context.read<CreateLinkCubit>().createLink(),
                      ),
                    ),
                    ShadButton.outline(
                      icon: createLinkState.status.isLoading
                          ? const SizedBox.square(
                              dimension: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : const Icon(Icons.chevron_right),
                      size: ShadButtonSize.icon,
                      onPressed: context.read<CreateLinkCubit>().createLink,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Wrap(
                  runSpacing: 8,
                  spacing: 16,
                  children: links.map((e) => LinkCard(link: e)).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
