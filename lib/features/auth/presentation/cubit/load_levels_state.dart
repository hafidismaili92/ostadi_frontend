part of 'load_levels_cubit.dart';

sealed class LoadLevelsState extends Equatable {
  const LoadLevelsState();

  @override
  List<Object> get props => [];
}

final class LoadLevelsInitial extends LoadLevelsState {}

final class LoadLevelsLoading extends LoadLevelsState {

}

final class LoadLevelsSuccess extends LoadLevelsState {
  final List<Level> levels;

  LoadLevelsSuccess({required this.levels});
  @override
  List<Object> get props => [levels];
}

final class LoadLevelsError extends LoadLevelsState {
  final String errorMessage;

  LoadLevelsError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];

}
