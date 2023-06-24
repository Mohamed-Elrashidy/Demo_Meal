import '../entity/meal.dart';

abstract class BaseMealRepository{
  List<Meal> getMeals();
  Future<void> makeSale(List<String> documentsIds, String saleValue,String title);

}