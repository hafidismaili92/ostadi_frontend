import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/level_entity.dart';
import 'package:ostadi_frontend/features/auth/domain/use_cases/load_levels_use_case.dart';

part 'load_levels_state.dart';

class LoadLevelsCubit extends Cubit<LoadLevelsState> {
  final LoadLevelsUseCase loadLevelsUC;
  LoadLevelsCubit({required this.loadLevelsUC}) : super(LoadLevelsInitial());

  loadLevels() async {
    emit(LoadLevelsLoading());
    final res = await loadLevelsUC.loadLevels();
    res.fold((failure) => emit(LoadLevelsError(errorMessage: _failureToErrorMsg(failure))), (levels) => emit(LoadLevelsSuccess(levels: levels)));
  }

  _failureToErrorMsg(Failure failure) {
    switch(failure.runtimeType)
    {
      case ServerFailure:
      return 'error from Server';
       case ConnectionFailure:
      return 'No internet connection';
      
      case UnknownFailure:
      return 'unkwnow Error When loading levels';
      default:
      return 'unkwnow Error When loading levels';
    }
  }
}
