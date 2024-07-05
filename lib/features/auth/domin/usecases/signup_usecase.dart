import 'package:fpdart/src/either.dart';

import '../../../../core/entites/user.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class SignUpUsecase implements Usecase<User,SignUpParams>{
  AuthRepository authRepository;

  SignUpUsecase(this.authRepository);

  @override
  Future<Either<Failures, User>> call(SignUpParams params) async {
    return await authRepository.signUp(params.email, params.name,params.password);
  }

}

class SignUpParams{
  final String email;
  final String password;
  final String name;

  const SignUpParams({
    required this.email,
    required this.password,
    required this.name,

  });

}