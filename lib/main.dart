import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'ui/pages/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SI-SOIL',
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
