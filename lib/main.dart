import 'package:chat_app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // màu nền status bar
      statusBarIconBrightness: Brightness.light, // icon trắng (Android)
      statusBarBrightness: Brightness.dark, // icon tối (iOS)
    ),
  );
  runApp(const MyApp());
}