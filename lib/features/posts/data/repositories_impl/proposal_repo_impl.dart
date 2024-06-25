import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/token_repository.dart';
import 'package:ostadi_frontend/features/posts/data/data_sources/proposals_remote_datasource.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/proposal.dart';
import 'package:ostadi_frontend/features/posts/domain/repositories/proposal_repository.dart';
import 'package:ostadi_frontend/features/posts/utils/classes/proposal_params.dart';


class ProposalRepositoryImpl implements ProposalRepositoy{
  final ProposalRemoteDataSource remoteDS;
  final TokenRepository tokenRepo;
  ProposalRepositoryImpl({required this.tokenRepo,required this.remoteDS});
  @override
  Future<Either<Failure, Proposal>> submitProposal(ProposalParams proposal) async {
    
    try {
     
    final token = await tokenRepo.readToken();
    
    if(token != null)
    {

  final result = await remoteDS.submitProposal(proposal,token);
  
    return right(result);
  }
   return Left(NoTokenRegistredFailure());
}
on ServerException
{
  
  return Left(ServerFailure());
}

 on Exception catch (e) {
  return Left(UnknownFailure());
}
  }

}