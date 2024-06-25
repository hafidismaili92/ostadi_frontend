
import 'dart:convert';

import 'package:ostadi_frontend/core/constants/api.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';
import 'package:ostadi_frontend/core/services/apiService/api_service.dart';
import 'package:ostadi_frontend/features/posts/data/models/proposal_model.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/proposal.dart';
import 'package:ostadi_frontend/features/posts/utils/classes/proposal_params.dart';

class ProposalRemoteDataSource {
  final ApiService apiservice;

  ProposalRemoteDataSource({required this.apiservice});

Future<ProposalModel> submitProposal(ProposalParams proposal,String token) async {
  const proposalEndPoint = 'jobs/my-proposals/';
 final result = await apiservice.postData(Uri.parse('$BASE_URL/$proposalEndPoint'), proposal.toJson(),{'Authorization':'Token $token'});
 
 if (result.statusCode ==201)
 {
    final dataString = result.data;
    final dataJson = jsonDecode(dataString);
    return ProposalModel.fromJson(dataJson);
 }
 else
 {
  
  throw ServerException();
 }
}

}