import 'package:bloc/bloc.dart';
import 'package:demo_meal/domain/usecases/get_meals_usecases.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../data/repository/meal_repository.dart';
import '../../../domain/entity/meal.dart';
part 'meal_state.dart';

class MealCubit extends Cubit<MealState> {
  MealCubit() : super(MealInitial());
  Map<int, List<Meal>> _categoriezedMeals = {};

  getMeals() async {
    emit(MealLoading());
    List<Meal> meals = await GetMealsUseCase(
            baseMealRepository: GetIt.instance.get<MealRepository>())
        .execute();
    // dvide each meal to its category now we have only two categories recommend( categoryCode is 0) meals and  normal meal
    dvideMeals(meals);
    emit(MealLoaded(meals: meals));
  }

  void dvideMeals(List<Meal> meals) {
    _categoriezedMeals = {};
    for (var meal in meals) {
      int code = meal.categoryCode;
      if (_categoriezedMeals.containsKey(code)) {
        _categoriezedMeals[code]?.add(meal);
      } else {
        _categoriezedMeals.putIfAbsent(code, () => [meal]);
      }
    }
  }
  List<Meal> getRecommendedMeals()
  {
    return _categoriezedMeals[0]??[];
  }


}
