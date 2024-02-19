import 'package:celest_backend/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanolink/app/base_status.dart';
import 'package:nanolink/features/links/services/links_local_data_service.dart';

class LinksCubit extends Cubit<LinksViewModel> {
  LinksCubit(this._linksLocalDataService) : super(const LinksViewModel());

  final LinksLocalDataService _linksLocalDataService;

  void fetchLinks() {
    emit(state.copyWith(links: _linksLocalDataService.savedLinks));
  }
}

class LinksViewModel extends Equatable {
  const LinksViewModel({
    this.links = const [],
    this.status = const InitialStatus(),
  });

  final List<Link> links;
  final BaseStatus<LinksViewModel> status;

  LinksViewModel copyWith({
    List<Link>? links,
    BaseStatus<LinksViewModel>? status,
  }) =>
      LinksViewModel(
        links: links ?? this.links,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [links, status];
}
