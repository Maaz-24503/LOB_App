class Player {
  final String firstName;
  final String lastName;
  final String age;
  final String height;
  final int jerseyNumber;
  Player(
      {required this.firstName,
      required this.lastName,
      required this.age,
      required this.height,
      required this.jerseyNumber});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
        firstName: json['firstName'],
        lastName: json['lastName'],
        age: json['age'],
        height: json['height'],
        jerseyNumber: json['jerseyNumber']);
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'height': height,
      'jerseyNumber': jerseyNumber
    };
  }
}
