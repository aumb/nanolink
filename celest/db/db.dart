import 'package:supabase/supabase.dart';

SupabaseClient db(String supabaseUrl, String supabaseKey) => SupabaseClient(
      supabaseUrl,
      supabaseKey,
    );
