class ProposalParams{
    final String postId;
  final String description;
  final double amount;
  final String date;
  ProposalParams({required this.postId, required this.description, required this.amount,required this.date});

Map<String,dynamic> toJson()
  {
    return {
      "post":postId,
      "description":description,
      "amount":amount,
      "date":date
    };
  }
}