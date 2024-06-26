import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:motion_tab_bar/MotionBadgeWidget.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:ostadi_frontend/features/posts/presentation/cubit/load_my_posts_cubit.dart';
import 'package:ostadi_frontend/features/posts/presentation/cubit/submit_proposal_cubit.dart';
import 'package:ostadi_frontend/features/posts/presentation/pages/jobs_list_page.dart';

import 'package:ostadi_frontend/features/posts/presentation/pages/my_posts_list_page.dart';
import 'package:ostadi_frontend/core/app_dependencies_injection.dart' as di;
class MobileProfessorHome extends StatefulWidget {
  const MobileProfessorHome({ Key? key }) : super(key: key);

  @override
  _MobileHomeState createState() => _MobileHomeState();
}

class _MobileHomeState extends State<MobileProfessorHome> with TickerProviderStateMixin {
  // TabController _tabController;
  MotionTabBarController? _motionTabBarController;

   @override
  void initState() {
    super.initState();
    
    
    // use "MotionTabBarController" to replace with "TabController", if you need to programmatically change the tab
    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 3,
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
        title: Text('Find a Job'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(5),
              bottomLeft: Radius.circular(5)),
        ),
        elevation: 0.00,
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        leading: const Padding(
          padding: EdgeInsets.symmetric(vertical:8.0),
          child: CircleAvatar(
                 
                  backgroundImage:
                      NetworkImage('https://picsum.photos/200'),
                  backgroundColor: Colors.transparent,
                ),
        ),
        
      ),
      bottomNavigationBar: MotionTabBar(
    controller: _motionTabBarController, // ADD THIS if you need to change your tab programmatically
    initialSelectedTab: "Find Job",
    labels: const ["Find Job", "My Contracts", "Messages"],
    icons: const [Icons.search, Icons.note_alt_outlined, Icons.chat],

    // optional badges, length must be same with labels
    tabSize: 50,
    tabBarHeight: 55,
    textStyle: const TextStyle(
      fontSize: 12,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
    tabIconColor: Theme.of(context).colorScheme.surfaceVariant,
    tabIconSize: 28.0,
    tabIconSelectedSize: 26.0,
    tabSelectedColor: Theme.of(context).colorScheme.secondary,
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
        child:  MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<LoadPostsCubit>(),
        ),
        BlocProvider(create: (context)=>di.sl<SubmitProposalCubit>()),
      ],
      child: Scaffold(
        
          body: SafeArea(
        child: TabBarView(
            physics: const NeverScrollableScrollPhysics(), // swipe navigation handling is not supported
            // controller: _tabController,
            controller: _motionTabBarController,
            children: <Widget>[
        Center(
          child: JobsListPage(),
        ),
       
        const Center(
          child: Text("Profile"),
        ),
        Center(
          child: ElevatedButton(child: Text('click me to go to chat page'),onPressed: (){
            GoRouter.of(context).pushNamed('chat');
          },),
        ),
            ],
          ),
      )),
    ) 
      ),
    );
  }
}

