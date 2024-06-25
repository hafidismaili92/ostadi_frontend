

import 'dart:convert';

import 'package:mocktail/mocktail.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';
import 'package:ostadi_frontend/core/services/apiService/api_service.dart';
import 'package:ostadi_frontend/features/posts/data/data_sources/proposals_remote_datasource.dart';
import 'package:ostadi_frontend/features/posts/data/models/proposal_model.dart';
import 'package:ostadi_frontend/features/posts/utils/classes/proposal_params.dart';
import 'package:test/test.dart';

class MockApiService extends Mock implements ApiService{}
class FakeUri extends Fake implements Uri {}
void main() {
  MockApiService mockApi = MockApiService();
  late ProposalRemoteDataSource tRemoteDS;

  const testProposalString ='''
{
  "id":"1",
  "postId":"post1",
  "description":"test description",
  "amount":50.47,
  "date":"24-05-2024"
}
''';
final proposalParams = ProposalParams(postId: "post1", description: 'test description', amount: 400, date: "24-10-2025");
setUp((){
  tRemoteDS = ProposalRemoteDataSource(apiservice: mockApi);
});

 setUpAll((){
      // to enable use any on Uri class
      registerFallbackValue(Uri());
      registerFallbackValue(<String, String>{});
    });
  test('should return a ProposalModel when api respoond with 201 result and datajson of this proposal', () async {
    //arrange
    when(()=>mockApi.postData(any(), any(),any())).thenAnswer((_)  async => HttpResponse(statusCode: 201, data: testProposalString));
    //test
    final result = await tRemoteDS.submitProposal(proposalParams, 'testtoken');
    //assert
    expect(result, ProposalModel.fromJson(jsonDecode(testProposalString)));
  });

  test('should return a ProposalModel when api respoond with 201 result and datajson of this proposal', () async {
    //arrange
    when(()=>mockApi.postData(any(), any(),any())).thenAnswer((_)  async => HttpResponse(statusCode: 201, data: testProposalString));
    //test
    final result = await tRemoteDS.submitProposal(proposalParams, 'testtoken');
    //assert
    expect(result, ProposalModel.fromJson(jsonDecode(testProposalString)));
  });

  test('should throw a server exception when api respoond with  result !=201', ()  {
    //arrange
    when(()=>mockApi.postData(any(), any(),any())).thenAnswer((_)  async => HttpResponse(statusCode: 500, data: 'error'));
    //test
    final call = tRemoteDS.submitProposal;
    //assert
    expect(()=>call(proposalParams, 'testtoken'), throwsA(TypeMatcher<ServerException>()));
  });
}