import 'package:bloc/bloc.dart';

class StudentInfoFormCubit extends Cubit<StudentInfoFormState> {
  StudentInfoFormCubit():super(StudentInfoFormState(level:0));



void updateLevel(int level){

  emit(state.copyWith(level: level));
}

}

//state
class StudentInfoFormState {

final int level;

StudentInfoFormState({required this.level});

StudentInfoFormState copyWith({int? level})
{
  return StudentInfoFormState( level : level ?? this.level);
}

}