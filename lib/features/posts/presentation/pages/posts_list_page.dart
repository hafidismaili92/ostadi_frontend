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
  const PostWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Text('Posted on 13/03/2024',style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Theme.of(context).colorScheme.secondary),),
              Spacer(),
              const PrimaryIconBtn(icon: Icons.remove_red_eye_outlined),
              
              const PrimaryIconBtn(icon: Icons.edit),
            ],
          ),
        ),
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
              Column(
                children: [
                  Text('Proposals : 5',style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Theme.of(context).colorScheme.secondary),),
                  Text('Hired     : 0',style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Theme.of(context).colorScheme.secondary),),
                ],
              ),
              Icon(Icons.delete_forever_outlined,color: Theme.of(context).colorScheme.tertiary,)
            ],
          ),
        ),
      ]),
    );
  }
}

class PrimaryIconBtn extends StatelessWidget {
  final IconData icon;
  const PrimaryIconBtn({required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(icon:Icon(icon),color: Theme.of(context).colorScheme.primary,onPressed: (){},);
  }
}
