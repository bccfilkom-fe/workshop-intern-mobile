part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {}

final class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
}

final class Authenticated extends AuthState {}

final class Unauthenticated extends AuthState {}

final class LoggingOut extends AuthState {}
