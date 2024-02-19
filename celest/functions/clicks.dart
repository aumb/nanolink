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
