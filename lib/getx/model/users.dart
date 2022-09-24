class Users {
  int id;
  String nickname;
  String imageUrl;
  List<String> roles;

//<editor-fold desc="Data Methods">

  Users({
    required this.id,
    required this.nickname,
    required this.imageUrl,
    required this.roles,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Users &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          nickname == other.nickname &&
          imageUrl == other.imageUrl &&
          roles == other.roles);

  @override
  int get hashCode =>
      id.hashCode ^ nickname.hashCode ^ imageUrl.hashCode ^ roles.hashCode;

  @override
  String toString() {
    return 'Users{' +
        ' id: $id,' +
        ' nickname: $nickname,' +
        ' imageUrl: $imageUrl,' +
        ' roles: $roles,' +
        '}';
  }

  Users copyWith({
    int? id,
    String? nickname,
    String? imageUrl,
    List<String>? roles,
  }) {
    return Users(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      imageUrl: imageUrl ?? this.imageUrl,
      roles: roles ?? this.roles,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nickname': nickname,
      'imageUrl': imageUrl,
      'roles': roles,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      id: map['id'] as int,
      nickname: map['nickname'] as String,
      imageUrl: map['imageUrl'] as String,
      roles: List<String>.from(map['roles'])
    );
  }

//</editor-fold>
}