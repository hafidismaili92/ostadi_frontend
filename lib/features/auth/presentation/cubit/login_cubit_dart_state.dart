part of 'login_cubit_dart_cubit.dart';

sealed class LoginCubitDartState extends Equatable {
  const LoginCubitDartState();

  @override
  List<Object> get props => [];
}

final class LoginCubitDartInitial extends LoginCubitDartState {}

final class LoginLoadingState extends LoginCubitDartState {
  
}

final class LoginSuccessState extends LoginCubitDartState{

}


final class LoginErrorState extends LoginCubitDartState {
  final String errorMessage;
  final String entredEmail;
  final String entredpassword;
  LoginErrorState({required this.errorMessage,required this.entredEmail,required this.entredpassword});

  @override
  List<Object> get props => [errorMessage,entredEmail,entredpassword];

}