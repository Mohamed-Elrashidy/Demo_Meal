import 'package:demo_meal/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:demo_meal/domain/base_repository/base_meal_repository.dart';
import 'package:demo_meal/domain/entity/meal.dart';
import 'package:demo_meal/utils/app_constansts.dart';

import '../models/meal_model.dart';

class MealRepository extends BaseMealRepository{
   RemoteDataSource remoteDataSource;
  MealRepository({required this.remoteDataSource});
  @override
   getMeals() async {
    List<Meal> meals=[];
    // get data and convert it to meal type
   List<dynamic>jsonMeals= await remoteDataSource.getData(AppConstants.mealsPath); 
   for(var meal in jsonMeals)
   {
     meals.add(MealModel.fromJson(meal));
   }
    return meals;
  }
  
}