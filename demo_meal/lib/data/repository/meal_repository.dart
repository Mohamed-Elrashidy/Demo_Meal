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
   List<dynamic>jsonMeals= await remoteDataSource.getDataCollection(AppConstants.mealsPath);
   for(var meal in jsonMeals)
   {
     meals.add(MealModel.fromJson(meal));
   }
    return meals;
  }

  @override
  Future<void> makeSale(List<String> documentIds, String saleValue, String title) async {
   await remoteDataSource.updateDocumentAttribute(AppConstants.mealsPath, documentIds,"saleValue" , saleValue);
   if(saleValue!=0)
  {var data= await remoteDataSource.getDataCollection(AppConstants.notificationTokens);
  List<String>usersTokens=[];
  data.forEach((element) {
    usersTokens.add(element['token']);
  });
  String body="Don't miss this ${saleValue} percent sale ";
  await remoteDataSource.sendPushNotification(title,body,usersTokens);}

  }
  
}