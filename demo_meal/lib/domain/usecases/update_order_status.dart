import 'package:demo_meal/domain/base_repository/base_order_repository.dart';

import '../entity/order.dart';

class UpdateOrderStatusUseCase{
  BaseOrderRepository baseOrderRepository;
  UpdateOrderStatusUseCase({required this.baseOrderRepository});
 execute(String token,String newStatus,String documentId)
  async {
      await baseOrderRepository.updateOrderStatus( token, newStatus,documentId);
  }
}