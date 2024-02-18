import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/user_entity.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/get_authenticated_User.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final GetAuthenticatedUserUC  getAuthenticatedUserUC;
  AuthenticationCubit({required this.getAuthenticatedUserUC}) : super(AuthenticationInitial());

  void getAuthenticatedUser() async
  {
    // emit(AuthenticationLoading());
    // Future.delayed(Duration(seconds: 3),(){
    //   emit(AuthenticationSuccess(user:AuthenticatedUserEntity(isDefaultStudent: false, isProfessor: true, isStudent: false, email: 'testemail@example.com', avatar: 'ff.jpg', name: 'ism test') ));
    // });
    final res = await getAuthenticatedUserUC.getAuthenticadedUser();
    res.fold((failure) {if(failure is NoTokenRegistredFailure) {emit(NoTokenRegistredState());} else {

      emit(AuthenticationError(errorMsg: failureToErrorMsg(failure)));

    }}, (userEntity){
      emit(AuthenticationSuccess(user: userEntity));
    });
  }

  static failureToErrorMsg(Failure failure) {
    switch(failure.runtimeType)
    {
      case ServerFailure:
      return 'error from Server';
       case ConnectionFailure:
      return 'No internet connection';
      
      case UnauthenticatedFailure:
      return 'Authentification Failed';
      default:
      return 'unknown Error When authenticated user';
    }
  }
}
