import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../utils/dimension_scale.dart';
class AppIcon extends StatelessWidget {
  final IconData icon;
  final ontap;
   AppIcon(
      {required this.icon, this.ontap});
  Dimension scaleDimension = GetIt.instance.get<Dimension>();
  @override
  Widget build(BuildContext context) {

    return InkWell(
        onTap: ontap,
        child: Container(
          padding: EdgeInsets.only(left: scaleDimension.scaleHeight(4)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(scaleDimension.scaleHeight(30)),
            color:Colors.grey[200],
          ),
          height: scaleDimension.scaleHeight(45),
          width: scaleDimension.scaleHeight(45),
          child: Icon(icon,
              size: scaleDimension.scaleHeight(24) ,
              color: Colors.black),
        ));
  }
}
