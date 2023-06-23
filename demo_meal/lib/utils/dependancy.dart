import 'package:demo_meal/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:get_it/get_it.dart';
import '../data/repository/meal_repository.dart';

class Dependancey
{
  // make instance of classes that same object may be needed in different places
  Future<void> init ()
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
      locator.registerSingleton(MealRepository(remoteDataSource: locator.get<RemoteDataSource>()));
    }

  }
}