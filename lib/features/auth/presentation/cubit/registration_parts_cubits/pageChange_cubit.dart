import 'package:bloc/bloc.dart';



class PageChangeCubit extends Cubit<PageIndexState> {
  PageChangeCubit():super(PageIndexState(currentPage : 0));

setCurrentPageIndex(int page)
 {
  
    emit(PageIndexState(currentPage : page));
 }
}

//state
class PageIndexState {
final int currentPage;

PageIndexState({required this.currentPage});

}