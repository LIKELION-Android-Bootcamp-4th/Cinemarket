class CastMember {
  final String name;
  final String profilePath;
  final String character;

  CastMember({
    required this.name,
    required this.profilePath,
    required this.character,
  });

  factory CastMember.fromJson(Map<String, dynamic> json) {
    return CastMember(
      name: json['name'] ?? '',
      character: json['character'] ?? '',
      profilePath: json['profile_path'] ?? '',
    );
  }
}