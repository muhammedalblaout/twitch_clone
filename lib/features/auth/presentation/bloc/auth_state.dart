part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class AuthLoading extends AuthState {}
final class AuthSuccess extends AuthState {
  final User user;

  AuthSuccess(this.user);
}
final class AuthFail extends AuthState {
  final String massage;

  AuthFail(this.massage);
}
