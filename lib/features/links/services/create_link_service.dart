import 'dart:developer';

import 'package:celest_backend/client.dart';
import 'package:celest_backend/models.dart';
import 'package:equatable/equatable.dart';
import 'package:nanolink/app/base_status.dart';
import 'package:nanolink/features/links/services/links_local_data_service.dart';
import 'package:signals/signals.dart';

class CreateLinkService {
  CreateLinkService(this._linksLocalDataService);

  final LinksLocalDataService _linksLocalDataService;

  final viewModelSignal = signal(const CreateLinkViewModel());

  CreateLinkViewModel get viewModel => viewModelSignal.value;

  void updateUrl(String value) =>
      viewModelSignal.value = viewModelSignal.value.copyWith(
        url: value,
        status: const InitialStatus(),
      );

  Future<void> createLink() async {
    if (viewModelSignal.value.status.isLoading) return;

    viewModelSignal.value = viewModelSignal.value.copyWith(
      status: const LoadingStatus(),
    );

    try {
      final result = await celest.functions.links.createLink(
        LinkRequest(originalUrl: viewModelSignal.value.url),
      );
      final hasSavedLocally = await _linksLocalDataService.saveLink(result);

      if (!hasSavedLocally) {
        viewModelSignal.value = viewModelSignal.value.copyWith(
          status: ErrorStatus(
            'Failed to save a link for ${viewModelSignal.value.url}',
          ),
        );
      }

      viewModelSignal.value = viewModelSignal.value.copyWith(
        status: const LoadedStatus(),
      );
    } catch (e) {
      log(e.toString());

      viewModelSignal.value = viewModelSignal.value.copyWith(
        status: ErrorStatus(
          'Failed to generate a link for ${viewModelSignal.value.url}',
        ),
      );
    }
  }
}

class CreateLinkViewModel extends Equatable {
  const CreateLinkViewModel({
    this.url = '',
    this.status = const InitialStatus(),
  });

  final String url;
  final BaseStatus<CreateLinkViewModel> status;

  CreateLinkViewModel copyWith({
    String? url,
    BaseStatus<CreateLinkViewModel>? status,
  }) =>
      CreateLinkViewModel(
        url: url ?? this.url,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [url, status];
}
