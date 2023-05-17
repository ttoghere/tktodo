abstract class BaseAuthRepository {
  Future<void> signUp({required String username, required String password});
  Future<void> logIn({required String username, required String password});
  Future<void> reNemPass({required String username});
  Future<void> signOut();
}
