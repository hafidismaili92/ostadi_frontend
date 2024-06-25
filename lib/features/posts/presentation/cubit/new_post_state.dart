part of 'new_post_cubit.dart';

sealed class NewPostState extends Equatable {
  const NewPostState();

  @override
  List<Object> get props => [];
}

final class NewPostInitial extends NewPostState {}

final class AddingNewPostLoading extends NewPostState{}

final class AddingNewPostSuccess extends NewPostState{
  final Post post;
  AddingNewPostSuccess({required this.post});
  @override
  List<Object> get props => [post];
}



final class AddingNewPostError extends NewPostState {
  final String errorMessage;

  AddingNewPostError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];

}
