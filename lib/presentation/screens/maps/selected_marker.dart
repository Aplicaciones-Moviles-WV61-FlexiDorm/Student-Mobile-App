import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const markerColor = Color.fromARGB(255, 169, 63, 211);

class SelectedMarker extends AnimatedWidget {
  const SelectedMarker({super.key, required Animation<double> animation})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final value = (listenable as Animation<double>).value;
    final newSize = 50.0 * value;

    return Stack(
      children: [
        Center(
          child: Container(
            height: newSize,
            width: newSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: markerColor.withOpacity(0.5),
            ),
          ),
        ),
        Center(
          child: Container(
            height: 20,
            width: 20,
            decoration: const BoxDecoration(
              color: markerColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
