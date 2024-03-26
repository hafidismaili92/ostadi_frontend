part of 'load_my_posts_cubit.dart';

sealed class LoadMyPostsState extends Equatable {
  const LoadMyPostsState();

  @override
  List<Object> get props => [];
}

final class LoadMyPostsInitial extends LoadMyPostsState {}

final class LoadMyPostsLoading extends LoadMyPostsState{}

final class LoadPostsSuccess extends LoadMyPostsState {
  final List<Post> posts;

  LoadPostsSuccess({required this.posts});
  @override
  List<Object> get props => [posts];
}

final class LoadPostsError extends LoadMyPostsState {
  final String errorMessage;

  LoadPostsError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];

}
