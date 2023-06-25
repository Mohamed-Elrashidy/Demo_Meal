import 'package:demo_meal/presentation/controller/meal_controller/meal_cubit.dart';
import 'package:demo_meal/presentation/view/widgets/big_image_builder.dart';
import 'package:demo_meal/presentation/view/widgets/big_text.dart';
import 'package:demo_meal/presentation/view/widgets/normal_text.dart';
import 'package:demo_meal/utils/app_constansts.dart';
import 'package:demo_meal/utils/dimension_scale.dart';
import 'package:demo_meal/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/entity/meal.dart';
// at meals viewer only 2 meals exist but to show ui I repeated them but all appearance refer to same instance
class HomePage extends StatelessWidget {
  List<Meal> allMeals = [];
  late Dimension scaleDimension=GetIt.instance.get<Dimension>();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MealCubit>(context).getMeals();
    return SafeArea(
      child: Scaffold(
          // page main file bloc builder check if data is here or not and determine what to draw
          body: BlocBuilder<MealCubit, MealState>(
        builder: (context, state) {
          if (state is MealLoaded) {
            allMeals = state.meals;
            // page ui when data exist
            return dataLoaded(context);
          } else {
            return Container();
          }
        },
      )),
    );
  }

  Widget dataLoaded(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // show meals in horizontal scrollable way in the upper of the page
          recommendedMealsViewer(context),
             allMealsViewer()
        ],
      ),
    );
  }

  Widget recommendedMealsViewer(BuildContext context) {
    // get recommended meals
    List<Meal> recommendedMeals =
        BlocProvider.of<MealCubit>(context).getRecommendedMeals();

    return Padding(
      padding: EdgeInsets.all(scaleDimension.scaleWidth(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // section title
          SizedBox(
            height: scaleDimension.scaleHeight(20),
          ),
          BigText(text: "Recommended"),
          SizedBox(
            height: scaleDimension.scaleHeight(20),
          ),
          // meals viewer
          Container(
            width: scaleDimension.screenWidth,
            height: scaleDimension.scaleHeight(200),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: (){
                      Navigator.of(context,rootNavigator: true).pushNamed(Routes.mealPage,arguments: recommendedMeals[0]);
                    },
                    child: Row(
                      children: [
                        InkWell(
                          child: BigImageBuilder(
                            imgPath: recommendedMeals[0].imgPath,
                            title: recommendedMeals[0].name,
                            isFullWidth: false,
                          ),
                        ),
                        SizedBox(
                          width: scaleDimension.scaleWidth(10),
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget allMealsViewer() {
    // vertical viewer
    return Padding(
      padding: EdgeInsets.all(scaleDimension.scaleWidth(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // category title
          BigText(text: "All meals"),
          SizedBox(
            height: scaleDimension.scaleHeight(10),
          ),
          // all meals viewer
          Container(
            height: scaleDimension.scaleHeight(280),
            width: scaleDimension.screenWidth - scaleDimension.scaleWidth(20),
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      Navigator.of(context,rootNavigator: true).pushNamed(Routes.mealPage,arguments:allMeals[index % allMeals.length] );
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            imageViewer(allMeals[index % allMeals.length].imgPath),

                            dataViewer(allMeals[index % allMeals.length].name,
                                allMeals[index % allMeals.length].ingredients),
                          ],
                        ),
                        SizedBox(height: scaleDimension.scaleHeight(10),)
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget imageViewer(String imgPath) {
    // concern with image part at all meals section
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
  Widget dataViewer(String name,String ingredients)
  {// show title and ingredient of the meal
    return Container(
      decoration: BoxDecoration(color: Colors.grey[200],
      borderRadius: BorderRadius.circular(scaleDimension.scaleWidth(15))
      ),
      height: scaleDimension.scaleWidth(100),
      width:scaleDimension.scaleWidth(270) ,
      child:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BigText(text: name),
          NormalText(text: ingredients)
        ],
    ),
      ),);
  }
}
