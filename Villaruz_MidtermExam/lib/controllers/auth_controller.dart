import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:villaruz_midtermexam/models/user_model.dart';

class AuthController {
  final SupabaseClient _supabase = Supabase.instance.client;

  User? get currentUser => _supabase.auth.currentUser;

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {'full_name': fullName},
    );
    if (response.user == null) throw 'Registration failed.';
  }

  Future<void> signIn({required String email, required String password}) async {
    final response = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    if (response.user == null) throw 'Invalid login credentials.';
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  Future<UserProfile?> fetchUserProfile() async {
    try {
      final user = currentUser;
      if (user == null) return null;
      final data =
          await _supabase.from('profiles').select().eq('id', user.id).single();
      return UserProfile.fromMap(data);
    } catch (e) {
      final user = currentUser;
      if (user != null) {
        return UserProfile(
          id: user.id,
          email: user.email,
          fullName: user.userMetadata?['full_name'],
        );
      }
      return null;
    }
  }
}
