import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ostadi_frontend/core/utilities/dateHelper.dart';

import 'package:ostadi_frontend/features/posts/domain/entities/post.dart';
import 'package:ostadi_frontend/features/posts/presentation/cubit/load_my_posts_cubit.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: BlocBuilder<LoadMyPostsCubit, LoadMyPostsState>(
        bloc: BlocProvider.of<LoadMyPostsCubit>(context)..LoadMyPostsEvent(),
        builder: (context, state) {
          
          switch (state.runtimeType) {
            case LoadMyPostsLoading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case LoadPostsSuccess:
              final posts = (state as LoadPostsSuccess).posts;
              return posts.length> 0 ? ListView.separated(
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) => PostWidget(
                  post: posts[index],
                ),
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              ) :Center(child: Text("No available Posts"),);
            case LoadPostsError:
              return Center(
                  child: Text(
                (state as LoadPostsError).errorMessage,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ));
            default:
            
              return Center(
                child: Text('No Available Data'),
              );
          }
        },
      ),
    );;
  }
}



class PostWidget extends StatelessWidget {
  final Post post;
  const PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Text(
                'Posted on ${DateHelper.dateTimeToString(DateTime.parse(post.date))}',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              Spacer(),
              const PrimaryIconBtn(icon: Icons.remove_red_eye_outlined),
              const PrimaryIconBtn(icon: Icons.edit),
            ],
          ),
        ),
        Text(
          post.title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
        Text(
          post.description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Proposals : ${post.proposalCount}',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  Text(
                    'Hired     : ${post.hiredCount}',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              ),
              Icon(
                Icons.delete_forever_outlined,
                color: Theme.of(context).colorScheme.tertiary,
              )
            ],
          ),
        ),
        Row(
          children: post.subjects
              .map((subject) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Chip(
                      side: BorderSide.none,
                      labelPadding: EdgeInsets.all(0),
                      label: Text(subject,style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant ),),
                      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                    ),
                  ))
              .toList(),
        )
      ]),
    );
  }
}

class PrimaryIconBtn extends StatelessWidget {
  final IconData icon;
  const PrimaryIconBtn({required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      color: Theme.of(context).colorScheme.primary,
      onPressed: () {},
    );
  }
}
