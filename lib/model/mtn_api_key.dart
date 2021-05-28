class JsonApiKey {
  String apiKey;

  JsonApiKey({
    this.apiKey,
  });

  factory JsonApiKey.fromJson(Map<String, dynamic> json) {
    return JsonApiKey(
      apiKey: json['apiKey'],
    );
  }
}

class JwtKey {
  String jwtKey;

  JwtKey({
    this.jwtKey,
  });

  factory JwtKey.fromJson(Map<String, dynamic> json) {
    return JwtKey(
      jwtKey: json['access_token'],
    );
  }
}
