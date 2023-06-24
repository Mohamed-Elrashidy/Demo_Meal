import '../../domain/entity/order.dart';

class OrderModel extends Order {
  OrderModel(
      {required super.id,
      required super.email,
      required super.details,
      required super.deviceToken,
      required super.status,
      required super.address
      });

  toJson()
  {
    Map<String,String> json={};
    json['id']=id;
    json['email']=email;
    json['details']=details;
    json['deviceToken']=deviceToken;
    json['status']=status;
    return json;
  }
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
        id: json['id'],
        email:json['email'],
        status: json['status'],
        details:json['details'],
        deviceToken: json['deviceToken'],
      address: json['address'],

    );}
}
