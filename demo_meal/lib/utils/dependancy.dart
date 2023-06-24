import 'package:demo_meal/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:demo_meal/data/repository/user_repository.dart';
import 'package:demo_meal/utils/dimension_scale.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import '../data/repository/meal_repository.dart';

class Dependancey
{


  //make instance of dimension class
   void initDimension(BuildContext context)
   {
    var locator= GetIt.instance;
    // init dimension class that make app responsive
    try{
      locator.get<Dimension>();
    }
    catch(e)
    {
      locator.registerSingleton(Dimension(context: context));
    }
  }
  // make instance of classes that same object may be needed in different places
  void init ()
   {
    GetIt locator = GetIt.instance;
    // instance of firebase library
    try{
      locator.get<RemoteDataSource>();
    }
    catch (e)
    {
      locator.registerSingleton(RemoteDataSource());
    }

    // instance of meal repository
    try{
       locator.get<MealRepository>();
    }
    catch(e)
    {
       locator.registerSingleton(MealRepository(remoteDataSource: locator.get<RemoteDataSource>()));
    }
    // instance of user repository
  try{
       locator.get<UserRepository>();
    }
    catch(e)
    {
       locator.registerSingleton(UserRepository(remoteDataSource: locator.get<RemoteDataSource>()));
    }


  }
}