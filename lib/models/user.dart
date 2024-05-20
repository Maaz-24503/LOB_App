class Users {
  final String email;
  final String firstName;
  final String lastName;
  final Role role;

  Users(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.role});

  // Convert a User object to a JSON map
  Map<String, dynamic> toJSON() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'role': role.toString().split('.').last // Convert enum to string
    };
  }

  // Convert a JSON map to a User object
  factory Users.fromJSON(Map<String, dynamic> json) {
    return Users(
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      role: Role.values
          .firstWhere((e) => e.toString().split('.').last == json['role']),
    );
  }
}

enum Role { admin, user }
