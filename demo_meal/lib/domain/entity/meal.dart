// Meal class represent data needed about each meal
class Meal {
  String name;
  String imgPath;
  double price;
  int categoryCode;
  String ingredients;
  double saleValue;
  double rate;
  String id;
  Meal({
    required this.name,
    required this.imgPath,
    required this.price,
    required this.categoryCode,
    required this.ingredients,
    required this.rate,
    required this.id,
    this.saleValue=0.0,

  });
  
}
