import 'package:demo_meal/domain/base_repository/base_order_repository.dart';

import '../entity/order.dart';

class MakeOrderUseCase{
BaseOrderRepository baseOrderRepository;
MakeOrderUseCase({required this.baseOrderRepository});
execute(Order order)
async {
  await baseOrderRepository.makeOrder(order);
}
}