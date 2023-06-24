import 'package:demo_meal/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:demo_meal/domain/base_repository/base_order_repository.dart';
import 'package:demo_meal/domain/entity/order.dart';
import 'package:demo_meal/utils/app_constansts.dart';

import '../models/order_model.dart';

class OrderRepository extends BaseOrderRepository {
  RemoteDataSource remoteDataSource;
  OrderRepository({required this.remoteDataSource});

  @override
  Future<void> makeOrder(Order order) async {
    if(order.price!='0.0'&&order.price!='0')
    {OrderModel orderModel = convertFromOrdertoOrderModel(order);
    await remoteDataSource.addDataDocument(
        AppConstants.ordersPath, orderModel.toJson());}
  }

  OrderModel convertFromOrdertoOrderModel(Order order) {
    return OrderModel(
        id: order.id,
        email: order.email,
        details: order.details,
        deviceToken: order.deviceToken,
        status: order.status,
        address: order.address,
        price: order.price,
        phone: order.phone);
  }

  @override
  getOrders() async {
    List<OrderModel> orders = [];
    var data =
        await remoteDataSource.getDataCollection(AppConstants.ordersPath);
    data.forEach((element) {
      OrderModel order = OrderModel.fromJson(element);
      if (order.status != "Completed") {
        orders.add(order);
      }
    });
    return orders;
  }

  @override
  updateOrderStatus(String token, String newStatus,String documentId) async {
  await  remoteDataSource.updateDocumentAttribute(AppConstants.ordersPath, [documentId], "status", newStatus);
  await remoteDataSource.sendPushNotification("Order Status Updated", "Order with $documentId is $newStatus", [token]);
  }
}
