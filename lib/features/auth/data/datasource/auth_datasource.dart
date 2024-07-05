import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitch_clone/core/model/user_model.dart';

import '../../../../core/error/exceptions.dart';

abstract interface class AuthDatasource {
  Future<UserModel> signUp(String email, String password, String name);

  Future<UserModel> signIn(String email, String password);

  Future<UserModel?> getCurrentUserData();
}

class AuthDatasourceImp implements AuthDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  String? get currentUser => firebaseAuth.currentUser?.uid;

  AuthDatasourceImp({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  @override
  Future<UserModel> signUp(String email, String password, String name) async {
    try {
      UserCredential credential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        UserModel userModel = UserModel(
            name: name,
            email: email,
            id: credential.user!.uid,);
        await firebaseFirestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(userModel.toMap());
        return userModel;
      } else {
        throw const ServerExcepiton(massage: "User is Null");
      }
    } on FirebaseAuthException catch (e) {
      throw ServerExcepiton(massage: e.message ?? "SomeThing Happend");
    } catch (e) {
      throw ServerExcepiton(massage: e.toString());
    }
  }

  @override
  Future<UserModel> signIn(String email, String password) async {
    try {
      UserCredential credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        UserModel? userModel = await getCurrentUserData();

        return userModel!;
      } else {
        throw const ServerExcepiton(massage: "User is Null");
      }
    } on FirebaseAuthException catch (e) {
      throw ServerExcepiton(massage: e.message ?? "SomeThing Happend");
    } catch (e) {
      throw ServerExcepiton(massage: e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUser != null) {
        final userData =
            await firebaseFirestore.collection('users').doc(currentUser).get();

        return UserModel.fromMap(userData.data()!);
      }
      return null;
    } on FirebaseAuthException catch (e) {
      throw ServerExcepiton(
        massage: e.message ?? " Something Happend !!",
      );
    }
  }
}
