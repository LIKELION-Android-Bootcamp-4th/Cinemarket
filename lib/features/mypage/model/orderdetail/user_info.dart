class UserInfo {
  final String id;
  final String nickName;
  final String email;
  final String name;

  UserInfo({
    required this.id,
    required this.nickName,
    required this.email,
    required this.name,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'] as String,
      nickName: json['nickName'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
    );
  }
}