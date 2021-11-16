import 'package:http_interceptor/http_interceptor.dart';
import 'package:moj_student/data/auth/auth_repository.dart';

class TokenExpiredInterceptor extends RetryPolicy {
  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    if (response.statusCode == 403) {
      final authRepo = AuthRepository();
      try {
        await authRepo.login(null);
        return true;
      } catch (e) {
        return false;
      }
    }

    return false;
  }
}
