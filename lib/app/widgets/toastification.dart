import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:toastification/toastification.dart';

void showCopyToast(BuildContext context, String copiedText) =>
    toastification.show(
      context: context,
      backgroundColor: ShadTheme.of(context).colorScheme.background,
      foregroundColor: ShadTheme.of(context).colorScheme.foreground,
      primaryColor: ShadTheme.of(context).colorScheme.primary,
      type: ToastificationType.info,
      animationDuration: const Duration(milliseconds: 200),
      title: Text(
        'Copied $copiedText',
      ),
      showProgressBar: false,
      autoCloseDuration: const Duration(seconds: 2),
    );

void showSuccessToast(BuildContext context, String title) =>
    toastification.show(
      context: context,
      backgroundColor: ShadTheme.of(context).colorScheme.background,
      foregroundColor: ShadTheme.of(context).colorScheme.foreground,
      primaryColor: ShadTheme.of(context).colorScheme.primary,
      type: ToastificationType.success,
      title: Text(title),
      showProgressBar: false,
      autoCloseDuration: const Duration(seconds: 3),
    );

void showErrorToast(BuildContext context, String error) => toastification.show(
      context: context,
      backgroundColor: ShadTheme.of(context).colorScheme.background,
      foregroundColor: ShadTheme.of(context).colorScheme.foreground,
      primaryColor: ShadTheme.of(context).colorScheme.primary,
      type: ToastificationType.error,
      title: Text(error),
      showProgressBar: false,
      autoCloseDuration: const Duration(seconds: 3),
    );
