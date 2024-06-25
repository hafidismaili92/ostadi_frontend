import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/token_repository.dart';
import 'package:ostadi_frontend/features/posts/data/data_sources/proposals_remote_datasource.dart';
import 'package:ostadi_frontend/features/posts/data/models/proposal_model.dart';
import 'package:ostadi_frontend/features/posts/data/repositories_impl/proposal_repo_impl.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/proposal.dart';
import 'package:ostadi_frontend/features/posts/utils/classes/proposal_params.dart';
import 'package:test/test.dart';

class MockRemoteDS extends Mock implements ProposalRemoteDataSource{}
class MockTokenRepo extends Mock implements TokenRepository{}
void main() {
  MockRemoteDS remoteDS = MockRemoteDS();
  MockTokenRepo tokenRepo = MockTokenRepo();
  late ProposalRepositoryImpl proposalRepoImpl;
  ProposalParams proposalParams = ProposalParams(postId: 'test', description: 'this is a test', amount: 200.00, date: '27-03-2024');
  ProposalModel proposalModel = ProposalModel(id:'tst',postId: 'test', description: 'this is a test', amount: 200.00, date: '27-03-2024');
  setUp(() {
    proposalRepoImpl = ProposalRepositoryImpl(tokenRepo: tokenRepo ,remoteDS: remoteDS);
  });
  test('should return a right(Porposal) when remote DS respond with right(proposalModel)', () async {
    //arrange
    when(()=>remoteDS.submitProposal(proposalParams,any())).thenAnswer((_)async=>proposalModel);
    when(()=>tokenRepo.readToken()).thenAnswer((_) async => "randomtoken");
    //test
    final result = await proposalRepoImpl.submitProposal(proposalParams);
    //assert
    expect(result, Right(proposalModel));
  });

   test('should return a left(notokenFailure) when token repo respond wit null token ', () async {
    //arrange
    
    when(()=>tokenRepo.readToken()).thenAnswer((_) async => null);
    //test
    final result = await proposalRepoImpl.submitProposal(proposalParams);
    //assert
    verifyZeroInteractions(remoteDS);
    expect(result, Left(NoTokenRegistredFailure()));
  });
}