import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:mitsubishi_control/cubit/auth_cubit.dart';
import 'package:mitsubishi_control/repository/mel_repository.dart';
import 'package:mitsubishi_control/views/login_page.dart';

Future main() async {
  await DotEnv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: BlocProvider(
        create: (context) => AuthCubit(new MELRepository()),
        child: LoginPage(),
      ),
    );
  }
}
