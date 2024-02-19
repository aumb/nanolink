import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanolink/app/base_status.dart';
import 'package:nanolink/features/links/create_link/create_link_cubit.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CreateLinkWidget extends StatelessWidget {
  const CreateLinkWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select((CreateLinkCubit c) => c.state);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1200),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ShadInput(
              placeholder: const Text('Enter a link to shorten it'),
              onChanged: context.read<CreateLinkCubit>().updateUrl,
              onSubmitted: (_) => context.read<CreateLinkCubit>().createLink(),
            ),
          ),
          ShadButton.outline(
            icon: state.status.isLoading
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
    );
  }
}
