import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/proposal.dart';
import 'package:ostadi_frontend/features/posts/domain/use_cases/submit_proposal_usecase.dart';
import 'package:ostadi_frontend/features/posts/utils/classes/proposal_params.dart';

part 'submit_proposal_state.dart';

class SubmitProposalCubit extends Cubit<SubmitProposalState> {
  final SubmitProposalUseCase submitUseCase;
  
  SubmitProposalCubit({required this.submitUseCase}) : super(SubmitProposalInitial());

  void submitProposalEvent(ProposalParams proposalParams) async
  {
    emit(SubmitProposalLoading());
    final result = await submitUseCase.execute(proposalParams);
    result.fold((failure) => emit(SubmitProposalError(errorMsg: failureToErrorMsg(failure))), (proposal) => emit(SubmitProposalSuccess(proposal: proposal)));
  }

  static String failureToErrorMsg(Failure failure) {
    switch(failure.runtimeType)
    {
      case ServerFailure:
      return 'error from Server';
       case ConnectionFailure:
      return 'No internet connection';
      case NoTokenRegistredFailure:
      return 'Authorization Required, please Login';
      case UnknownFailure:
      default:
      return 'unkwnow Error When posting proposal';
      
    }
  }
}
