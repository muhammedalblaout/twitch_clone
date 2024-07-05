import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:twitch_clone/core/error/failures.dart';
import 'package:twitch_clone/features/auth/domin/usecases/signin_usecase.dart';
import '../../../../core/commen/cubit/app_user/app_user_cubit.dart';
import '../../../../core/commen/cubit/app_user/app_user_state.dart';
import '../../../../core/entites/user.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domin/usecases/current_user_usecase.dart';
import '../../domin/usecases/signup_usecase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUsecase _signUpUsecase;
  final SignInUsecase _signInUsecase;
  final CurrentUserUsecase _currentUserUsecase;

  final AppUserCubit _appUserCubit;

  AuthBloc({
    required SignUpUsecase signUpUsecase,
    required SignInUsecase signInUsecase,
    required CurrentUserUsecase currentUserUsecase,

    required AppUserCubit appUserCubit,
  })  : _signUpUsecase = signUpUsecase,
        _signInUsecase = signInUsecase,
        _currentUserUsecase= currentUserUsecase,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) {

    });

    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      final res = await _signUpUsecase(SignUpParams(
          email: event.email, password: event.password, name: event.name));
      res.fold(
          (l) => emit(AuthFail(l.massage)), (r) => _emitAuthSuccess(r, emit));
    });

    on<SignInEvent>((event, emit) async {
      emit(AuthLoading());
      final res = await _signInUsecase(SignInParams(
          email: event.email, password: event.password));
      res.fold(
              (l) => emit(AuthFail(l.massage)), (r) => _emitAuthSuccess(r, emit));
    });

    on<AuthIsUserLoggedInEvent>((event, emit) async {
      emit(AuthLoading());
      _appUserCubit.emit(AppUserLoading());

      final res= await _currentUserUsecase(NoParams());

      res.fold((l) => _emitAuthFail(l, emit) ,
              (r) {
            _emitAuthSuccess(r,emit);
          }
      );
    });
  }


  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }

  void _emitAuthFail(Failures failures, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(null);
    emit(AuthFail(failures.massage));
  }
}
