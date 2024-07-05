import 'package:fpdart/fpdart.dart';
import 'package:twitch_clone/core/entites/user.dart';
import 'package:twitch_clone/core/error/failures.dart';

abstract interface class AuthRepository{
  Future<Either<Failures,User>> signUp(String email, String name, String password);
  Future<Either<Failures,User>> signIn(String email,  String password);
  Future<Either<Failures,User>> currentUser();


}