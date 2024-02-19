import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ostadi_frontend/core/constants/app_constants.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/load_levels_cubit.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/registration_parts_cubits/student_info_fom_cubit.dart';
import 'package:ostadi_frontend/features/auth/presentation/widgets/custom_error_with_retry.dart';
import 'package:ostadi_frontend/core/layouts/formMobileLayout.dart';
import 'package:ostadi_frontend/core/widgets/form/dropdownFormInputs.dart';
import 'package:ostadi_frontend/core/widgets/form/textFormInput.dart';

class StudentInfoForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  bool validate() => _formKey.currentState!.validate();

// to control if levels already oaded from erver
bool _isDataLoaded = false;

  @override
  Widget build(BuildContext context) {
    // Access the LoadLevelsCubit and dispatch an event only once
    if (!_isDataLoaded) {
      context.read<LoadLevelsCubit>().loadLevels();
      _isDataLoaded = true;
    }
    return FormMobileLayout(
        title: "Personal informations",
        child: BlocBuilder<LoadLevelsCubit, LoadLevelsState>(
          builder: (loadlevelscontext, loadLevelsstate) {
            switch (loadLevelsstate.runtimeType) {
          case LoadLevelsLoading:
            return Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const Text('Loading levels,please wait...')
                  ],
                ));
          case LoadLevelsSuccess:
          final levels = (loadLevelsstate as LoadLevelsSuccess).levels;
          //set student default level to first element in levels
          BlocProvider.of<StudentInfoFormCubit>(context).updateLevel(levels[0].id);

           return BlocBuilder<StudentInfoFormCubit, StudentInfoFormState>(
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: kVerticalSpace["small"]! / 2),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Your Level'),
                            SizedBox(
                              height: 30,
                            ),
                            UnderLineDropBox(
                              icon: Icons.school_outlined,
                              options: levels.map((level) {
              return DropdownMenuItem<String>(
                value: level.id,
                child: Expanded(
                    child: Text(
                  level.title,
                )),
              );
            }).toList(),
                              label: "Your level",
                              value: state.level,
                              validator: (value) {
                                return levels.map((level)=>level.id).contains(value)
                                    ? null
                                    : 'invalid level';
                              },
                              onChanged: (value) {
                                BlocProvider.of<StudentInfoFormCubit>(context)
                                    .updateLevel(value);
                              },
                            ),
                          ],
                        ),
                        /*SizedBox(height: kVerticalSpace["small"]! / 2),
                        UnderLinedTextFormInput(
                          label: "Your approximatif adress",
                          icon: Icons.place_outlined,
                        ),*/
                      ]),
                );
              },
            );
          case LoadLevelsError:
          
          return CustomErrorWidget(errorMsg: (loadLevelsstate as LoadLevelsError).errorMessage,onRetry: () => BlocProvider.of<LoadLevelsCubit>(context).loadLevels(),);
          default:
          return CustomErrorWidget(errorMsg: "Can't Load Subjects",onRetry: () => BlocProvider.of<LoadLevelsCubit>(context).loadLevels(),);
        }
            
          },
        ));
  }
}
