import '../../domin/entites/chat.dart';

class ChatModel extends Chat {
  ChatModel(
      {required super.username,
      required super.message,
      required super.uid,
      required super.createdAt,
      required super.commentId});

  Map<String, dynamic> toMap() {
    return {
      'username': this.username,
      'message': this.message,
      'uid': this.uid,
      'createdAt': this.createdAt,
      'commentId': this.commentId,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      username: map['username'] ?? "",
      message: map['message'] ?? "",
      uid: map['uid'] ?? "",
      createdAt: map['createdAt'] ?? "",
      commentId: map['commentId'] ?? "",
    );
  }

}
