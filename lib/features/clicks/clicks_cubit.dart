import 'dart:developer';

import 'package:celest_backend/client.dart';
import 'package:celest_backend/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanolink/app/base_status.dart';

class ClicksCubit extends Cubit<ClicksViewModel> {
  ClicksCubit() : super(const ClicksViewModel());

  void init(Link link) {
    emit(state.copyWith(linkId: link.id));
    getClicks();
  }

  Future<void> getClicks() async {
    if (state.status.isLoading) return;

    emit(state.copyWith(status: const LoadingStatus()));

    try {
      final result =
          await celest.functions.clicks.getClicksNumber(state.linkId);

      emit(state.copyWith(clickNumber: result, status: const LoadedStatus()));
    } catch (e) {
      log(e.toString());

      emit(
        state.copyWith(
          status: ErrorStatus(
            'Failed to fetch click for link ${state.linkId}',
          ),
        ),
      );
    }
  }
}

class ClicksViewModel extends Equatable {
  const ClicksViewModel({
    this.linkId = -1,
    this.clickNumber = 0,
    this.status = const InitialStatus(),
  });

  final int linkId;
  final int clickNumber;
  final BaseStatus<ClicksViewModel> status;

  ClicksViewModel copyWith({
    int? linkId,
    int? clickNumber,
    BaseStatus<ClicksViewModel>? status,
  }) =>
      ClicksViewModel(
        linkId: linkId ?? this.linkId,
        clickNumber: clickNumber ?? this.clickNumber,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [linkId, clickNumber, status];
}
