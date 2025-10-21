import 'package:calculix/data/models/user_entity.dart';
import 'package:calculix/domain/repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthDataRepository implements AuthRepository {
  final SupabaseClient _client;

  AuthDataRepository(this._client);

  @override
  Stream<UserEntity?> get authStateChanges {
    return _client.auth.onAuthStateChange.asyncMap((event) async {
      final user = event.session?.user;

      if (user == null) {
        return null;
      }

      try {
        final profileData = await _client
            .from("profiles")
            .select('*')
            .eq('id', user.id)
            .maybeSingle();

        if (profileData == null) {
          debugPrint(
            "Perfil no encontrado para el usuario ${user.id}, se usará un fallback.",
          );
          return _mapToUserEntity(user);
        }
        debugPrint(profileData["id"]);
        return _userEntityFromProfile(profileData);
      } catch (e) {
        debugPrint("Error al buscar perfil en authStateChanges: $e");

        return _mapToUserEntity(user);
      }
    });
  }

  UserEntity _userEntityFromProfile(Map<String, dynamic> map) {
    return UserEntity(
      id: map["id"],
      level: map["level"] ?? 0,
      email: map["email"],
      userName: map["username"],
      avatarUrl: map["avatar_url"]
    );
  }

  UserEntity _mapToUserEntity(User user) {
    return UserEntity(id: user.id, email: user.email ?? "", userName: "",avatarUrl: "");
  }

  UserEntity fromMap(Map<String, dynamic> map) {
    return _userEntityFromProfile(map);
  }

  @override
  Future<UserEntity> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        final userProfile = await _client
            .from("profiles")
            .select('*')
            .eq('id', response.user!.id)
            .single();
        return fromMap(userProfile);
      }
      throw Exception("Usuario no encontrado en signIn");
    } catch (e) {
      debugPrint("Error en signIn: ${e.toString()}");
      throw Exception("Fallo al iniciar sesión. Verifica tus credenciales.");
    }
  }

  @override
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  @override
  Future<UserEntity> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        final newUserProfile = await _client
            .from("profiles")
            .insert({
              "id": response.user!.id,
              "email": response.user!.email,
              "username": username,
              "level": 0,
            })
            .select()
            .single();
        return fromMap(newUserProfile);
      }
      throw Exception("No se pudo crear el usuario en Supabase Auth");
    } catch (e) {
      debugPrint("Error en signUp: ${e.toString()}");
      throw Exception("Fallo al registrar el usuario.");
    }
  }

  @override
  Future<UserEntity> getUserData() async {
    final currentUser = _client.auth.currentUser;
    if (currentUser == null) {
      throw Exception("Token de sesión no válido o expirado.");
    }
    try {
      final profileData = await _client
          .from('profiles')
          .select('*')
          .eq('id', currentUser.id)
          .single();
      return _userEntityFromProfile(profileData);
    } catch (e) {
      print('Error al obtener datos del perfil en DB: $e');
      throw Exception('Fallo al cargar el perfil de usuario usando el token.');
    }
  }
}
