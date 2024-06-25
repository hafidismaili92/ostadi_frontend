
import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/proposal.dart';
import 'package:ostadi_frontend/features/posts/domain/repositories/proposal_repository.dart';
import 'package:ostadi_frontend/features/posts/utils/classes/proposal_params.dart';

class SubmitProposalUseCase 
{
  final ProposalRepositoy repositoy;

  SubmitProposalUseCase({required this.repositoy});

  Future<Either<Failure,Proposal>> execute(ProposalParams proposalParams) async {
    final result = await repositoy.submitProposal(proposalParams);
    return result;
  }
  
}