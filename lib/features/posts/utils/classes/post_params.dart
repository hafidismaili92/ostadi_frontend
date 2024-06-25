class PostParams {
  final String title;
  final String description;
  final double amount;
  final String duration;

  PostParams({required this.title, required this.description, required this.amount, required this.duration});

  Map<String,dynamic> toJson()
  {
    return {
  "title": title,
  "description": description,
  "amount": amount,
  "duration": duration
};
  }
  
}

