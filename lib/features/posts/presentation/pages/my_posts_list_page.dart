import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ostadi_frontend/core/utilities/dateHelper.dart';

import 'package:ostadi_frontend/features/posts/domain/entities/post.dart';
import 'package:ostadi_frontend/features/posts/presentation/cubit/load_my_posts_cubit.dart';
import 'package:ostadi_frontend/features/posts/presentation/widgets/post_item_widget.dart';

class MyPostsPage extends StatelessWidget {
  const MyPostsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: BlocBuilder<LoadPostsCubit, LoadPostsState>(
        bloc: BlocProvider.of<LoadPostsCubit>(context)..LoadMyPostsEvent(),
        builder: (context, state) {
          
          switch (state.runtimeType) {
            case LoadPostsLoading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case LoadPostsSuccess:
              final posts = (state as LoadPostsSuccess).posts;
              return posts.length> 0 ? ListView.separated(
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) => PostWidget(
                  post: posts[index],
                  showForEditting: true,
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
    );
  }
}






