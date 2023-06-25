import 'package:demo_meal/presentation/view/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../utils/dimension_scale.dart';

class BigImageBuilder extends StatelessWidget {
  // draw meal image with title on it with full width parameter to determine to make it take all page width
  String imgPath;
  String title;
  bool isFullWidth;
  BigImageBuilder(
      {required this.imgPath, required this.title, required this.isFullWidth});

  Dimension scaleDimension = GetIt.instance.get<Dimension>();
  late double width;
  late double height;
  @override
  Widget build(BuildContext context) {
    width = scaleDimension.screenWidth -
        ((!isFullWidth) ? scaleDimension.scaleWidth(50) : -scaleDimension.scaleWidth(11));
    height = isFullWidth
        ? scaleDimension.scaleHeight(220)
        : scaleDimension.scaleHeight(200);
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: [
            imageWidget(),
            isolater(),
            textWidget()
        ],
      ),
    );
  }

  Widget imageWidget() {
    return ClipRRect(
        borderRadius: isFullWidth
            ? BorderRadius.only(
                bottomLeft: Radius.circular(scaleDimension.scaleWidth(20)),
                bottomRight: Radius.circular(scaleDimension.scaleWidth(20)))
            : BorderRadius.circular(scaleDimension.scaleWidth(20)),
        child: Image.network(imgPath,
            width: width, height: height, fit: BoxFit.cover));
  }
  Widget isolater()
  {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: isFullWidth? BorderRadius.only(
            bottomLeft: Radius.circular(scaleDimension.scaleWidth(20)),
            bottomRight: Radius.circular(scaleDimension.scaleWidth(20)))
            : BorderRadius.circular(scaleDimension.scaleWidth(20))

      ),
    );
  }
  Widget textWidget()
  {
   return Positioned(
       left: scaleDimension.scaleWidth(20),
       bottom: scaleDimension.scaleHeight(20),
       child: Container(
           width: width-scaleDimension.scaleWidth(20),
           child: BigText(text:title,color: Colors.white,)));
  }
}
