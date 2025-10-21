import 'package:calculix/data/models/user_entity.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState {
  final AuthStatus status;
  final UserEntity? user;
  final String? errorMessage;
  final String? token;

  AuthState({required this.status, this.user, this.errorMessage,this.token});

  factory AuthState.initial() => AuthState(status: AuthStatus.initial);

  AuthState copyWith({
    AuthStatus? status,
    UserEntity? user,
    String? errorMessage,
    String? token,
  }) {
    return AuthState(
      status: status ?? this.status,
      token: errorMessage ?? this.token,
      user: user ?? this.user,
      errorMessage: status == AuthStatus.error ? errorMessage : null,
    );
  }
}