import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/login_use_case.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/login_params.dart';
import 'package:test/test.dart';

part 'login_cubit_dart_state.dart';

class LoginCubitDartCubit extends Cubit<LoginCubitDartState> {
  final LoginUseCase loginUC;

  LoginCubitDartCubit({required this.loginUC}) : super(LoginCubitDartInitial());

  void login(Loginparams params) async
{
 
  emit(LoginLoadingState());
  final checkConnected = await loginUC.tryLogin(params);
  //TODO : reActivate login lgic (deactivated to create and test authenticated user screens like posts, messages,..... without need to login with correct credentials)
 // checkConnected.fold((failure)=>emit(LoginErrorState(entredEmail: params.email,entredpassword: params.password,errorMessage: failureToErrorMsg(failure))),(isConnected)=>emit(LoginSuccessState()));
 emit(LoginSuccessState());
}

 static failureToErrorMsg(Failure failure) {
    switch(failure.runtimeType)
    {
      case ServerFailure:
      return 'error from Server';
      case UnauthenticatedFailure:
      return 'Wrong Email or Password';
       case ConnectionFailure:
      return 'No internet connection';
      
      case UnknownFailure:
      return 'unkwnow Error' ;
      default:
      return 'unkwnow Error';
    }
  }
}


