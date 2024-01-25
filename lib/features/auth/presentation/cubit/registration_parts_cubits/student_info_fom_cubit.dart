import 'package:bloc/bloc.dart';

class StudentInfoFormCubit extends Cubit<StudentInfoFormState> {
  StudentInfoFormCubit():super(StudentInfoFormState(level:'Primary'));



void updateLevel(String level){

  emit(state.copyWith(level: level));
}

}

//state
class StudentInfoFormState {

final String level;

StudentInfoFormState({required this.level});

StudentInfoFormState copyWith({String? level})
{
  return StudentInfoFormState( level : level ?? this.level);
}

}