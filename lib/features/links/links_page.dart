import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';
import 'package:nanolink/app/base_status.dart';
import 'package:nanolink/app/widgets/toastification.dart';
import 'package:nanolink/features/links/services/create_link_service.dart';
import 'package:nanolink/features/links/services/links_local_data_service.dart';
import 'package:nanolink/features/links/widgets/link_card.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class LinksPage extends StatelessWidget {
  const LinksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final createLinkService = GetIt.I<CreateLinkService>()
      ..viewModelSignal.watch(context);

    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        final status = createLinkService.viewModel.status;

        switch (status) {
          case LoadedStatus<CreateLinkViewModel>():
            showSuccessToast(
              context,
              'Created a new link for ${createLinkService.viewModel.url}',
            );
          case ErrorStatus<CreateLinkViewModel>(error: final e):
            showErrorToast(context, e);
          case InitialStatus<CreateLinkViewModel>():
          case LoadingStatus<CreateLinkViewModel>():
          case EmptyStatus<CreateLinkViewModel>():
            break;
        }
      },
    );

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
                        onChanged: createLinkService.updateUrl,
                        onSubmitted: (_) => createLinkService.createLink(),
                      ),
                    ),
                    ShadButton.outline(
                      icon: createLinkService.viewModel.status.isLoading
                          ? const SizedBox.square(
                              dimension: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : const Icon(Icons.chevron_right),
                      size: ShadButtonSize.icon,
                      onPressed: createLinkService.createLink,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Wrap(
                  runSpacing: 8,
                  spacing: 16,
                  children: GetIt.I<LinksLocalDataService>()
                      .savedLinks
                      .map((e) => LinkCard(link: e))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
