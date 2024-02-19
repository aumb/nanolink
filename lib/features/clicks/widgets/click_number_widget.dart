import 'package:celest_backend/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nanolink/app/widgets/toastification.dart';
import 'package:nanolink/features/clicks/clicks_cubit.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ClickNumberView extends StatelessWidget {
  const ClickNumberView({required this.link, super.key});

  final Link link;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<ClicksCubit>()..init(link),
      child: const ClickNumberWidget(),
    );
  }
}

class ClickNumberWidget extends StatelessWidget {
  const ClickNumberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select((ClicksCubit c) => c.state);

    return InkWell(
      onTap: () {
        Clipboard.setData(
          ClipboardData(
            text: state.clickNumber.toString(),
          ),
        );
        showCopyToast(
          context,
          state.clickNumber.toString(),
        );
      },
      child: Column(
        children: [
          const Icon(Icons.ads_click),
          Text(
            state.clickNumber.toString(),
            style: ShadTheme.of(context).textTheme.muted,
          ),
        ],
      ),
    );
  }
}
