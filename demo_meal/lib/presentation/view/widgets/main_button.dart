import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../utils/dimension_scale.dart';


class MainButton extends StatelessWidget {
  var  onTap;
   String title;
  late Color buttonColor;
  late Color textColor;

  MainButton(
      {required this.title,
      required this.onTap,
      this.buttonColor = Colors.black,
     this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    Dimension scaleDimension = GetIt.instance.get<Dimension>();
    return  InkWell(
      onTap:onTap,
      child: AnimatedContainer(
        

          height: scaleDimension.scaleHeight(40),
          //width: scaleDimension.scaleWidth(170),
          decoration: BoxDecoration(
              color: buttonColor,
              borderRadius:
                  BorderRadius.circular(scaleDimension.scaleHeight(16))),
          padding: EdgeInsets.symmetric(
              horizontal: scaleDimension.scaleWidth(20),
              vertical: scaleDimension.scaleHeight(7)),
          duration: Duration(milliseconds: 200),
          child: Center(
            child: Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: scaleDimension.scaleWidth(22),
                    color: textColor)),
          ),
        ),
    );
  }
}
