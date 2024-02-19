import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nanolink/app/base_status.dart';
import 'package:nanolink/app/widgets/toastification.dart';
import 'package:nanolink/features/links/create_link/create_link_cubit.dart';
import 'package:nanolink/features/links/create_link/create_link_widget.dart';
import 'package:nanolink/features/links/links_cubit.dart';
import 'package:nanolink/features/links/widgets/links_list_widget.dart';
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
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'The shortest path to anywhere online',
                    style: ShadTheme.of(context).textTheme.h1Large,
                  ),
                  const SizedBox(height: 32),
                  const CreateLinkWidget(),
                  const SizedBox(height: 32),
                  const LinksListWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
