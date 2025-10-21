import 'package:calculix/data/models/auth_state.dart';
import 'package:calculix/data/models/user_entity.dart';
import 'package:calculix/data/provider/auth_provider.dart';
import 'package:calculix/domain/repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';

final authNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
      final repository = ref.watch(authRepositoryProvider);

      return AuthStateNotifier(repository);
    });

class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  UserEntity user = UserEntity(email: "", userName: "");

  AuthStateNotifier(this._repository) : super(AuthState.initial()) {
    _repository.authStateChanges.listen((user) {
      if (user != null) {
        debugPrint(user.toString());
        state = state.copyWith(status: AuthStatus.authenticated, user: user);
      } else {
        state = state.copyWith(status: AuthStatus.unauthenticated, user: null);
      }
    });
  }
  void updateUser(UserEntity newUser) {
    state = state.copyWith(user: newUser);
  }

  Future<void> signIn({required String email, required String password}) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _repository.signIn(email: email, password: password);
    } catch (e) {
      state = state.copyWith(
        user: null,
        status: AuthStatus.error,
        errorMessage: 'Fallo al iniciar sesión. Verifica tus credenciales.',
      );
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _repository.signUp(
        email: email,
        password: password,
        username: username,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
        user: null,
      );
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _repository.signOut();
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Error al cerrar sesión.',
      );
    }
  }
}
