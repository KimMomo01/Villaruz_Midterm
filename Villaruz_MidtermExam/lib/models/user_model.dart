class UserProfile {
  final String id;
  final String? fullName;
  final String? email;
  final DateTime? createdAt;

  UserProfile({
    required this.id,
    this.fullName,
    this.email,
    this.createdAt,
  });

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'] ?? '',
      fullName: map['full_name'],
      email: map['email'],
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
    );
  }
}
