import 'package:bloc/bloc.dart';

class RegisterFormCubit extends Cubit<RegisterFormState> {
  RegisterFormCubit():super(RegisterFormState(name:'',email:'',password:'',confirmPassword: ''));

void updateName(String name){

  emit(state.copyWith(name: name));
}
void updateEmail(String email){

  emit(state.copyWith(email: email));
}

void updatePassword(String password){

  emit(state.copyWith(password: password));
}
void updateConfirmPassword(String confirmPassword){

  emit(state.copyWith(confirmPassword: confirmPassword));
}
}

//state
class RegisterFormState {
final String email;
final String password;
final String confirmPassword;
final String name;
RegisterFormState({required this.name,required this.email, required this.password,required this.confirmPassword});

RegisterFormState copyWith({String? name,String? email , String? password, String? confirmPassword})
{
  return RegisterFormState(name : name?? this.name,email : email?? this.email, password : password ?? this.password,confirmPassword: confirmPassword ?? this.confirmPassword);
}

}