import 'package:calculix/data/models/user_entity.dart';
import 'package:calculix/domain/repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthDataRepository implements AuthRepository {
  final SupabaseClient _client;

  AuthDataRepository(this._client);

  @override
  Stream<UserEntity?> get authStateChanges {
    return _client.auth.onAuthStateChange.map((event){
      final user = event.session?.user;
      return user != null ? _mapToUserEntity(user):null;
    });
  }

  UserEntity _mapToUserEntity(User user) {
    return UserEntity(
      email: user.email??"",
      userName: ""
    );
  }

  UserEntity fromMap(List<Map<String, dynamic>> map) {
    return UserEntity(
      id: map.first["id"],
      level: 0,
      email: map.first["email"],
      userName: map.first["username"],
    );
  }

  @override
  Future<UserEntity> signIn({
    required String email,
    required String password,
  }) async {
    try {
      AuthResponse response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        final user = await _client.from("profiles").select('*').eq('email', email);
        return fromMap(user);
      }
      throw Exception("User not found");
    } catch (e) {
      debugPrint(e.toString());
    }
    throw Exception("User not found");
  }

  @override
  Future<void> signOut() {
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> signUp({required String email, required String password, required String username}) async {
    try {
      AuthResponse response = await _client.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        final user = await _client.from("profiles").insert({"id":response.user!.id,"email":response.user!.email,"username":username,"level":0}).select("*");
        return fromMap(user);
      }
      throw Exception("User not found");
    } catch (e) {
      debugPrint(e.toString());
    }
    throw Exception("User not found");
  }
}
