part of 'submit_proposal_cubit.dart';

sealed class SubmitProposalState extends Equatable {
  const SubmitProposalState();

  @override
  List<Object> get props => [];
}

final class SubmitProposalInitial extends SubmitProposalState {}

final class SubmitProposalLoading extends SubmitProposalState{}

final class SubmitProposalSuccess extends SubmitProposalState{
  final Proposal proposal;

  SubmitProposalSuccess({required this.proposal});

  @override
  List<Object> get props => [proposal];
}

final class SubmitProposalError extends SubmitProposalState{
  final String errorMsg;
  SubmitProposalError({required this.errorMsg});

@override
  List<Object> get props => [errorMsg];

}
