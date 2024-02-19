import 'dart:developer';

import 'package:celest_backend/client.dart';
import 'package:celest_backend/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanolink/app/base_status.dart';
import 'package:nanolink/features/links/services/links_local_data_service.dart';

class CreateLinkCubit extends Cubit<CreateLinkViewModel> {
  CreateLinkCubit(this._linksLocalDataService)
      : super(const CreateLinkViewModel());

  final LinksLocalDataService _linksLocalDataService;

  void updateUrl(String value) => emit(
        state.copyWith(status: const InitialStatus(), url: value),
      );

  Future<void> createLink() async {
    if (state.status.isLoading) return;

    emit(state.copyWith(status: const LoadingStatus()));

    try {
      final result = await celest.functions.links.createLink(
        LinkRequest(originalUrl: state.url),
      );
      final hasSavedLocally = await _linksLocalDataService.saveLink(result);

      if (!hasSavedLocally) {
        emit(
          state.copyWith(
            status: ErrorStatus(
              'Failed to save a link for ${state.url}',
            ),
          ),
        );
      }

      emit(state.copyWith(status: const LoadedStatus()));
    } catch (e) {
      log(e.toString());

      emit(
        state.copyWith(
          status: ErrorStatus(
            'Failed to generate a link for ${state.url}',
          ),
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
