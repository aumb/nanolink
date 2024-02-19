import 'package:equatable/equatable.dart';

class Link extends Equatable {
  const Link({
    required this.id,
    required this.originalUrl,
    required this.shortenedUrl,
    required this.createAt,
    this.userId,
  });

  final int id;
  final String? userId;
  final String originalUrl;
  final String shortenedUrl;
  final DateTime createAt;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        id: json['id'],
        userId: json['user_id'],
        originalUrl: json['original_url'],
        shortenedUrl: json['shortened_url'],
        createAt: DateTime.parse(json['created_at']!),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'original_url': originalUrl,
        'shortened_url': shortenedUrl,
        'created_at': createAt.toIso8601String(),
        'user_id': userId,
      };

  @override
  List<Object?> get props => [
        id,
        originalUrl,
        shortenedUrl,
        createAt,
        userId,
      ];
}

class LinkRequest extends Equatable {
  const LinkRequest({
    required this.originalUrl,
    this.shortenedUrl,
    this.userId,
  });

  final String originalUrl;
  final String? shortenedUrl;
  final String? userId;

  factory LinkRequest.fromJson(Map<String, dynamic> json) => LinkRequest(
        originalUrl: json['original_url'],
        shortenedUrl: json['shortened_url'],
        userId: json['user_id'],
      );

  LinkRequest copyWith({
    String? originalUrl,
    String? shortenedUrl,
    String? userId,
  }) =>
      LinkRequest(
        originalUrl: originalUrl ?? this.originalUrl,
        shortenedUrl: shortenedUrl ?? this.shortenedUrl,
        userId: userId ?? this.userId,
      );

  Map<String, dynamic> toJson() => {
        'original_url': originalUrl,
        if (userId != null) 'user_id': userId,
        if (shortenedUrl != null) 'shortened_url': shortenedUrl,
      };

  @override
  List<Object?> get props => [
        originalUrl,
        shortenedUrl,
        userId,
      ];
}
