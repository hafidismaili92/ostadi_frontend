part of 'load_duration_cubit.dart';

sealed class LoadDurationState extends Equatable {
  const LoadDurationState();

  @override
  List<Object> get props => [];
}

final class LoadDurationInitial extends LoadDurationState {}

final class LoadDurationLoading extends LoadDurationState {}

final class LoadDurationSuccess extends LoadDurationState {
  final List<DurationEntity> durations;

  LoadDurationSuccess({required this.durations});

}

final class LoadDurationError extends LoadDurationState {
final String errorMsg;

  LoadDurationError({required this.errorMsg});

}