class logininfo {
  final String token;

  const logininfo({required this.token});

  factory logininfo.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'token': String token
      } =>
          logininfo(
            token: token
          ),
      _ => throw const FormatException('Problem  with logininfo/token'),
    };
  }
}