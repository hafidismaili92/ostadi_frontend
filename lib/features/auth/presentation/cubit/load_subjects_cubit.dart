import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/subject_entity.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/load_subjects_use_case.dart';

part 'load_subjects_state.dart';

class LoadSubjectsCubit extends Cubit<LoadSubjectsState> {
  final LoadSubjectsUseCase loadSUbjectsUC;
  LoadSubjectsCubit({required this.loadSUbjectsUC}) : super(LoadSubjectsInitial());

  loadSubjects() async {
    emit(LoadSubjectsLoading());
    final res = await loadSUbjectsUC.loadSubjects();
    res.fold((failure) => emit(LoadSubjectsError(errorMessage: _failureToErrorMsg(failure))), (subjects) => emit(LoadSubjectsSuccess(subjects: subjects)));
  }

  _failureToErrorMsg(Failure failure) {
    switch(failure.runtimeType)
    {
      case ServerFailure:
      return 'error from Server';
       case ConnectionFailure:
      return 'No internet connection';
      
      case UnknownFailure:
      return 'unkwnow Error When loading subjects';
      default:
      return 'unkwnow Error When loading subjects';
    }
  }
}
