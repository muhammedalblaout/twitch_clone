import 'package:fpdart/src/either.dart';

import '../../../../core/entites/user.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class SignInUsecase implements Usecase<User,SignInParams>{
  AuthRepository authRepository;

  SignInUsecase(this.authRepository);

  @override
  Future<Either<Failures, User>> call(SignInParams params) async {
    return await authRepository.signIn(params.email,params.password);
  }

}

class SignInParams{
  final String email;
  final String password;

  const SignInParams({
    required this.email,
    required this.password,

  });

}