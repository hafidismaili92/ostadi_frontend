import 'package:bloc/bloc.dart';

class SubjectsCubit extends Cubit<SubjectToggledState> {
  SubjectsCubit():super(SubjectToggledState(selectedSubjects : []));

addRemoveSubject(String subjectId)
 {
    final currentState = state;
    final selectedSubjects = currentState.selectedSubjects;
    if(selectedSubjects.contains(subjectId))
    {
      selectedSubjects.remove(subjectId);
    }
    else
    {
      selectedSubjects.add(subjectId);
    }
    emit(SubjectToggledState(selectedSubjects : selectedSubjects));
 }
}

//state
class SubjectToggledState {
List<String> selectedSubjects;

SubjectToggledState({required this.selectedSubjects});

}