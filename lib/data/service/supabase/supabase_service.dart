import 'dart:async';

import 'package:chat_app/data/service/supabase/app_supabase_client.dart';
import 'package:chat_app/data/service/supabase/app_supabase_client_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

class SupabaseService {
  static AppSupabaseClient get client => AppSupabaseClientImpl(
    auth: FirebaseAuth.instance,
    client: Supabase.instance.client,
  );

  static Future<void> init({
    required String url,
    required String anonKey,
  }) async {
    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
      accessToken: () async {
        final token = await FirebaseAuth.instance.currentUser?.getIdToken();
        return token;
      },
    );
  }
}
