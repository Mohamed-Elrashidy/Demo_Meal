import 'package:demo_meal/domain/base_repository/base_meal_repository.dart';

import '../entity/meal.dart';

class GetMealsUseCase {
  BaseMealRepository baseMealRepository;

  GetMealsUseCase({required this.baseMealRepository});
  List <Meal> execute()
  {
    return baseMealRepository.getMeals();
  }

}