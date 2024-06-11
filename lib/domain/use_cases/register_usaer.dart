import '../entities/user.dart';
import '../../infrastructure/auth/firebase_auth_service.dart';

class RegisterUser {
  final FirebaseAuthService _authService;

  RegisterUser(this._authService);

  Future<void> execute(User user) async {
    return await _authService.registerWithEmailAndPassword(user.email, user.password);
  }
}
