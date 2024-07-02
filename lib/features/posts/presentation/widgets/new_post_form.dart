import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ostadi_frontend/core/themes/inputDecorations.dart';
import 'package:ostadi_frontend/features/posts/presentation/cubit/load_duration_cubit.dart';
import 'package:ostadi_frontend/features/posts/presentation/cubit/load_my_posts_cubit.dart';
import 'package:ostadi_frontend/features/posts/presentation/cubit/new_post_cubit.dart';
import 'package:ostadi_frontend/features/posts/utils/classes/post_params.dart';

class NewJobPostForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _title = TextEditingController(text: '');
  TextEditingController _description = TextEditingController(text: '');
  TextEditingController _amount = TextEditingController(text: '');
  String? _selecteduration;

  @override
  Widget build(BuildContext context) {
    //load Duration from server
    BlocProvider.of<LoadDurationCubit>(context).submitLoadDurationList();
    return BlocBuilder<NewPostCubit, NewPostState>(
            builder: (context, NewPostState) {
              switch(NewPostState.runtimeType)
              {
                case AddingNewPostLoading:
                return const Center(child: CircularProgressIndicator());
                case AddingNewPostSuccess:
                final post = (NewPostState as AddingNewPostSuccess).post;
                Future.delayed(Duration(seconds: 1),(){
                  //hide add post form
                    Navigator.pop(context);
                    //update posts list
                    final postsState = BlocProvider.of<LoadPostsCubit>(context).state;
                    if(postsState.runtimeType==LoadPostsSuccess)
                    {
                        BlocProvider.of<LoadPostsCubit>(context).updatePostsList([post,...(postsState as LoadPostsSuccess).posts]);
                    }
                    

                    //
                    BlocProvider.of<NewPostCubit>(context).resetState();
                });
                return AlertMsgCard(icon: Icons.check_circle,color: Colors.green.shade400,message: 'Post add Success',);
                case AddingNewPostError:
                Future.delayed(Duration(seconds: 2),(){
                    BlocProvider.of<NewPostCubit>(context).emit(NewPostInitial());
                });
                return AlertMsgCard(icon: Icons.error_outline_outlined,color: Colors.red.shade400,message: (NewPostState as AddingNewPostError).errorMessage,);
                

                default:
                  return Form(
                    key: _formKey,

                    child: Container(
                      width: 250,
                      child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                      TextFormField(
                        controller: _title,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.maxLength(250)
                        ]),
                        decoration: AppInputDecorations.underLinedInput(
                                mainColor: Theme.of(context).colorScheme.primary,
                                secondaryColor:
                                    Theme.of(context).colorScheme.secondary)
                            .copyWith(
                                labelText: "Job Title",
                                icon: const Icon(Icons.title)),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: _description,
                        validator: FormBuilderValidators.maxLength(800),
                        keyboardType: TextInputType.multiline,
                        minLines: 2,
                        maxLines: 8,
                        //controller: emailController,
                        decoration: AppInputDecorations.underLinedInput(
                                mainColor: Theme.of(context).colorScheme.primary,
                                secondaryColor:
                                    Theme.of(context).colorScheme.secondary)
                            .copyWith(
                                labelText: "Description",
                                icon: const Icon(Icons.description_outlined)),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: _amount,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric()
                        ]),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: AppInputDecorations.underLinedInput(
                                mainColor: Theme.of(context).colorScheme.primary,
                                secondaryColor:
                                    Theme.of(context).colorScheme.secondary)
                            .copyWith(
                                labelText: "Amount",
                                icon: const Icon(Icons.attach_money)),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      BlocBuilder<LoadDurationCubit, LoadDurationState>(
                        builder: (context, state) {
                          switch (state.runtimeType) {
                            case LoadDurationLoading:
                              return const CircularProgressIndicator();
                            case LoadDurationSuccess:
                              final successState = state as LoadDurationSuccess;
                              _selecteduration = successState.durations[0].id;
                              return DropdownButtonFormField(
                                validator: (value) {
                                  if (!successState.durations
                                      .map((duration) => duration.id)
                                      .contains(value)) {
                                    return 'Please select a valid duration';
                                  }
                                },
                                value: _selecteduration,
                                items: successState.durations
                                    .map((item) => DropdownMenuItem(
                                        value: item.id, child: Text(item.title)))
                                    .toList(),
                                onChanged: (value) {
                                  _selecteduration = value ?? '';
                                },
                                decoration: AppInputDecorations.underLinedInput(
                                        mainColor:
                                            Theme.of(context).colorScheme.primary,
                                        secondaryColor:
                                            Theme.of(context).colorScheme.secondary)
                                    .copyWith(
                                        icon: const Icon(Icons.timer_outlined)),
                              );
                            case LoadDurationError:
                              final errorState = state as LoadDurationError;
                              return Text(
                                errorState.errorMsg,
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.error),
                              );
                            default:
                              return Container();
                          }
                        },
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel')),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  foregroundColor:
                                      Theme.of(context).colorScheme.onPrimary),
                              onPressed: () {
                                if (_formKey.currentState?.validate() ?? false) {
                                  PostParams postParams = PostParams(
                                      title: _title.text,
                                      description: _description.text,
                                      amount: double.parse(
                                          _amount.text != '' ? _amount.text : '0'),
                                      duration: _selecteduration!);
                                  BlocProvider.of<NewPostCubit>(context)
                                      .submitNewPost(postParams);
                                }
                              },
                              child: Text('Submit'))
                        ],
                      )
                                      ],
                                    ),
                    ),
                  );
              }
              
            },
          );
        
  }
}

class AlertMsgCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String message;
  /*List<Function> actions;*/
  AlertMsgCard({required this.color, required this.icon, required this.message, /*this.actions=[]*/});
  
  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 180,
      child: Center(child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon ,size: 60,color: color ,),
            SizedBox(height: 25,),
           Text(message,),
           
          ],
        ),
      )),
    );
  }
}
