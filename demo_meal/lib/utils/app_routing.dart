
import 'package:demo_meal/presentation/view/pages/bottom_nav_bar.dart';
import 'package:demo_meal/presentation/view/pages/login_page.dart';
import 'package:demo_meal/presentation/view/pages/meal_page.dart';
import 'package:demo_meal/utils/routes.dart';
import 'package:flutter/material.dart';

import '../domain/entity/meal.dart';
import '../presentation/view/pages/cart_page.dart';
import '../presentation/view/pages/home_page.dart';
import '../presentation/view/pages/sale_page.dart';
import 'app_constansts.dart';

class AppRouting {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.mealPage:
        Meal meal = settings.arguments as Meal  ;
        return MaterialPageRoute(builder: (_)=> MealPage(meal:meal),settings:settings);
        case Routes.cartPage:
        return MaterialPageRoute(builder: (_)=> CartPage(),settings:settings);
      case Routes.bottomNavBarPage:
        return MaterialPageRoute(
            builder: (_) => BottomNavBarPage(), settings: settings);
      case Routes.loginPage:
        return MaterialPageRoute(
            builder: (_) => LoginPage(), settings: settings);
        case Routes.salePage:
        return MaterialPageRoute(
            builder: (_) => SalePage(), settings: settings);
      default:
        return MaterialPageRoute(
            builder: (_) => BottomNavBarPage(), settings: settings);
    }
  }
}
