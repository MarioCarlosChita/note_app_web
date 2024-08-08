import 'package:supabase_flutter/supabase_flutter.dart';

import '../../module/auth/data/models/user_model.dart';

class GuardRouteService {
  static UserModel? currentUser;
  static bool isUserAuthenticated = false;

  static Future<void> fetchUserSession() async {
    final SupabaseClient client = Supabase.instance.client;
    final Session? session = client.auth.currentSession;
    User? user = session?.user;
    isUserAuthenticated = user != null;

    if (user != null) {
      final List<Map<String, dynamic>> data = await client
          .from('user_tb')
          .select('id,userId,name')
          .eq('userId', user.id);

      currentUser = UserModel(
        id: user.id,
        appMetadata: user.appMetadata,
        userMetadata: user.userMetadata,
        aud: user.aud,
        createdAt: user.createdAt,
        name: data.first['name'] as String? ?? '',
        userId: data.first['userId'] as String? ?? '',
      );
    }
    return;
  }
}
