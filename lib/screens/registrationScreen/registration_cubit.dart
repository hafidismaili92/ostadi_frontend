import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ostadi_frontend/models/RegistreUser.dart';

class RegisterCubit extends Cubit<RegiteredUser> {
  RegisterCubit() : super(RegiteredUser());

  void onApproveRegisterForm(email, password) {
    emit(state.copyWith(email: email, password: password));
  }

  void updateType({required bool isStudent}) {
    emit(state.copyWith(isStudent: isStudent));
  }

  void updateSubjects({required String subjectId}) {
    List<String> subjects = state.subjects.toList();
    if (subjects.contains(subjectId)) {
      subjects.remove(subjectId);
    } else {
      subjects.add(subjectId);
    }
    emit(state.copyWith(subjects: subjects));
  }

  void updateEmailAndPassword(email, password) {
    emit(state.copyWith(email: email, password: password));
  }
}
