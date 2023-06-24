import 'package:demo_meal/presentation/controller/meal_controller/meal_cubit.dart';
import 'package:demo_meal/presentation/view/widgets/app_icon.dart';
import 'package:demo_meal/presentation/view/widgets/big_text.dart';
import 'package:demo_meal/presentation/view/widgets/main_button.dart';
import 'package:demo_meal/presentation/view/widgets/normal_text.dart';
import 'package:demo_meal/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/entity/meal.dart';
import '../../../utils/dimension_scale.dart';

class SalePage extends StatelessWidget {
  Dimension scaleDimension = GetIt.instance.get<Dimension>();
  TextEditingController saleValueController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MealCubit>(context).getMeals();
    saleValueController.text='0';
    titleController.text='Big Sale';

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(scaleDimension.scaleWidth(10)),
          child: SingleChildScrollView(
            child: Column(
              children: [

                customAppBar(context),
                SizedBox(height: scaleDimension.scaleHeight(30),),
                textFieldBuilder(
                    "Sale value", "Enter sale value", saleValueController),
                SizedBox(height: scaleDimension.scaleHeight(20),),

                textFieldBuilder(
                    "Sale Title", "Enter title", titleController),
                SizedBox(height: scaleDimension.scaleHeight(30),),
                listAllMealsName(context),
                Container(width: scaleDimension.scaleWidth(100),
                  child: MainButton(title: "Send", onTap: () async {
                    await BlocProvider.of<MealCubit>(context).makeSale(titleController.text,saleValueController.text);
                    Navigator.of(context).pushNamedAndRemoveUntil(Routes.bottomNavBarPage, (route) => false);
                  }),
                )



              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppIcon(
          icon: Icons.arrow_back_ios_new,
          ontap: () {
            Navigator.of(context).pop();
          },
        ),
        BigText(text: "Sale"),
        // for alignment
        Container(width: scaleDimension.scaleWidth(30),)

      ],
    );
  }

  Widget textFieldBuilder(String title, String hint,
      TextEditingController controller) {
    return SizedBox(
      width:
      scaleDimension.screenWidth - scaleDimension.scaleWidth(20),
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

  Widget listAllMealsName(BuildContext context) {
    List<Meal> meals = [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

       Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
         BigText(text: "Meals"),
       InkWell( onTap: (){
         BlocProvider.of<MealCubit>(context).addAllToSale();
       }, child:NormalText(text: "select all"))
       ],),
        Container(
          height: scaleDimension.scaleHeight(250),
          child: BlocBuilder<MealCubit, MealState>(
            builder: (context, state) {
              if (state is MealLoaded) {
                meals = state.meals;
              }
              return ListView.builder(
                  itemCount: meals.length,
                  itemBuilder: (_, index) {
                    return BlocBuilder<MealCubit, MealState>(
                     
                      builder: (context, state) {
                        bool isAdded=false;
                        if(state is SaleStateChanged)
                        {
                          isAdded = BlocProvider.of<MealCubit>(context).getSaleState(meals[index].id);
                        }
                        return Row(
                          children: [
                            IconButton(onPressed: (){
                              BlocProvider.of<MealCubit>(context).changeState(meals[index].id);
                            }, icon: Icon(isAdded?Icons.check_box_outlined:Icons.check_box_outline_blank)),
                            NormalText(text: meals[index].name)
                          ],
                        );
                      },
                    );
                  });
            },
          ),
        ),

      ],
    );
  }
}
