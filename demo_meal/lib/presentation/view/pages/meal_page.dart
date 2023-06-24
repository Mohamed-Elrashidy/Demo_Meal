import 'package:demo_meal/presentation/controller/meal_controller/meal_cubit.dart';
import 'package:demo_meal/presentation/view/widgets/big_image_builder.dart';
import 'package:demo_meal/presentation/view/widgets/big_text.dart';
import 'package:demo_meal/presentation/view/widgets/normal_text.dart';
import 'package:demo_meal/utils/app_constansts.dart';
import 'package:demo_meal/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/entity/meal.dart';
import '../../../utils/dimension_scale.dart';
import '../../controller/order_controller/order_cubit.dart';
import '../widgets/app_icon.dart';

class MealPage extends StatelessWidget {
   Meal meal;
   MealPage({required this.meal});
  Dimension scaleDimension = GetIt.instance.get<Dimension>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                BigImageBuilder(
                    imgPath: meal.imgPath, title: meal.name, isFullWidth: true),
                customAppBar(context),
              ],
            ),
            ingredientViewer(context)
          ],
        ),
      ),
    );
  }

  Widget customAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(scaleDimension.scaleWidth(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppIcon(icon: Icons.arrow_back_ios, ontap: () {
            Navigator.of(context).pop();
          },),
          AppIcon(icon: Icons.shopping_cart,ontap: (){
            Navigator.of(context).pushNamed(Routes.cartPage);
          },)
        ],
      ),
    );
  }

  Widget ingredientViewer(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(scaleDimension.scaleWidth(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          SizedBox(
            height: scaleDimension.scaleHeight(10),
          ),
          // section title
          BigText(text: "Ingredients"),
          SizedBox(height: scaleDimension.scaleHeight(10)),
          ingredientListBuilder(),
          SizedBox(height: scaleDimension.scaleHeight(10),),
          addToCart(context)

        ],),
    );
  }

  Widget ingredientListBuilder() {
    // show ingredients
    List<String> ingredients = meal.ingredients.split(',');
    return Container(
      height: scaleDimension.scaleHeight(250),
      //width: scaleDimension.screenWidth,
      child: ListView.builder(
          itemCount: ingredients.length,
          itemBuilder: (_, index) {
            return Container(
              padding: EdgeInsets.all(scaleDimension.scaleWidth(10)),
              child: NormalText(text: "${index + 1} ) " + ingredients[index],),
            );
          }),
    );
  }

  Widget addToCart(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(onTap: () {
          BlocProvider.of<OrderCubit>(context).decrement(meal);
        }, child: customButton(Icons.remove)),
        BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            int num =0;
            if(state is Idle) {
              num=BlocProvider.of<OrderCubit>(context).getMealNumber(meal);

              print(num);
            }
            return BigText(text: "EGP ${meal.price} X $num");
          },
        ),
        InkWell(onTap: () {
          BlocProvider.of<OrderCubit>(context).increment(meal);
        }, child: customButton(Icons.add)),

      ],
    );
  }

  Widget customButton(IconData icon) {
    return CircleAvatar(
      radius: scaleDimension.scaleWidth(20),
      backgroundColor: Colors.black,
      child: Icon(
          icon, color: Colors.white, size: scaleDimension.scaleWidth(20)),
    );
  }
}
