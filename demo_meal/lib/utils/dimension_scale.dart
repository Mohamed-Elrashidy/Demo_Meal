
import 'package:flutter/material.dart';

class Dimension{
  BuildContext context;
  late double screenHeight;
  late double screenWidth;
  Dimension({required this.context}){
     screenHeight=MediaQuery.of(context).size.height;
     screenWidth=MediaQuery.of(context).size.width;
     screenWidth-=scaleWidth(10);
  }
// 650 and 410 refer to values of the screen tested to take ratios
// here at next two functions I first divide screen height to equal parts of the same height
// then I find if I divide the current screen height to same number what each part size will be and return the value
// same for width
   double scaleHeight(double h)
  {
    double y=650.0/h;
    return screenHeight/y;
  }
    double scaleWidth(double w)
  {
    double y=410.0/w;
    return screenWidth/y;
  }
}