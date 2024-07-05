
import 'package:fpdart/src/either.dart';
import 'package:twitch_clone/core/entites/user.dart';

import 'package:twitch_clone/core/error/failures.dart';
import 'package:twitch_clone/core/model/user_model.dart';
import 'package:twitch_clone/features/auth/data/datasource/auth_datasource.dart';

import '../../../../core/error/exceptions.dart';
import '../../domin/repository/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository{
  final AuthDatasource datasource;

  AuthRepositoryImp(this.datasource);

  @override
  Future<Either<Failures, UserModel>> signUp(String email, String name, String password) async {
    try {
      final temp = await datasource.signUp(email, password,name);
      return right(temp);

    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }

  @override
  Future<Either<Failures, User>> signIn(String email, String password) async {
    try {
      final temp = await datasource.signIn(email, password);
      return right(temp);

    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }  }

  @override
  Future<Either<Failures, User>> currentUser() async {
    try {

      final user = await datasource.getCurrentUserData();
      if(user==null){
        return left(Failures("User is not logged in!"));

      }
      return Right(user);

    }
    on ServerExcepiton catch(e){
      return left(Failures(e.massage));

    }
  }

}