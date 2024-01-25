import 'package:bloc/bloc.dart';


enum UserTypes {student,professor}
class TypeUserCubit extends Cubit<TypeUserChangedState> {
  TypeUserCubit():super(TypeUserChangedState(userType:UserTypes.student));

switchUserType(UserTypes userType)
 {
  
    emit(TypeUserChangedState(userType : userType));
 }
}

//state
class TypeUserChangedState {
final UserTypes userType;

TypeUserChangedState({required this.userType});

}