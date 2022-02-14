import 'package:city_flower/core/user/bloc/user_bloc.dart';
import 'package:city_flower/features/splash/presentation/ui/splash_page.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart' as di;
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<UserBloc>(
      create: (_) => serviceLocator<UserBloc>(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // Used to select if we use the dark or light theme.
  ThemeMode themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    const FlexScheme usedFlexScheme = FlexScheme.money;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashPage(),
    );
  }
}
