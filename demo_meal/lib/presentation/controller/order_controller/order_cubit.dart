import 'package:bloc/bloc.dart';
import 'package:demo_meal/data/repository/oreder_repository.dart';
import 'package:demo_meal/domain/entity/order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../domain/entity/meal.dart';
import '../../../domain/usecases/make_order_usecase.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());
  Map<Meal, int> _cart = {};

  void increment(Meal meal) {
    print("cart is => ");
    print(_cart);
    print(_cart.length);
    if (_cart.containsKey(meal)) {
      _cart[meal] = _cart[meal]! + 1;
    } else {
      _cart.putIfAbsent(meal, () => 1);
    }
    emit(CartChanged());
    emit(Idle());
  }

  void decrement(Meal meal) {
    if (_cart.containsKey(meal)) {
      _cart[meal] = _cart[meal]! - 1;
      if (_cart[meal] == 0) {
        _cart.remove(meal);
      }
      emit(CartChanged());
      emit(Idle());
    }
  }

  int getMealNumber(Meal meal) {
    return _cart[meal] ?? 0;
  }

  Map<Meal, int> getCartItems() {
    return _cart;
  }

  double getTotalPrice() {
    double cost = 0;
    _cart.forEach((key, value) {
      cost += key.price * value;
    });
    return cost;
  }

  Future<void> makeOrder(String address) async {
    var user = FirebaseAuth.instance.currentUser;

    String id = generateId();
    String details = generateDetails();

    Order order = Order(
        id: id,
        email: user!.email!,
        details: details,
        deviceToken: "",
        status: "Making",
        address:""
    );
    await MakeOrderUseCase(
            baseOrderRepository: GetIt.instance.get<OrderRepository>())
        .execute(order);
    _cart.clear();
  }

  String generateId() {
    var user = FirebaseAuth.instance.currentUser;
    return DateTime.now().toString() + user!.email!;
  }

  String generateDetails() {
    String details = "";
    _cart.forEach((key, value) {
      details += key.id + ',' + value.toString() + '||';
    });
    return details;
  }
}
