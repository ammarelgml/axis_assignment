import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  final double size;
  final Color? color;

  const LoadingWidget({this.size = 40, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: LoadingAnimationWidget.inkDrop(color: color ?? Theme.of(context).primaryColor, size: size),
      ),
    );
  }
}
