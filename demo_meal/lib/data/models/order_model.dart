import '../../domain/entity/order.dart';

class OrderModel extends Order {
  OrderModel(
      {required super.id,
      required super.email,
      required super.details,
      required super.deviceToken,
      required super.status,
      required super.address,
        required super.phone,
        required super.price
      });

  toJson()
  {
    Map<String,String> json={};
    json['id']=id;
    json['email']=email;
    json['details']=details;
    json['deviceToken']=deviceToken;
    json['status']=status;
    json['price']=price;
    json['phone']=phone;
    json['address']=address;

    return json;
  }
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
        id: json['id'],
        email:json['email'],
        status: json['status'],
        details:json['details'],
        deviceToken: json['deviceToken'],
        price: json['price'],
        phone: json['phone'],
        address: json['address'],

    );}
}
