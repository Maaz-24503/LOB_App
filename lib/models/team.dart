
class Team{
  final String name;
  final String? namedLogo;
  final String? namelessLogo;

  // Constructor
  Team({
    required this.name,
    this.namedLogo,
    this.namelessLogo,
  });

  // fromJson method to create an instance of Team from a map
  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      name: json['name'] as String,
      namedLogo: json['namedLogo'] as String?,
      namelessLogo: json['namelessLogo'] as String?,
    );
  }

  // toJson method to convert an instance of Team to a map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'namedLogo': namedLogo,
      'namelessLogo': namelessLogo,
    };
  }
}
