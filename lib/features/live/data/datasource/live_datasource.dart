import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:twitch_clone/core/error/exceptions.dart';
import 'package:twitch_clone/core/model/live_stream_data_model.dart';
import 'package:twitch_clone/core/secrets/app_secret.dart';
import 'package:twitch_clone/features/live/data/model/chat_model.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import '../../../../core/utils/enum.dart';

abstract interface class LiveDatasource {
  Future<String> uploadImage(
      {required File image, required String uuid, required childname});

  Future<LiveStreamDataModel> uploadLiveStreamData(String title,
      String description, String imageUrl, String userUid, String username);

  Future<String> getToken(String channelId, String uid, AgoraRole role);

  Future<void> endLiveStream(String channelId);

  Future<void> updateViewCount(String id, bool isIncrease);

  Future<void> uploadChatComment(
      String message, String uid, String username, String channelId);
  
  Stream<List<ChatModel>> getChatCommentsive(String channelId);


}

class LiveDatasourceImp implements LiveDatasource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  const LiveDatasourceImp({
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });

  @override
  Future<String> uploadImage(
      {required File image, required String uuid, required childname}) async {
    try {
      Reference ref = await firebaseStorage.ref().child(childname).child(uuid);
      UploadTask uploadTask = ref.putData(
        image.readAsBytesSync(),
        SettableMetadata(
          contentType: 'image/jpg',
        ),
      );
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      throw ServerExcepiton(massage: e.toString());
    } catch (e) {
      throw ServerExcepiton(massage: e.toString());
    }
  }

  @override
  Future<LiveStreamDataModel> uploadLiveStreamData(
      String title,
      String description,
      String imageUrl,
      String userUid,
      String username) async {
    try {
      var uuid = const Uuid();
      String channelId = uuid.v4();

      LiveStreamDataModel liveStreamDataModel = LiveStreamDataModel(
        title: title,
        image: imageUrl,
        uid: userUid,
        username: username,
        startedAt: DateTime.now(),
        viewers: 0,
        channelId: channelId,
        description: description,
      );
      await firebaseFirestore
          .collection('livestream')
          .doc(channelId)
          .set(liveStreamDataModel.toMap());
      return liveStreamDataModel;
    } on FirebaseException catch (e) {
      throw ServerExcepiton(massage: e.toString());
    } catch (e) {
      throw ServerExcepiton(massage: e.toString());
    }
  }

  @override
  Future<String> getToken(String channelId, String uid, AgoraRole role) async {
    try {
      final res = await http.get(Uri.parse('${AppSecret.tokenServerUrl}/rtc/$channelId/${role.name}/userAccount/$uid/'));
      if (res.statusCode == 200) {
        var token = res.body;
        token = jsonDecode(token)['rtcToken'];
        return token;
      } else {
        throw const ServerExcepiton(massage: "Failed to fetch the token");
      }
    } catch (e) {
      throw const ServerExcepiton(massage: "Failed to fetch the token");
    }
  }

  @override
  Future<void> endLiveStream(String channelId) async {
    try {
      QuerySnapshot snap = await firebaseFirestore
          .collection('livestream').doc(channelId)
          .collection('comments')
          .get();

      for (int i = 0; i < snap.docs.length; i++) {
        await firebaseFirestore
            .collection('livestream')
            .doc(channelId)
            .collection('comments')
            .doc(
          ((snap.docs[i].data()! as dynamic)['commentId']),
        )
            .delete();


      }
      await firebaseFirestore.collection('livestream').doc(channelId).delete();
    } catch (e) {
      throw const ServerExcepiton(massage: "Failed to fetch the token");
    }
  }

  @override
  Future<void> updateViewCount(String id, bool isIncrease) async {
    try {
      await firebaseFirestore.collection('livestream').doc(id).update({
        'viewers': FieldValue.increment(isIncrease ? 1 : -1),
      });
    } catch (e) {
      throw const ServerExcepiton(massage: "Failed To Update the ViewersNumber");
    }
  }

  @override
  Future<void> uploadChatComment(
      String message, String uid, String username, String channelId) async {
    try {
      String commentId = const Uuid().v1();
      await firebaseFirestore
          .collection('livestream')
          .doc(channelId)
          .collection('comments')
          .doc(commentId)
          .set(ChatModel(
                  username: username,
                  message: message,
                  uid: uid,
                  createdAt: DateTime.now(),
                  commentId: commentId)
              .toMap());
    } on FirebaseException catch (e) {
      throw ServerExcepiton(massage:e.message??" ");

    }

    catch (e) {
      throw ServerExcepiton(massage: e.toString());
    }
  }

  @override
  Stream<List<ChatModel>> getChatCommentsive(String channelId)  {
    return firebaseFirestore
        .collection("livestream").doc(channelId).collection('comments').orderBy('createdAt', descending: true)

        .snapshots()
        .map((snapshot){
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() ;
        return ChatModel.fromMap(data);
      }).toList();

    });
  }


}
