import 'package:calculix/data/models/auth_state.dart';
import 'package:calculix/data/models/user_entity.dart';
import 'package:calculix/data/provider/auth_provider.dart';
import 'package:calculix/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/legacy.dart';



// Provider de Riverpod que los widgets consumirán
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
        state = state.copyWith(status: AuthStatus.authenticated, user: user);
      } else {
        state = state.copyWith(status: AuthStatus.unauthenticated, user: null);
      }
    });
  }

  Future<void> signIn({required String email, required String password}) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      user = await _repository.signIn(email: email, password: password);
      state = state.copyWith(status: AuthStatus.authenticated, user: user);
    } catch (e) {
      state = state.copyWith(
        user: null,
        status: AuthStatus.error,
        errorMessage: 'Fallo al iniciar sesión. Verifica tus credenciales.',
      );
    }
  }

  /// Ejecuta la lógica para registrar un nuevo usuario (implementación pendiente).
  Future<void> signUp({required String email, required String password,required String username}) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      if (email.isEmpty || password.isEmpty||username.isEmpty) {
        throw Exception("You need to write fields");
      }
      user = await _repository.signUp(
        email: email,
        password: password,
        username: username,
      );
      state = state.copyWith(
        status: AuthStatus.authenticated,
        user: user
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
        user: null
      );
    }
  }

  /// Cierra la sesión del usuario.
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
