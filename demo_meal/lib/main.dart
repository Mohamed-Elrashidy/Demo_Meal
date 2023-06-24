import 'package:demo_meal/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:demo_meal/presentation/controller/meal_controller/meal_cubit.dart';
import 'package:demo_meal/presentation/controller/order_controller/order_cubit.dart';
import 'package:demo_meal/presentation/controller/user_controller/user_cubit.dart';
import 'package:demo_meal/presentation/view/pages/home_page.dart';
import 'package:demo_meal/utils/app_routing.dart';
import 'package:demo_meal/utils/dependancy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repository/meal_repository.dart';
import 'utils/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Dependancey().init();

  runApp(const MyApp());



}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(),
      child: BlocProvider(
        create: (context) => OrderCubit(),
        child: BlocProvider(
          create: (context) => MealCubit(),
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            onGenerateRoute: AppRouting.generateRoutes,
            //    home:HomePage() ,
          ),
        ),
      ),
    );
  }
}




