import 'package:demo_meal/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:demo_meal/utils/dimension_scale.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import '../data/repository/meal_repository.dart';

class Dependancey
{
  // make instance of classes that same object may be needed in different places
  Future<void> init (BuildContext context)
  async {
    GetIt locator = GetIt.instance;
    // instance of firebase library
    try{
     await locator.get<RemoteDataSource>();
    }
    catch (e)
    {
     await locator.registerSingleton(RemoteDataSource());
    }

    // instance of meal repository
    try{
      await locator.get<MealRepository>();
    }
    catch(e)
    {
      await locator.registerSingleton(MealRepository(remoteDataSource: locator.get<RemoteDataSource>()));
    }
    // init dimension class that make app responsive
    try{
      await locator.get<Dimension>();
    }
    catch(e)
    {
     await locator.registerSingleton(Dimension(context: context));
    }

  }
}