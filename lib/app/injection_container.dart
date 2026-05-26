import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/login_use_case.dart';
import '../features/auth/domain/usecases/signup_use_case.dart';
import '../features/auth/domain/usecases/login_with_google_use_case.dart';
import '../features/auth/data/datasources/auth_remote_data_source.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/presentation/controllers/auth_controller.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Thư viện bên ngoài
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl<FirebaseAuth>(), sl<GoogleSignIn>()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthRemoteDataSource>()),
  );

  // Use Cases
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton<LoginWithGoogleUseCase>(() => LoginWithGoogleUseCase(sl<AuthRepository>()));

  // Controllers
  sl.registerLazySingleton<AuthController>(
    () => AuthController(
      loginUseCase: sl<LoginUseCase>(),
      signUpUseCase: sl<SignUpUseCase>(),
      loginWithGoogleUseCase: sl<LoginWithGoogleUseCase>(),
    ),
  );
}
