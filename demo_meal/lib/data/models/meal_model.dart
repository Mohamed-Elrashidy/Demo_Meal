import '../../domain/entity/meal.dart';

class MealModel extends Meal {
  MealModel(
      {
      required super.name,
      required super.imgPath,
      required super.price,
      required super.categoryCode,
      required super.ingredients,
      required super.rate,
      required super.id,
      super.saleValue=0.0
      });
      factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      name: json['name'],
      imgPath: json['imgPath'],
      price: double.parse(json['price']),
      categoryCode: int.parse(json['categoryCode']),
      ingredients: json['ingredients'],
      rate:double.parse(json['rate']),
      id:json['id'],
      saleValue: double.parse(json['saleValue'])??0.0
    );

  }

  

      
}
