import 'package:demo_meal/domain/entity/order.dart';

abstract class BaseOrderRepository{
  Future<void> makeOrder(Order order);
   getOrders();



}