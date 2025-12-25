class UserDocModel {
  final String name;
  final String url;

  const UserDocModel({
    required this.name,
    required this.url,
  });

  factory UserDocModel.fromJson(Map<String, dynamic> json) {
    return UserDocModel(
      name: json['name'] as String? ?? '',
      url: json['url'] as String? ?? '',
    );
  }
}
