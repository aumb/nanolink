// ignore_for_file: type=lint, unused_local_variable, unnecessary_cast, unnecessary_import

import 'package:celest/celest.dart';
import 'package:celest_backend/src/clicks/models.dart';
import 'package:celest_backend/src/links/exceptions.dart';
import 'package:celest_backend/src/links/models.dart';

final class ClickSerializer extends Serializer<Click> {
  const ClickSerializer();

  @override
  Click deserialize(Object? value) {
    final serialized = assertWireType<Map<String, dynamic>>(value);
    return Click.fromJson(serialized);
  }

  @override
  Map<String, dynamic> serialize(Click value) => value.toJson();
}

final class ClickRequestSerializer extends Serializer<ClickRequest> {
  const ClickRequestSerializer();

  @override
  ClickRequest deserialize(Object? value) {
    final serialized = assertWireType<Map<String, dynamic>>(value);
    return ClickRequest.fromJson(serialized);
  }

  @override
  Map<String, dynamic> serialize(ClickRequest value) => value.toJson();
}

final class LinkSerializer extends Serializer<Link> {
  const LinkSerializer();

  @override
  Link deserialize(Object? value) {
    final serialized = assertWireType<Map<String, dynamic>>(value);
    return Link.fromJson(serialized);
  }

  @override
  Map<String, dynamic> serialize(Link value) => value.toJson();
}

final class LinkRequestSerializer extends Serializer<LinkRequest> {
  const LinkRequestSerializer();

  @override
  LinkRequest deserialize(Object? value) {
    final serialized = assertWireType<Map<String, dynamic>>(value);
    return LinkRequest.fromJson(serialized);
  }

  @override
  Map<String, dynamic> serialize(LinkRequest value) => value.toJson();
}

final class InvalidLinkDataExceptionSerializer
    extends Serializer<InvalidLinkDataException> {
  const InvalidLinkDataExceptionSerializer();

  @override
  InvalidLinkDataException deserialize(Object? value) {
    final serialized = assertWireType<Map<String, Object?>?>(value);
    return InvalidLinkDataException();
  }

  @override
  Map<String, Object?> serialize(InvalidLinkDataException value) => {};
}

final class CreateLinkExceptionSerializer
    extends Serializer<CreateLinkException> {
  const CreateLinkExceptionSerializer();

  @override
  CreateLinkException deserialize(Object? value) {
    final serialized = assertWireType<Map<String, Object?>?>(value);
    return CreateLinkException();
  }

  @override
  Map<String, Object?> serialize(CreateLinkException value) => {};
}

final class DeleteLinkExceptionSerializer
    extends Serializer<DeleteLinkException> {
  const DeleteLinkExceptionSerializer();

  @override
  DeleteLinkException deserialize(Object? value) {
    final serialized = assertWireType<Map<String, Object?>?>(value);
    return DeleteLinkException();
  }

  @override
  Map<String, Object?> serialize(DeleteLinkException value) => {};
}
