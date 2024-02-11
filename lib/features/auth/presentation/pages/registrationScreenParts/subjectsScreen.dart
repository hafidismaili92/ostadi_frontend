import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ostadi_frontend/constants/app_constants.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/load_subjects_cubit.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/registration_parts_cubits/subjects_cubit.dart';

class SubjectsScreen extends StatelessWidget {
  //a boolean to control either subjects was already loaded or not
  bool _isDataLoaded = false;
  //TODO: availableSubjects must be loaded from server (actually i test by hard coded list)
  List<Map<String, Object>> availableSubjects = [
    {
      "id": '1',
      "name": "Math",
      "selected": false,
      "path": "assets/icons/math.png"
    },
    {
      "id": '2',
      "name": "Physics",
      "selected": true,
      "path": "assets/icons/physics.png"
    },
    {
      "id": '3',
      "name": "Arabic",
      "selected": false,
      "path": "assets/icons/arabic.png"
    },
    {
      "id": '4',
      "name": "SVT",
      "selected": true,
      "path": "assets/icons/svt.png"
    },
    {
      "id": '5',
      "name": "Info",
      "selected": true,
      "path": "assets/icons/programming.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    final subjectsCubit = BlocProvider.of<SubjectsCubit>(context);

    // Access the LoadSubjectsCubit and dispatch an event only once
    if (!_isDataLoaded) {
      context.read<LoadSubjectsCubit>().loadSubjects();
      _isDataLoaded = true;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/logo_light.png",
            width: 50,
          ),
          SizedBox(height: kVerticalSpace["small"]),
          Text("Subjects you teach:",
              style: Theme.of(context).textTheme.headlineSmall),
          SizedBox(height: kVerticalSpace["meduim"]),
          Expanded(child: BlocBuilder<LoadSubjectsCubit, LoadSubjectsState>(
            builder: (loadcontext, loadstate) {
              //check load subjects state
              switch (loadstate.runtimeType) {
          case LoadSubjectsLoading:
            return Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const Text('Loading subjects,please wait...')
                  ],
                ));
          case LoadSubjectsSuccess:
           return BlocBuilder<SubjectsCubit, SubjectToggledState>(
                builder: (context, state) => GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 1.2,
                  children: (loadstate as LoadSubjectsSuccess).subjects
                      .map((subject) => Center(
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () => subjectsCubit
                                    .addRemoveSubject(subject.id.toString()),
                                child: SubjectItemCard(
                                  imgPath: subject.icon! as String,
                                  title: subject.title! as String,
                                  isSelected: (state.selectedSubjects
                                      .contains(subject.id.toString())),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              );
          case LoadSubjectsError:
          return ErrorWidget(errorMsg: (loadstate as LoadSubjectsError).errorMessage,);
          default:
          return const ErrorWidget(errorMsg: "Can't Load Subjects",); 
        }
             
            },
          )),
        ],
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  final String errorMsg;
  const ErrorWidget({
    required this.errorMsg
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      children: [
        Text(errorMsg,style: TextStyle(color: Theme.of(context).colorScheme.error),),
        ElevatedButton(onPressed: ()=> BlocProvider.of<LoadSubjectsCubit>(context).loadSubjects(), child: Text('Retry again'))
      ],
    ),);
  }
}

class SubjectItemCard extends StatelessWidget {
  String title;
  String imgPath;
  bool isSelected;
  double? width;
  double? height;
  SubjectItemCard(
      {required this.isSelected,
      this.width,
      this.height,
      this.title = "",
      this.imgPath = ""});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onPrimary,
      child: Container(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  Image.network(imgPath, width: (width ?? 120) - 80),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(title),
                  )
                ],
              ),
            ),
            if (isSelected)
              Positioned(
                  child: AnimatedContainer(
                duration: Duration(seconds: 1),
                curve: Curves.slowMiddle,
                child: Center(
                  child: Icon(Icons.check,
                      color: Theme.of(context).colorScheme.onPrimary, size: 15),
                ),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle),
              ))
          ],
        ),
      ),
    );
  }
}
