import 'package:bloc/bloc.dart';
import 'package:demo_meal/data/repository/oreder_repository.dart';
import 'package:demo_meal/domain/entity/order.dart';
import 'package:demo_meal/domain/usecases/get_running_orders.dart';
import 'package:demo_meal/domain/usecases/update_order_status.dart';
import 'package:demo_meal/utils/user_level.dart';
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
    // increment number of units of this meal in order
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
    // decrement number of units of this meal in order

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

  Future<void> makeOrder(String address,String phone,String price,String token,String email) async {

// generate Id from email and time
    String id = generateId();
// convert list of meals and their unit numbers to specific format to be able to retrieve it
    String details = generateDetails();

    Order order = Order(
        id: id,
        email: email,
        details: details,
        deviceToken: token,
        status: "Making",
        address:address,
        phone: phone,
        price: price
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

  getOrders(String email,int level)
  async {
// check if user is normal client to show his specific orders only else show all not completed orders
  var data=  await  GetRunningOrdersUseCase(baseOrderRepository: GetIt.instance.get<OrderRepository>()).execute();
  List<Order> orders=[];
  data.forEach((element) {
    if(level!=3)
      {
        orders.add(element);
      }
    else
      {
        if(element.email==email)
          orders.add(element);

      }


  }

  );
  emit(OrderLoaded(orders:orders));
  return orders;
  }

  updateOrderStatus(String token,String newStatus,String orderId)
  async {
    emit(Idle());
    await UpdateOrderStatusUseCase(baseOrderRepository: GetIt.instance.get<OrderRepository>()).execute(token, newStatus, orderId);
  }
}
