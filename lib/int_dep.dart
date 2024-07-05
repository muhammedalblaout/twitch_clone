import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:twitch_clone/core/secrets/app_secret.dart';
import 'package:twitch_clone/features/auth/data/datasource/auth_datasource.dart';
import 'package:twitch_clone/features/auth/data/repository/auth_repository_imp.dart';
import 'package:twitch_clone/features/auth/domin/repository/auth_repository.dart';
import 'package:twitch_clone/features/auth/domin/usecases/signin_usecase.dart';
import 'package:twitch_clone/features/auth/domin/usecases/signup_usecase.dart';
import 'package:twitch_clone/features/browse/presentation/bloc/browse/browse_bloc.dart';
import 'package:twitch_clone/features/live/data/datasource/live_datasource.dart';
import 'package:twitch_clone/features/live/data/repository/live_repository_imp.dart';
import 'package:twitch_clone/features/live/domin/repository/live_repository.dart';
import 'package:twitch_clone/features/live/presentation/bloc/agora/agora_bloc.dart';
import 'package:twitch_clone/features/live/presentation/bloc/chat/chat_bloc.dart';
import 'package:twitch_clone/features/live/presentation/bloc/live_stream/live_stream_bloc.dart';

import 'core/commen/cubit/app_user/app_user_cubit.dart';
import 'features/auth/domin/usecases/current_user_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/browse/data/datasource/browse_datasource.dart';
import 'features/browse/data/repository/browser_repository_imp.dart';
import 'features/browse/domin/repository/browse_repository.dart';
import 'features/browse/domin/usecase/get_current_live_stream_usecase.dart';
import 'features/live/domin/usecase/end_live_stream_usecase.dart';
import 'features/live/domin/usecase/get_chat_comment_stream_usecase.dart';
import 'features/live/domin/usecase/get_token_usecase.dart';
import 'features/live/domin/usecase/live_stream_data_upload_usecase.dart';
import 'features/live/domin/usecase/update_viewer_number_usecase.dart';
import 'features/live/domin/usecase/upload_chat_comment_usecase.dart';

final serviceLocator = GetIt.instance;

Future<void> intDependcies() async {
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: AppSecret.apiKey,
          appId: AppSecret.appId,
          messagingSenderId: "",
          storageBucket: AppSecret.storageBucket,
          projectId: AppSecret.projectId));

  final userRef = FirebaseFirestore.instance;
  final authRef = FirebaseAuth.instance;
  final storageRef = FirebaseStorage.instance;
  intAuth();
  intlive();
  intBrowse();
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerLazySingleton(() => userRef);
  serviceLocator.registerLazySingleton(() => authRef);
  serviceLocator.registerLazySingleton(() => storageRef);
}

void intAuth() {
  serviceLocator.registerFactory<AuthDatasource>(() => AuthDatasourceImp(
      firebaseAuth: serviceLocator(), firebaseFirestore: serviceLocator()));

  serviceLocator.registerFactory<AuthRepository>(
      () => AuthRepositoryImp(serviceLocator()));

  serviceLocator.registerFactory(() => SignUpUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => SignInUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => CurrentUserUsecase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => AuthBloc(
      signUpUsecase: serviceLocator(),
      appUserCubit: serviceLocator(),
      signInUsecase: serviceLocator(),
      currentUserUsecase: serviceLocator()));
}

void intlive() {
  serviceLocator.registerFactory<LiveDatasource>(() => LiveDatasourceImp(
      firebaseFirestore: serviceLocator(), firebaseStorage: serviceLocator()));

  serviceLocator.registerFactory<LiveRepository>(
      () => LiveRepositoryImp(serviceLocator()));

  serviceLocator
      .registerFactory(() => LiveStreamDataUploadUsecase(serviceLocator()));

  serviceLocator.registerFactory(() => GetTokenUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => EndStreamUsecase(serviceLocator()));
  serviceLocator
      .registerFactory(() => UpdateViewerNumberUsecase(serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => LiveStreamBloc(liveStreamDataUploadUsecase: serviceLocator()));

  serviceLocator.registerFactory(() => AgoraBloc(
      getTokenUsecase: serviceLocator(),
      endStreamUsecase: serviceLocator(),
      updateViewerNumberUsecase: serviceLocator()));

  //Chat
  serviceLocator
      .registerFactory(() => UploadChatCommentUsecase(serviceLocator()));

  serviceLocator
      .registerFactory(() => GetChatCommentStreamUsecase(serviceLocator()));

  serviceLocator.registerFactory(() => ChatBloc(
      uploadChatCommentUsecase: serviceLocator(),
      getChatCommentStreamUsecase: serviceLocator()));
}

void intBrowse() {
  serviceLocator.registerFactory<BrowseDatasource>(
      () => BrowseDatasourceImp(serviceLocator()));

  serviceLocator.registerFactory<BrowseRepository>(
      () => BrowseRepositoryImp(serviceLocator()));

  serviceLocator
      .registerFactory(() => GetCurrentLiveStreamUsecase(serviceLocator()));

  serviceLocator.registerFactory(
      () => BrowseBloc(getCurrentLiveStreamUsecase: serviceLocator()));
}
