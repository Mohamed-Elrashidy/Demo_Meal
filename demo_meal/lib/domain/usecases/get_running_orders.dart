import 'package:demo_meal/domain/base_repository/base_order_repository.dart';

import '../entity/order.dart';

class GetRunningOrdersUseCase{
  BaseOrderRepository baseOrderRepository;
  GetRunningOrdersUseCase({required this.baseOrderRepository});
  execute()
  async {
  return  await baseOrderRepository.getOrders();
  }
}