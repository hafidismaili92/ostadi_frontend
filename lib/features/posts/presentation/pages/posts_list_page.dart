import 'package:flutter/material.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:12.0),
      child: ListView.separated(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) => PostWidget(
          title: 'test',
        ),
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  final String title;
  const PostWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        Text('Posted on 13/03/2024',style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Theme.of(context).colorScheme.secondary),),
        Text(
          'Commodo non ea nostrud reprehenderit occaecat amet esse enim.',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
        Text(
          'Est velit eu est quis laboris nulla quis ipsum id . Ea irure eiusmod qui quis reprehenderit occaecat et commodo aute esse est.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Padding(
          padding: const EdgeInsets.only(top:10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Proposals : 5',style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Theme.of(context).colorScheme.secondary),),
              Icon(Icons.delete_forever_outlined,color: Theme.of(context).colorScheme.tertiary,)
            ],
          ),
        ),
      ]),
    );
  }
}
