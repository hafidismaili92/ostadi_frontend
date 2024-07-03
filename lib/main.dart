import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ostadi_frontend/core/constants/app_constants.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:ostadi_frontend/core/routes/router.dart' as router;
import 'package:ostadi_frontend/core/themes/theme.dart';
import 'package:ostadi_frontend/core/app_dependencies_injection.dart' as di;
import 'package:ostadi_frontend/features/posts/presentation/cubit/load_duration_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  
  runApp(
    DevicePreview(
      //TODO: set to true to active device preview to test on mobile desktop...
      enabled: false,
      builder: (context) => OstadiApp(), // Wrap your app
    ),
  );
  //runApp(OstadiApp());
}

class OstadiApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = AppTheme(mainColor: kAppColorSeeds["green"]!);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<AuthenticationCubit>()),
        
      ],
      child: MaterialApp.router(
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          routerConfig: router.router,
          title: 'OSTADI APP',
          theme: appTheme.light,
          darkTheme: appTheme.dark,
          themeMode: ThemeMode.system),
    );
  }
}
