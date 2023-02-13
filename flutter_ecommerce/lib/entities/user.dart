class User {
  const User({
    required this.id,
    required this.displayName,
    required this.email,
    required this.token,
  });
  final int id;
  final String displayName;
  final String email;
  final String token;
}
