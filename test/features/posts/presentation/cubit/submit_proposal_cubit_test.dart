import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/proposal.dart';
import 'package:ostadi_frontend/features/posts/domain/use_cases/submit_proposal_usecase.dart';
import 'package:ostadi_frontend/features/posts/presentation/cubit/submit_proposal_cubit.dart';
import 'package:ostadi_frontend/features/posts/utils/classes/proposal_params.dart';

class MockSubmitProposalUseCase extends Mock implements SubmitProposalUseCase {}
void main() {
 final mockUseCase = MockSubmitProposalUseCase();
 ProposalParams proposalParams = ProposalParams(postId: 'test', description: 'this is a test', amount: 200.00, date: '27-03-2024');
 Proposal proposal = Proposal(id:'tst',postId: 'test', description: 'this is a test', amount: 200.00, date: '27-03-2024');
 blocTest('should return loading then succes states when use case called and return a proposal entity',setUp: (){
  when(()=>mockUseCase.execute(proposalParams)).thenAnswer((_) async => Right(proposal));
 },build: ()=>SubmitProposalCubit(submitUseCase: mockUseCase),
 act: (cubit)=>cubit.submitProposalEvent(proposalParams),
 expect: () => <SubmitProposalState>[SubmitProposalLoading(),SubmitProposalSuccess(proposal: proposal)] ,
 );

 blocTest('should return loading then error states  when use case called and return a failure',setUp: (){
  when(()=>mockUseCase.execute(proposalParams)).thenAnswer((_) async => Left(ServerFailure()));
 },build: ()=>SubmitProposalCubit(submitUseCase: mockUseCase),
 act: (cubit)=>cubit.submitProposalEvent(proposalParams),
 expect: () => <SubmitProposalState>[SubmitProposalLoading(),SubmitProposalError(errorMsg: SubmitProposalCubit.failureToErrorMsg(ServerFailure()) )] ,
 );
}