part of 'order_cubit.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}
class CartChanged extends OrderState
{}
class Idle extends OrderState
{}
class OrderLoaded extends OrderState{
  List<Order> orders;
  OrderLoaded({required this.orders});
}