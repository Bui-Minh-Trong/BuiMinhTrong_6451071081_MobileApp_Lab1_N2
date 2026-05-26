import 'package:firebase_auth/firebase_auth.dart' as fb;
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      final credential = await remoteDataSource.signInWithEmailAndPassword(email, password);
      if (credential.user != null) {
        return UserModel.fromFirebaseUser(credential.user!);
      } else {
        throw Exception('Đăng nhập thất bại: Tài khoản hoặc mật khẩu không đúng.');
      }
    } on fb.FirebaseException catch (e) {
      throw Exception(_mapFirebaseException(e));
    } catch (e) {
      throw Exception('Đã xảy ra lỗi kết nối. Vui lòng thử lại sau.');
    }
  }

  @override
  Future<UserEntity> signUp(String email, String password, String name) async {
    try {
      final credential = await remoteDataSource.signUpWithEmailAndPassword(email, password);
      if (credential.user != null) {
        await credential.user!.updateDisplayName(name);
        // Tải lại thông tin để cập nhật Display Name mới
        await credential.user!.reload();
        final updatedUser = fb.FirebaseAuth.instance.currentUser;
        return UserModel.fromFirebaseUser(updatedUser ?? credential.user!);
      } else {
        throw Exception('Đăng ký thất bại.');
      }
    } on fb.FirebaseException catch (e) {
      throw Exception(_mapFirebaseException(e));
    } catch (e) {
      throw Exception('Đã xảy ra lỗi kết nối. Vui lòng thử lại sau.');
    }
  }

  @override
  Future<UserEntity> loginWithGoogle() async {
    try {
      final credential = await remoteDataSource.signInWithGoogle();
      if (credential.user != null) {
        return UserModel.fromFirebaseUser(credential.user!);
      } else {
        throw Exception('Đăng nhập Google thất bại.');
      }
    } on fb.FirebaseException catch (e) {
      throw Exception(_mapFirebaseException(e));
    } catch (e) {
      if (e.toString().contains('ERROR_ABORTED_BY_USER')) {
        throw Exception('Đăng nhập Google bị hủy.');
      }
      throw Exception('Đã xảy ra lỗi kết nối. Vui lòng thử lại sau.');
    }
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.signOut();
  }

  String _mapFirebaseException(fb.FirebaseException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'Tài khoản không tồn tại.';
      case 'wrong-password':
        return 'Mật khẩu không đúng.';
      case 'email-already-in-use':
        return 'Email này đã được đăng ký cho tài khoản khác.';
      case 'invalid-email':
        return 'Định dạng email không hợp lệ.';
      case 'weak-password':
        return 'Mật khẩu quá yếu. Vui lòng chọn mật khẩu mạnh hơn.';
      case 'network-request-failed':
        return 'Lỗi kết nối mạng. Vui lòng kiểm tra lại đường truyền.';
      default:
        return e.message ?? 'Đã xảy ra lỗi không xác định trên Firebase.';
    }
  }
}
