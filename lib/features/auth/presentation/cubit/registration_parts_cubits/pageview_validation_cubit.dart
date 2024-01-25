import 'package:bloc/bloc.dart';



class PageViewCubit extends Cubit<pageViewValidState> {
  PageViewCubit():super(pageViewValidState(isValid : true,message:''));

switchValidationState(bool isValid,String message)
 {
  
    emit(pageViewValidState(isValid : isValid,message: message));
 }
}

//state
class pageViewValidState {
final bool isValid;
final String message;
pageViewValidState({required this.isValid,required this.message});

}