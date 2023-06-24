class Order{
  String id;
  String email;
  String details;
  String deviceToken;
  String status;
  String address;
  String phone;
  String price;

  Order({
    required this.id,
    required this.email,
    required this.details,
    required this.deviceToken,
    required this.status,
    required this.address,
    required this.phone,
    required this.price
  });
}