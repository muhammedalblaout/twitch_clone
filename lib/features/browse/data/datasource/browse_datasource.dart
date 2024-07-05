import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twitch_clone/core/error/exceptions.dart';
import 'package:twitch_clone/core/model/live_stream_data_model.dart';

abstract interface class BrowseDatasource {
  Stream<List<LiveStreamDataModel>> getCurrentLive();
}

class BrowseDatasourceImp implements BrowseDatasource {
  final FirebaseFirestore firebaseFirestore;

  BrowseDatasourceImp(this.firebaseFirestore);

  @override
  Stream<List<LiveStreamDataModel>> getCurrentLive() {
    try {
      return firebaseFirestore
          .collection("livestream")
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data();
          return LiveStreamDataModel.fromMap(data);
        }).toList();
      });
    } catch (e) {
      throw ServerExcepiton(massage: e.toString());
    }
  }
}
