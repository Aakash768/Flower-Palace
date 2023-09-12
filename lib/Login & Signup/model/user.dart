class User {
  int users_id;
  String user_name;
  String user_email;
  String user_password;

  // Named constructor for creating a User object from a map
  User.fromJson(Map<String, dynamic> json)
      : users_id = json['users_id'],
        user_name = json['user_name'],
        user_email = json['user_email'],
        user_password = json['user_password'];

  // Named constructor for creating a User object with provided values
  User({
    required this.users_id,
    required this.user_name,
    required this.user_email,
    required this.user_password,
  });

  // Convert User object to a map
  Map<String, dynamic> toJson() => {
    'users_id': users_id,
    'user_name': user_name,
    'user_email': user_email,
    'user_password': user_password,
  };
}
