import 'package:calculix/data/models/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signIn({required String email, required String password});
  Future<UserEntity> signUp({required String email,required String password, required String username});
  Future<UserEntity> getUserData();
  Future<void> signOut();
  Stream<UserEntity?> get authStateChanges;
}
