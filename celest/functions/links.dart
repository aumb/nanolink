import 'package:celest_backend/models.dart';
import 'package:celest_backend/src/links/exceptions.dart';
import 'package:shortid/shortid.dart';
import '../db/db.dart';
import '../resources.dart';

const _linksTableName = 'links';

Future<List<Link>> getLinks(
  @env.supabaseUrl String supabaseUrl,
  @env.supabaseKey String supabaseKey,
) async {
  final result =
      await db(supabaseUrl, supabaseKey).from(_linksTableName).select();

  return result.map((e) => Link.fromJson(e)).toList();
}

Future<Link?> getLink(
  String id,
  @env.supabaseUrl String supabaseUrl,
  @env.supabaseKey String supabaseKey,
) async {
  final result = await db(supabaseUrl, supabaseKey)
      .from(_linksTableName)
      .select()
      .eq('shortened_url', id);

  return result.isNotEmpty ? Link.fromJson(result.first) : null;
}

Future<Link> createLink(
  LinkRequest linkRequest,
  @env.supabaseUrl String supabaseUrl,
  @env.supabaseKey String supabaseKey,
) async {
  final urlRegex = RegExp(
    r'^(?:http|https):\/\/[\w\-_]+(?:\.[\w\-_]+)+[\w\-.,@?^=%&:/~\\+#]*$',
  );

  final shouldThrow = linkRequest.originalUrl.isEmpty ||
      !urlRegex.hasMatch(linkRequest.originalUrl);

  if (shouldThrow) {
    throw InvalidLinkDataException();
  }

  final updatedLink = linkRequest.copyWith(
    shortenedUrl: shortid.generate(),
  );

  final result = await db(supabaseUrl, supabaseKey)
      .from(_linksTableName)
      .insert(updatedLink.toJson())
      .select();

  if (result.isEmpty) {
    throw CreateLinkException();
  }

  return Link.fromJson(result.first);
}

Future<Link> deleteLink(
  int id,
  @env.supabaseUrl String supabaseUrl,
  @env.supabaseKey String supabaseKey,
) async {
  final result = await db(supabaseUrl, supabaseKey)
      .from(_linksTableName)
      .delete()
      .eq('id', id)
      .select();

  if (result.isEmpty) {
    throw DeleteLinkException();
  }

  return Link.fromJson(result.first);
}
