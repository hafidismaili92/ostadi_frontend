import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/proposal.dart';
import 'package:ostadi_frontend/features/posts/utils/classes/proposal_params.dart';

abstract class ProposalRepositoy
{
  Future<Either<Failure,Proposal>> submitProposal(ProposalParams proposal);
}