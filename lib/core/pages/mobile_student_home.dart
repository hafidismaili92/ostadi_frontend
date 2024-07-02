import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:ostadi_frontend/features/posts/presentation/cubit/load_duration_cubit.dart';
import 'package:ostadi_frontend/features/posts/presentation/cubit/load_my_posts_cubit.dart';
import 'package:ostadi_frontend/features/posts/presentation/cubit/new_post_cubit.dart';
import 'package:ostadi_frontend/features/posts/presentation/pages/my_posts_list_page.dart';
import 'package:ostadi_frontend/features/posts/presentation/widgets/new_post_form.dart';

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
                                child: MultiBlocProvider(providers: [
                                  BlocProvider.value(
                                    value: BlocProvider.of<LoadPostsCubit>(
                                        context),
                                  ),
                                  BlocProvider.value(
                                    value: BlocProvider.of<LoadDurationCubit>(
                                        context),
                                  ),
                                   BlocProvider.value(
                                    value: BlocProvider.of<NewPostCubit>(
                                        context),
                                  ),
                                ], child: NewJobPostForm())),
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
      ),
    );
  }
}
