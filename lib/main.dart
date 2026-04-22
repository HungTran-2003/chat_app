import 'package:chat_app/app.dart';
import 'package:chat_app/core/configs/app_configs.dart';
import 'package:chat_app/data/service/supabase/supabase_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SupabaseService.init(
    url: AppConfigs.supabaseUrl,
    anonKey: AppConfigs.supabaseAnonKey,
  );

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}