import 'package:celest_backend/models.dart';

import '../db/db.dart';
import '../resources.dart';

const _clicksTableName = 'clicks';

Future<int> getClicksNumber(
  int linkId,
  @env.supabaseUrl String supabaseUrl,
  @env.supabaseKey String supabaseKey,
) async {
  final result = await db(supabaseUrl, supabaseKey)
      .from(_clicksTableName)
      .select()
      .eq('link_id', linkId);

  return result.length;
}

Future<Click> addClick(
  ClickRequest clickRequest,
  @env.supabaseUrl String supabaseUrl,
  @env.supabaseKey String supabaseKey,
) async {
  final result = await db(supabaseUrl, supabaseKey)
      .from(_clicksTableName)
      .insert(clickRequest.toJson())
      .select();

  return Click.fromJson(result.first);
}
