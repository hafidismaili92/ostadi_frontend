class RegiteredUser {
  String email;
  String password;
  bool isStudent;
  String name;
  List<String> subjects;
  String level;
  RegiteredUser(
      {this.email = "",
      this.password = "",
      this.isStudent = true,
      this.name = "",
      this.subjects = const [],
      this.level = ""});

  RegiteredUser copyWith(
      {String? email,
      String? password,
      bool? isStudent,
      String? name,
      List<String>? subjects,
      String? level}) {
    return RegiteredUser(
        email: email ?? this.email,
        password: password ?? this.password,
        isStudent: isStudent ?? this.isStudent,
        name: name ?? this.name,
        subjects: subjects ?? this.subjects,
        level: level ?? this.level);
  }
}
