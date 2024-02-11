part of 'load_subjects_cubit.dart';

sealed class LoadSubjectsState extends Equatable {
  const LoadSubjectsState();

  @override
  List<Object> get props => [];
}

final class LoadSubjectsInitial extends LoadSubjectsState {

}

final class LoadSubjectsLoading extends LoadSubjectsState {

}

final class LoadSubjectsSuccess extends LoadSubjectsState {
  final List<Subject> subjects;

  LoadSubjectsSuccess({required this.subjects});
  @override
  List<Object> get props => [subjects];
}

final class LoadSubjectsError extends LoadSubjectsState {
  final String errorMessage;

  LoadSubjectsError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];

}
