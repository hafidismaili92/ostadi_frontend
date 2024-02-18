part of 'authentication_cubit.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

final class AuthenticationLoading extends AuthenticationState{}

final class AuthenticationSuccess extends AuthenticationState{
  final AuthenticatedUserEntity user;

  AuthenticationSuccess({required this.user});

  @override
  List<Object> get props => [user];

}

final class AuthenticationError extends AuthenticationState{
final String errorMsg;

  AuthenticationError({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}

final class NoTokenRegistredState extends AuthenticationState{}
