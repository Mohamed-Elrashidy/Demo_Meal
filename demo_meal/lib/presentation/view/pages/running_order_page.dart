import 'package:demo_meal/presentation/controller/order_controller/order_cubit.dart';
import 'package:demo_meal/presentation/view/widgets/big_text.dart';
import 'package:demo_meal/presentation/view/widgets/main_button.dart';
import 'package:demo_meal/presentation/view/widgets/normal_text.dart';
import 'package:demo_meal/utils/dimension_scale.dart';
import 'package:demo_meal/utils/user_level.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/entity/order.dart';
import '../../../domain/entity/user.dart';
import '../../controller/user_controller/user_cubit.dart';

class RunningOrderPage extends StatelessWidget {
  List<Order> orders = [];
  Dimension scaleDimension = GetIt.instance.get<Dimension>();
  User? user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body:
    Column(
      children: [
        SizedBox(height: scaleDimension.scaleHeight(20),),

        BigText(text: "Running Orders"),
        SizedBox(height: scaleDimension.scaleHeight(20),),
        orderListBuilder()

      ],
    )
      ,));
  }

  Widget orderListBuilder() {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserInfoLoaded) {
          user = state.user;
          BlocProvider.of<OrderCubit>(context).getOrders(
              user!.email, user!.level);
        }
        return Container(
          height: scaleDimension.scaleHeight(500),
          child: BlocBuilder<OrderCubit, OrderState>(
            builder: (context, state) {
              if(state is OrderLoaded)
                orders=state.orders;
              return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (_, index) {
                return Column(
                  children: [
                    orderItem(orders[index],context),
                    SizedBox(height: scaleDimension.scaleHeight(10),)
                  ],
                );
              });
            },
          ),
        );
      },
    );
  }

  Widget orderItem(Order order,BuildContext context) {
    return Container(
      padding: EdgeInsets.all(scaleDimension.scaleWidth(10)),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(scaleDimension.scaleWidth(20))
      ),
      height: scaleDimension.scaleHeight(160),
      width: scaleDimension.screenWidth-scaleDimension.scaleWidth(20),
      child: Column(
        children: [
          orderField('Id', order.id),
          SizedBox(height: scaleDimension.scaleHeight(5),),
          orderField('Phone', order.phone),
          SizedBox(height: scaleDimension.scaleHeight(5),),
          orderField('Price', order.price),
          SizedBox(height: scaleDimension.scaleHeight(10),),
  orderField('Address', order.address),
          SizedBox(height: scaleDimension.scaleHeight(10),),

          Container(
              width: scaleDimension.scaleWidth(150),
              child: InkWell(
                  onDoubleTap: () async {
                    if(user!.level==3)
                      return;
                    if(order.status== "Making" )
                      {
                       await BlocProvider.of<OrderCubit>(context).updateOrderStatus(order.deviceToken,"Shipping",order.id);
                      }
                    else if(order.status=="Shipping")
                      {
                        await BlocProvider.of<OrderCubit>(context).updateOrderStatus(order.deviceToken,"Completed",order.id);

                      }
                    BlocProvider.of<OrderCubit>(context).getOrders(user!.email, user!.level);
                  },
                  child: MainButton(title: order.status,onTap: (){},)))

        ],
      ),
    );
  }
 Widget orderField(String title,String value)
  {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NormalText(text: title+':'),
        Container(
            width:scaleDimension.scaleWidth(290),
            child: NormalText(text: value))
      ],
    );
  }
}

