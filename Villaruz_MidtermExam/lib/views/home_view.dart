import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../models/user_model.dart';
import 'login_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final AuthController _authController = AuthController();
  late Future<UserProfile?> _userProfileFuture;

  @override
  void initState() {
    super.initState();
    _userProfileFuture = _authController.fetchUserProfile();
  }

  void _logout() async {
    await _authController.signOut();
    if (!mounted) return;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const LoginView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
              onPressed: _logout,
              icon: const Icon(Icons.logout),
              tooltip: 'Logout')
        ],
      ),
      body: FutureBuilder<UserProfile?>(
        future: _userProfileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final profile = snapshot.data;
          final email = profile?.email ??
              _authController.currentUser?.email ??
              'user@example.com';
          final fullName = profile?.fullName ?? 'Authenticated User';

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                      radius: 50, child: Icon(Icons.person, size: 50)),
                  const SizedBox(height: 24),
                  const Text('Welcome!',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text(fullName,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Text(email, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 200,
                    height: 48,
                    child: OutlinedButton.icon(
                        onPressed: _logout,
                        icon: const Icon(Icons.logout),
                        label: const Text('Logout')),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
