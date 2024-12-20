import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  /// the base color of the images background and its concentric circles.
  final Color primaryColor;

  /// the profile image to be displayed.
  final String imagePath;

  ///the diameter of the entire widget, including the concentric circles.
  final double size;

  /// the width between the edges of each concentric circle.
  final double transitionBorderwidth;

  const Avatar(
      {super.key,
      required this.primaryColor,
      required this.imagePath,
      this.size = 190.0,
      this.transitionBorderwidth = 20.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Container(
            child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: primaryColor.withOpacity(0.05)),
        )),
        Container(
          child: Container(
              height: size - transitionBorderwidth,
              width: size - transitionBorderwidth,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                    stops: [0.01, 0.5],
                    colors: [Colors.white, primaryColor.withOpacity(0.1)]),
              )),
        ),
        Container(
          child: Container(
              height: size - (transitionBorderwidth * 2),
              width: size - (transitionBorderwidth * 2),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor.withOpacity(0.4))),
        ),
        Container(
          child: Container(
              height: size - (transitionBorderwidth * 3),
              width: size - (transitionBorderwidth * 3),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor.withOpacity(0.5))),
        ),
        Container(
            child: Container(
                height: size - (transitionBorderwidth * 1),
                width: size - (transitionBorderwidth * 1),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill, image: AssetImage(imagePath)))))
      ],
    );
  }
}
