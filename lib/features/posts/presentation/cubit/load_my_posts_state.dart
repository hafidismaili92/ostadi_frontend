part of 'load_my_posts_cubit.dart';

sealed class LoadPostsState extends Equatable {
  const LoadPostsState();

  @override
  List<Object> get props => [];
}

final class LoadPostsInitial extends LoadPostsState {}

final class LoadPostsLoading extends LoadPostsState{}

final class LoadPostsSuccess extends LoadPostsState {
  final List<Post> posts;

  LoadPostsSuccess({required this.posts});
  @override
  List<Object> get props => [posts];
}

final class LoadPostsError extends LoadPostsState {
  final String errorMessage;

  LoadPostsError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];

}
