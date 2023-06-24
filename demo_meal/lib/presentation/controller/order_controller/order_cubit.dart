import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entity/meal.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());
  Map<Meal,int> _cart={};

  void increment(Meal meal)
  {
    print ("cart is => ");
    print (_cart);
    print(_cart.length);
    if(_cart.containsKey(meal))
      {
        _cart[meal]=_cart[meal]!+1;
      }
    else
      {
        _cart.putIfAbsent(meal, () => 1);
      }
    emit(CartChanged());
    emit(Idle());

  }
  void decrement(Meal meal)
  {
    if(_cart.containsKey(meal))
    {
      _cart[meal]=_cart[meal]!-1;
      if(_cart[meal]==0)
        {
          _cart.remove(meal);
        }
      emit(CartChanged());
      emit(Idle());
    }
  }
  int getMealNumber(Meal meal)
  {
    return _cart[meal]??0;
  }
  Map<Meal,int> getCartItems()
  {
    return _cart;
  }
  double getTotalPrice()
  {
    double cost=0;
    _cart.forEach((key, value) {
      cost+=key.price*value;
    });
    return cost;
  }

  void makeOrder(String address)
  {
    _cart.clear();
  }
}
