import 'package:supabase_flutter/supabase_flutter.dart';

class AppSupabaseClient {
  SupabaseClient get supabase => Supabase.instance.client;
}
