import 'package:note_app_web/core/utils/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseInitializeService {
  static Future<Supabase> initializeSupabase() async =>
      await Supabase.initialize(
        url: Constants.supabaseProjectUrl,
        anonKey: Constants.supabaseApiKey,
      );
}
