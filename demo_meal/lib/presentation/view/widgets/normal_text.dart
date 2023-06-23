import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../utils/dimension_scale.dart';


class NormalText extends StatelessWidget {
  final String text;
  late Color color;

  NormalText(
      {required this.text, this.color = Colors.black})
  {
}
  Dimension scaleDimension = GetIt.instance.get<Dimension>();
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: TextStyle(fontSize: scaleDimension.scaleWidth(17), color: color),
    );
  }
}
