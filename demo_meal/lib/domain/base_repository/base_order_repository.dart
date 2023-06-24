import 'package:demo_meal/domain/entity/order.dart';

abstract class BaseOrderRepository{
  Future<void> makeOrder(Order order);
   getOrders();
  updateOrderStatus(String token,String newStatus,String documentId);



}