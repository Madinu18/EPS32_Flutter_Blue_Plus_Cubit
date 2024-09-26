import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'ui/pages/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SI-SOIL',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
          appBarTheme: AppBarTheme(backgroundColor: blueColor),
          textTheme: TextTheme(bodyLarge: blackTextFont)),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => PageCubit()),
          BlocProvider(create: (context) => BluetoothCubit()),
        ],
        child: const Wrapper(),
      ),
    );
  }
}
