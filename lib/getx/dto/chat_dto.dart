class ChatDto {
  String userToken;
  String text;
  int receivedUserId;
  String createdAt;

//<editor-fold desc="Data Methods">

  ChatDto({
    required this.userToken,
    required this.text,
    required this.receivedUserId,
    required this.createdAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatDto &&
          runtimeType == other.runtimeType &&
          userToken == other.userToken &&
          text == other.text &&
          receivedUserId == other.receivedUserId &&
          createdAt == other.createdAt);

  @override
  int get hashCode =>
      userToken.hashCode ^
      text.hashCode ^
      receivedUserId.hashCode ^
      createdAt.hashCode;

  @override
  String toString() {
    return 'ChatDto{' +
        ' userToken: $userToken,' +
        ' text: $text,' +
        ' receivedUserId: $receivedUserId,' +
        ' createdAt: $createdAt,' +
        '}';
  }

  ChatDto copyWith({
    String? userToken,
    String? text,
    int? receivedUserId,
    String? createdAt,
  }) {
    return ChatDto(
      userToken: userToken ?? this.userToken,
      text: text ?? this.text,
      receivedUserId: receivedUserId ?? this.receivedUserId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userToken': this.userToken,
      'text': this.text,
      'receivedUserId': this.receivedUserId,
      'createdAt': this.createdAt,
    };
  }

  factory ChatDto.fromMap(Map<String, dynamic> map) {
    return ChatDto(
      userToken: map['userToken'] as String,
      text: map['text'] as String,
      receivedUserId: map['receivedUserId'] as int,
      createdAt: map['createdAt'] as String,
    );
  }

//</editor-fold>
}