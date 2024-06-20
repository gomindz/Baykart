class User {
  final String? id;
  final String org;
  final String fullname;
  final String phone;
  final bool? acceptedTerms;
  final String? token;
  String language;

  User({
    required this.org,
    required this.fullname,
    required this.phone,
    required this.language,
    this.acceptedTerms = true,
    this.token,
    this.id,
  });

  factory User.fromJson(Map<dynamic, dynamic> json) => User(
        id: json['id'],
        org: json['org'],
        fullname: json['fullname'],
        phone: json['phone'],
        language: json['lang'],
        token: json['token'],
        acceptedTerms: json['accepted_terms'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "org": org,
        "fullname": fullname,
        "phone": phone,
        "lang": language,
        "token": token,
        "accepted_terms": acceptedTerms,
      };
}
