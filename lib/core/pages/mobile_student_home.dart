import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:motion_tab_bar/MotionBadgeWidget.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:ostadi_frontend/core/themes/inputDecorations.dart';
import 'package:ostadi_frontend/core/widgets/form/textFormInput.dart';
import 'package:ostadi_frontend/features/posts/presentation/cubit/load_my_posts_cubit.dart';

import 'package:ostadi_frontend/features/posts/presentation/pages/my_posts_list_page.dart';
import 'package:ostadi_frontend/core/app_dependencies_injection.dart' as di;

class MobileStudentHome extends StatefulWidget {
  const MobileStudentHome({Key? key}) : super(key: key);

  @override
  _MobileHomeState createState() => _MobileHomeState();
}

class _MobileHomeState extends State<MobileStudentHome>
    with TickerProviderStateMixin {
  // TabController _tabController;
  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    super.initState();

    // use "MotionTabBarController" to replace with "TabController", if you need to programmatically change the tab
    _motionTabBarController = MotionTabBarController(
      initialIndex: 3,
      length: 4,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Posts'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5)),
        ),
        elevation: 0.00,
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        leading: const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://picsum.photos/200'),
            backgroundColor: Colors.transparent,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => Center(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: NewJobPostForm(),
                            ),
                          ),
                        ));
              },
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Text(
                    'New Post',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ))
        ],
      ),
      bottomNavigationBar: MotionTabBar(
        controller:
            _motionTabBarController, // ADD THIS if you need to change your tab programmatically
        initialSelectedTab: "Messages",
        labels: const ["Posts", "Contracts", "Find", "Messages"],
        icons: const [
          Icons.notes_outlined,
          Icons.note_alt_outlined,
          Icons.search,
          Icons.chat
        ],

        // optional badges, length must be same with labels
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Theme.of(context).colorScheme.secondary,
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: Theme.of(context).colorScheme.primary,
        tabIconSelectedColor: Colors.white,
        tabBarColor: Colors.white,
        onTabItemSelected: (int value) {
          setState(() {
            // _tabController!.index = value;
            _motionTabBarController!.index = value;
          });
        },
      ),
      body: SafeArea(
          child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => di.sl<LoadPostsCubit>(),
          ),
        ],
        child: Scaffold(
            body: SafeArea(
          child: TabBarView(
            physics:
                const NeverScrollableScrollPhysics(), // swipe navigation handling is not supported
            // controller: _tabController,
            controller: _motionTabBarController,
            children: <Widget>[
              Center(
                child: MyPostsPage(),
              ),
              const Center(
                child: Text("Home"),
              ),
              const Center(
                child: Text("Profile"),
              ),
              Center(
                child: ElevatedButton(
                  child: Text('click me to go to chat page'),
                  onPressed: () {
                    GoRouter.of(context).pushNamed('chat');
                  },
                ),
              ),
            ],
          ),
        )),
      )),
    );
  }
}

class NewJobPostForm extends StatelessWidget {
  const NewJobPostForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Container(
      width: 250,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.maxLength(250)
            ]),
            //controller: emailController,
            decoration: AppInputDecorations.underLinedInput(
                    mainColor: Theme.of(context).colorScheme.primary,
                    secondaryColor: Theme.of(context).colorScheme.secondary)
                .copyWith(
                    labelText: "Job Title", icon: const Icon(Icons.title)),
          ),
          SizedBox(height: 25,),
            TextFormField(
            validator: FormBuilderValidators.maxLength(800),
            keyboardType: TextInputType.multiline,
            minLines: 2,
            maxLines: 8,
            //controller: emailController,
            decoration: AppInputDecorations.underLinedInput(
                    mainColor: Theme.of(context).colorScheme.primary,
                    secondaryColor: Theme.of(context).colorScheme.secondary)
                .copyWith(
                    labelText: "Description", icon: const Icon(Icons.description_outlined)),
          ),
          SizedBox(height: 25,),
          TextFormField(
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.numeric()
            ]),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
           
            //controller: emailController,
            decoration: AppInputDecorations.underLinedInput(
                    mainColor: Theme.of(context).colorScheme.primary,
                    secondaryColor: Theme.of(context).colorScheme.secondary)
                .copyWith(
                    labelText: "Amount", icon: const Icon(Icons.attach_money)),
          ),
          SizedBox(height: 25,),
          DropdownButtonFormField(items: [DropdownMenuItem(child: Text('Less than 1 month'))], onChanged: null,decoration: AppInputDecorations.underLinedInput(
                    mainColor: Theme.of(context).colorScheme.primary,
                    secondaryColor: Theme.of(context).colorScheme.secondary)
                .copyWith(
                     icon: const Icon(Icons.timer_outlined)),),
                      SizedBox(height: 40,),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [ElevatedButton(onPressed: (){print('hi');}, child: Text('Cancel')),ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary,foregroundColor: Theme.of(context).colorScheme.onPrimary),onPressed: (){print('hi');}, child: Text('Submit'))],)
        ],
      ),
    ));
  }
}
