
import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMsg;
  final Function onRetry;
  const CustomErrorWidget({
    required this.errorMsg,
    required this.onRetry
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      children: [
        Text(errorMsg,style: TextStyle(color: Theme.of(context).colorScheme.error),),
        ElevatedButton(onPressed: ()=> onRetry(), child: Text('Retry again'))
      ],
    ),);
  }
}