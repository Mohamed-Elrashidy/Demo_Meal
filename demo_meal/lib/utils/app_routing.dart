
import 'package:flutter/material.dart';

import '../presentation/view/pages/home_page.dart';

class AppRouting {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      default:
        return MaterialPageRoute(
            builder: (_) => HomePage(), settings: settings);
    }
  }
}
