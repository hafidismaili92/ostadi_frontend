class Loginparams {
  final String email;
  final String password;

  Loginparams({required this.email, required this.password});

  Map<String,dynamic> toJson()
  {
    return {
      "email":email,
      "password":password
    };
  }
}