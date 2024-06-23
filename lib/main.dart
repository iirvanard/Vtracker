import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vtracker/features/auth/presentation/bloc/login_bloc.dart';
import 'package:vtracker/router/app_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection.dart' as di;

Future<String> getcookie(cookiementah, pattern) async {
  try {
    RegExp exp = RegExp(pattern);
    RegExpMatch? match = exp.firstMatch(cookiementah.toString());
    var cookie = match![0].toString();
    return (cookie);
  } catch (e) {
    return (jsonEncode({
      "auth": "Login error",
      "type": "Fetch data error",
    }));
  }
}

void main() async {
  di.init();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    GoRouter router = AppRouter().router;
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => di.locator<LoginBloc>(),
              ),
              BlocProvider(
                create: (_) => di.locator<MultiLoginBloc>(),
              ),
            ],
            child: MaterialApp.router(
              debugShowCheckedModeBanner: true,
              routeInformationParser: router.routeInformationParser,
              routerDelegate: router.routerDelegate,
              routeInformationProvider: router.routeInformationProvider,
            ),
          );
        });
  }
}
