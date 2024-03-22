import 'package:flutter/material.dart';

class CardWidget extends Card {
  const CardWidget({
    super.key,
    super.borderOnForeground,
    super.child,
    super.clipBehavior,
    super.color,
    super.elevation,
    super.margin,
    super.semanticContainer,
    super.shadowColor,
    super.shape,
    super.surfaceTintColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      key: key,
      borderOnForeground: borderOnForeground,
      clipBehavior: clipBehavior,
      color: color ?? Colors.white,
      elevation: elevation,
      margin: margin,
      semanticContainer: semanticContainer,
      shadowColor: shadowColor,
      shape: shape,
      surfaceTintColor: surfaceTintColor,
      child: child,
    );
  }
}
