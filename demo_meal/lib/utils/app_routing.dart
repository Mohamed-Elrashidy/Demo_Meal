
import 'package:demo_meal/presentation/view/pages/meal_page.dart';
import 'package:flutter/material.dart';

import '../presentation/view/pages/home_page.dart';
import 'app_constansts.dart';

class AppRouting {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case AppConstants.mealsPath:
        return MaterialPageRoute(builder: (_)=> MealPage(),settings:settings);

      default:
        return MaterialPageRoute(
            builder: (_) => HomePage(), settings: settings);
    }
  }
}
