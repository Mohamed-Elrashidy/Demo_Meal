import 'package:demo_meal/presentation/controller/order_controller/order_cubit.dart';
import 'package:demo_meal/presentation/view/widgets/app_icon.dart';
import 'package:demo_meal/utils/dimension_scale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/entity/meal.dart';
import '../../../utils/routes.dart';
import '../widgets/big_text.dart';
import '../widgets/normal_text.dart';

class CartPage extends StatelessWidget {
  Dimension scaleDimension = GetIt.instance.get<Dimension>();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customAppBar(context),
            cartContentViewer(),
            textFieldBuilder("Address", "Enter your address", addressController),
            buyButton(context)
             
          ],
        ),
      ),
    );
  }

  Widget customAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(scaleDimension.scaleWidth(10)),
      child: AppIcon(
        icon: Icons.arrow_back_ios,
        ontap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget cartContentViewer() {
    return Container(
      height: scaleDimension.scaleHeight(400),
      child: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          Map<Meal, int> cart =
          BlocProvider.of<OrderCubit>(context).getCartItems();
          List<Meal> cartItems = [];
          List<int> numOfApperance = [];
          cart.forEach((key, value) {
            cartItems.add(key);
            numOfApperance.add(value);
          });
          return ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: EdgeInsets.all(scaleDimension.scaleWidth(10)),
                  child:
                  cartItemViewer(
                      context, cartItems[index], numOfApperance[index]),
                );
              });
        },
      ),
    );
  }

  Widget cartItemViewer(BuildContext context, Meal meal, int numOfAppearance) {
    // show item image and number of appearance price buttons to add and remove
    return Row(
      children: [
        imageViewer(meal.imgPath),
        dataViewer(context, meal, numOfAppearance)
      ],
    );
  }

  Widget imageViewer(String imgPath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(scaleDimension.scaleWidth(15)),
      child: Image.network(
        imgPath,
        fit: BoxFit.cover,
        width: scaleDimension.scaleWidth(120),
        height: scaleDimension.scaleWidth(120),
      ),
    );
  }

  Widget dataViewer(BuildContext context, Meal meal, int numOfAppearance) {
    // show title and total cost of item appearance
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(scaleDimension.scaleWidth(15))),
      height: scaleDimension.scaleWidth(100),
      width: scaleDimension.scaleWidth(280),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: scaleDimension.scaleWidth(130)
              ,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [BigText(text: meal.name),
                  BigText(
                    text: "${meal.price * numOfAppearance}", color: Colors.red,)
                ],
              ),
            ),
            addingAndRemovingWidget(context, meal, numOfAppearance)
          ],
        ),
      ),
    );
  }

  Widget addingAndRemovingWidget(BuildContext context, Meal meal, int num) {
    // widget that allows user to add or remove one value of items from the cart
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(scaleDimension.scaleWidth(40))
      ),
      child: Row(
        children: [
          IconButton(onPressed: () {
            BlocProvider.of<OrderCubit>(context).decrement(meal);
          }, icon: Icon(Icons.remove),),
          NormalText(text: num.toString()),
          IconButton(onPressed: () {
            BlocProvider.of<OrderCubit>(context).increment(meal);
          }, icon: Icon(Icons.add),),


        ],
      ),
    );
  }

  Widget textFieldBuilder(String title, String hint,
      TextEditingController controller) {
    return Container(
      padding: EdgeInsets.all(scaleDimension.scaleWidth(10)),
      width: scaleDimension.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: title, size: scaleDimension.scaleWidth(18)),
          SizedBox(
            height: scaleDimension.scaleHeight(10),
          ),
          Container(
            padding:
            EdgeInsets.symmetric(horizontal: scaleDimension.scaleWidth(10)),
            decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(scaleDimension.scaleWidth(16)),
                border: Border.all(color: Colors.grey[400]!, width: 1.5)),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                    fontSize: scaleDimension.scaleWidth(14),
                    color: Colors.grey[400]),
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buyButton(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
       double cost= BlocProvider.of<OrderCubit>(context).getTotalPrice();
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                BlocProvider.of<OrderCubit>(context).makeOrder(addressController.text);
                Navigator.of(context).pushNamedAndRemoveUntil(Routes.bottomNavBarPage, (route) => false);
              },
              child: Container(
                height: scaleDimension.scaleHeight(50),
                width: scaleDimension.scaleWidth(150),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(scaleDimension.scaleWidth(20))
                ),
                child: Center(child: BigText(text: "Buy  $cost",color: Colors.white,)),
              ),
            ),
          ],
        );
      },
    );
  }

}
