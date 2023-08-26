import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/material.dart';

class CustomAnimatedIcon extends StatelessWidget {
  final Color color;
  final AnimateIcons animateIcon;
  const CustomAnimatedIcon(
      {super.key, required this.color, required this.animateIcon});

  @override
  Widget build(BuildContext context) {
    return AnimateIcon(
      key: UniqueKey(),
      onTap: () {},
      iconType: IconType.continueAnimation,
      color: color,
      animateIcon: animateIcon,
    );
  }
}
