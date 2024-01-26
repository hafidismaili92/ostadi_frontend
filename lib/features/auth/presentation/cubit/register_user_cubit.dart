import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/user_entity.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/register_prof_use_case.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/register_student_use_case.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/professor_parameters.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/student_parameters.dart';

part 'register_user_state.dart';

class RegisterUserCubit extends Cubit<RegisterUserState> {
RegisterProfUseCase registerProfUC;
RegisterStudentUseCase registerStudentUC;

RegisterUserCubit({required this.registerProfUC,required this.registerStudentUC}):super(RegisterUserInitial());
 

   registerProfessor({required ProfessorParams params}) async{
    /*emit(RegisterUserLoading());
    await Future.delayed(Duration(seconds: 3),);
    emit(RegisterUserSuccess());
    emit(RegisterUserError(message: mapFailureToMessage(ServerFailure())));*/

    emit(RegisterUserLoading());
    final result = await registerProfUC.registerNewProf(params);
    result.fold((failure) => emit(RegisterUserError(message:mapFailureToMessage(failure))), (profEntity) => emit(RegisterUserSuccess()));
    
  }

registerStudent({required StudentParams params}) async {
  emit(RegisterUserLoading());
    final result = await registerStudentUC.registerNewStudent(params);
    result.fold((failure) => emit(RegisterUserError(message:mapFailureToMessage(failure))), (profEntity) => emit(RegisterUserSuccess()));
}
  static String mapFailureToMessage(Failure failure)
  {
    switch(failure.runtimeType)
    {
      case ServerFailure:
      return 'a server Error was occured';
      case ConnectionFailure:
      return 'Check your internet Connection';
      case UnknownFailure:
      return 'unkwnow Error';
      default:
      return 'unkwnow Error';
    }
  }

  
}
