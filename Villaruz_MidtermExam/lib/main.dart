import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:villaruz_midtermexam/views/login_view.dart';
import 'package:villaruz_midtermexam/views/home_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://chddhtdijbvmqprolvrn.supabase.co',
    anonKey: 'sb_publishable_LaG8W5KZWeZtycLgn81f3Q_V3bp11MZ',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    final bool isLoggedIn = supabase.auth.currentSession != null;

    return MaterialApp(
      title: 'Supabase MVC Auth',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: isLoggedIn ? const HomeView() : const LoginView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
