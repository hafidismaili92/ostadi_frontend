import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/duration.dart';
import 'package:ostadi_frontend/features/posts/domain/use_cases/load_durations_uc.dart';

part 'load_duration_state.dart';

class LoadDurationCubit extends Cubit<LoadDurationState> {
  final LoadDurations loadDurationUC;
  LoadDurationCubit({required this.loadDurationUC}) : super(LoadDurationInitial());


  void submitLoadDurationList() async 
  {
    
    emit(LoadDurationLoading());
    final result = await loadDurationUC.execute();
    
    result.fold((l) => emit(LoadDurationError(errorMsg: 'error loading durations List')), (r) => emit(LoadDurationSuccess(durations: r)));
  }
}
