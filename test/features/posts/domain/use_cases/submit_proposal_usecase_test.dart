import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/proposal.dart';
import 'package:ostadi_frontend/features/posts/domain/repositories/proposal_repository.dart';
import 'package:ostadi_frontend/features/posts/domain/use_cases/submit_proposal_usecase.dart';
import 'package:ostadi_frontend/features/posts/utils/classes/proposal_params.dart';
import 'package:test/test.dart';

class MockProposalRepositoy extends Mock implements ProposalRepositoy{}
void main() {
  late SubmitProposalUseCase submitProposalUC;
  MockProposalRepositoy repositoy = MockProposalRepositoy();
  ProposalParams proposalParams = ProposalParams(postId: 'test', description: 'this is a test', amount: 200.00, date: '27-03-2024');
  Proposal proposal = Proposal(id:'tst',postId: 'test', description: 'this is a test', amount: 200.00, date: '27-03-2024');
  setUp((){
    submitProposalUC = SubmitProposalUseCase(repositoy: repositoy);
  });
  test('should return a Right(Proposal) when repository respond with Right(Proposal) (meaning success proposal submit)', () async {
    //arrange
    when(()=>repositoy.submitProposal(proposalParams)).thenAnswer((_) async => Right(proposal) );
    //test
    final result = await submitProposalUC.execute(proposalParams);
    //assert
    verify(()=>repositoy.submitProposal(proposalParams)).called(1);
    expect(result, Right(proposal));
  });
  test('should return a Left(Failure) when repository respond with Left(Failure) (meaning success proposal submit)', () async {
    //arrange
    when(()=>repositoy.submitProposal(proposalParams)).thenAnswer((_) async => Left(ServerFailure()) );
    //test
    final result = await submitProposalUC.execute(proposalParams);
    //assert
    verify(()=>repositoy.submitProposal(proposalParams)).called(1);
    expect(result, Left(ServerFailure()));
  });
}