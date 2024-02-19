import 'package:equatable/equatable.dart';

class Click extends Equatable {
  const Click({
    required this.id,
    required this.linkId,
    required this.createAt,
  });

  final int id;
  final int linkId;
  final DateTime createAt;

  factory Click.fromJson(Map<String, dynamic> json) => Click(
        id: json['id'],
        linkId: json['link_id'],
        createAt: DateTime.parse(json['created_at']!),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'link_id': linkId,
        'created_at': createAt.toIso8601String(),
      };

  @override
  List<Object?> get props => [id, linkId, createAt];
}

class ClickRequest extends Equatable {
  const ClickRequest({
    required this.linkId,
  });

  final int linkId;

  factory ClickRequest.fromJson(Map<String, dynamic> json) => ClickRequest(
        linkId: json['link_id'],
      );

  Map<String, dynamic> toJson() => {
        'link_id': linkId,
      };

  @override
  List<Object?> get props => [linkId];
}
