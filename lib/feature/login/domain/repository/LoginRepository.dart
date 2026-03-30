
import '../../data/model/login_request.dart';

class LoginRepository {
  Future<bool> login(LoginRequest request) async {
    await Future.delayed(const Duration(seconds: 1));

    if (request.email == 'test@nyl.com' &&
        request.password == '123456') {
      return true;
    } else {
      throw Exception('Invalid email or password');
    }
  }
}