class Users {
  int id;
  String nickname;
  String? gender;
  String? birthDay;
  String? imageUrl;
  List<String> roles;

//<editor-fold desc="Data Methods">

  Users({
    required this.id,
    required this.nickname,
    this.gender,
    this.birthDay,
    this.imageUrl,
    required this.roles,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Users &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          nickname == other.nickname &&
          gender == other.gender &&
          birthDay == other.birthDay &&
          imageUrl == other.imageUrl &&
          roles == other.roles);

  @override
  int get hashCode =>
      id.hashCode ^
      nickname.hashCode ^
      gender.hashCode ^
      birthDay.hashCode ^
      imageUrl.hashCode ^
      roles.hashCode;

  @override
  String toString() {
    return 'Users{' +
        ' id: $id,' +
        ' nickname: $nickname,' +
        ' gender: $gender,' +
        ' birthDay: $birthDay,' +
        ' imageUrl: $imageUrl,' +
        ' roles: $roles,' +
        '}';
  }

  Users copyWith({
    int? id,
    String? nickname,
    String? gender,
    String? birthDay,
    String? imageUrl,
    List<String>? roles,
  }) {
    return Users(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      gender: gender ?? this.gender,
      birthDay: birthDay ?? this.birthDay,
      imageUrl: imageUrl ?? this.imageUrl,
      roles: roles ?? this.roles,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'nickname': this.nickname,
      'gender': this.gender,
      'birthDay': this.birthDay,
      'imageUrl': this.imageUrl,
      'roles': this.roles,
    };
  }

  factory Users.fromMap(dynamic map) {
    return Users(
      id: map['id'] as int,
      nickname: map['nickname'] as String,
      gender: map['gender'] as String?,
      birthDay: map['birthDay'] as String?,
      imageUrl: map['imageUrl'] as String?,
      roles: List<String>.from(map['roles']),
    );
  }

//</editor-fold>
}