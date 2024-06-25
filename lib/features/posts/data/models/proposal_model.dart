
import 'package:ostadi_frontend/features/posts/domain/entities/proposal.dart';

class ProposalModel extends Proposal
{
  ProposalModel({required super.id,required super.postId, required super.description, required super.amount, required super.date});
  
  factory ProposalModel.fromJson(Map<String,dynamic> proposalString)
  {
    return ProposalModel(id:proposalString['id'].toString(),postId: proposalString['post'].toString(),description: proposalString['description'],amount: double.parse(proposalString['amount']),date: proposalString['date']);
  }
}