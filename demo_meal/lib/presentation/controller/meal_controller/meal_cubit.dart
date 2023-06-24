import 'package:bloc/bloc.dart';
import 'package:demo_meal/domain/usecases/get_meals_usecases.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../data/repository/meal_repository.dart';
import '../../../domain/entity/meal.dart';
import '../../../domain/usecases/make_sale_usecase.dart';
part 'meal_state.dart';

class MealCubit extends Cubit<MealState> {
  MealCubit() : super(MealInitial());
  Map<int, List<Meal>> categoriezedMeals = {};

  getMeals() async {
    emit(MealLoading());
    List<Meal> meals = await GetMealsUseCase(
            baseMealRepository: GetIt.instance.get<MealRepository>())
        .execute();
    // dvide each meal to its category now we have only two categories recommend( categoryCode is 0) meals and  normal meal
    divideMeals(meals);
    emit(MealLoaded(meals: meals));
  }

  void divideMeals(List<Meal> meals) {
    categoriezedMeals = {};
    for (var meal in meals) {
      int code = meal.categoryCode;
      if (categoriezedMeals.containsKey(code)) {
        categoriezedMeals[code]?.add(meal);
      } else {
        categoriezedMeals.putIfAbsent(code, () => [meal]);
      }
    }
  }

  List<Meal> getRecommendedMeals() {
    return categoriezedMeals[0] ?? [];
  }

  List<String> saleMealsId = [];
  void changeState(String id) {
    if (saleMealsId.contains(id)) {
      saleMealsId.remove(id);
    } else {
      saleMealsId.add(id);
    }
    emit(SaleStateChanged());
  }

  bool getSaleState(String id) {
    return saleMealsId.contains(id);
  }

  void addAllToSale() {
    categoriezedMeals.forEach((key, value) {
      value.forEach((element) {
        if (!saleMealsId.contains(element.id)) {
          saleMealsId.add(element.id);
        }
      });
    });
    emit(SaleStateChanged());
  }

  Future<void> makeSale(String title, String saleValue) async {
    await MakeSaleUseCase(
            baseMealRepository: GetIt.instance.get<MealRepository>())
        .execute(saleMealsId, saleValue, title);
  }
}
