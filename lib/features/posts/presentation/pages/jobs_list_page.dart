import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/post.dart';
import 'package:ostadi_frontend/features/posts/presentation/cubit/load_my_posts_cubit.dart';
import 'package:ostadi_frontend/features/posts/presentation/cubit/submit_proposal_cubit.dart';
import 'package:ostadi_frontend/features/posts/presentation/widgets/post_item_widget.dart';
import 'package:ostadi_frontend/features/posts/utils/classes/proposal_params.dart';

class JobsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: BlocBuilder<LoadPostsCubit, LoadPostsState>(
        bloc: BlocProvider.of<LoadPostsCubit>(context)..LoadAllPostsEvent(),
        builder: (context, state) {
          switch (state.runtimeType) {
            case LoadPostsLoading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case LoadPostsSuccess:
              final posts = (state as LoadPostsSuccess).posts;

              return posts.isNotEmpty
                  ? ListView.separated(
                      itemCount: posts.length,
                      itemBuilder: (BuildContext context, int index) => BlocBuilder<SubmitProposalCubit, SubmitProposalState>(
                        builder: (submitContext, submitState) {
                      
                          String applytext = '';
                          
                          switch (submitState.runtimeType) {
                            case SubmitProposalLoading:
                               applytext ='Submitting....';
                            case SubmitProposalSuccess:
                              
                                applytext = 'Proposal Submited';
                            case SubmitProposalError:
                            applytext = (submitState as SubmitProposalError)
                                    .errorMsg;
                          };
                          return PostWidget(
                            post: posts[index],
                            actionButtonText:applytext,
                            //TODO: onApply should show a modal with form to allow prof enter description amount.. then submit, but for now let's enter dummy data
                            onApply: () {
                              BlocProvider.of<SubmitProposalCubit>(context)
                                  .submitProposalEvent(ProposalParams(
                                      postId: posts[index].id,
                                      description:
                                          'test description from widget',
                                      amount: 500,
                                      date: '04-05-2024'));
                            },
                          );
                        },
                      ),
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider();
                      },
                    )
                  : Center(
                      child: Text('no data'),
                    );
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
