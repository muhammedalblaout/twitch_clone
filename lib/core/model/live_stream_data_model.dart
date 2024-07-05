import '../entites/live_stream_data.dart';

class LiveStreamDataModel extends LiveStreamData {
  LiveStreamDataModel({
    required super.title,
    required super.image,
    required super.uid,
    required super.username,
    required super.startedAt,
    required super.viewers,
    required super.channelId,
    required super.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'uid': uid,
      'username': username,
      'viewers': viewers,
      'channelId': channelId,
      'startedAt': startedAt,
      'description':description,
    };
  }

  factory LiveStreamDataModel.fromMap(Map<String, dynamic> map) {
    return LiveStreamDataModel(
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      viewers: map['viewers']?.toInt() ?? 0,
      channelId: map['channelId'] ?? '',
      startedAt: map['startedAt'] ?? '',
      description: map['description'] ?? '',
    );
  }
}
