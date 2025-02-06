import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon? icon;
  final Color? backclr;
  final Color? iconclr;
  final bool? circle;
  final double? height;
  final double? width;
  final String? text;
  final bool? isIcon;
  CustomButton({
    required this.onPressed,
    this.icon,
    this.backclr,
    this.iconclr,
    this.circle,
    this.height,
    this.width,this.text,this.isIcon
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: backclr, // Button color
          shape: circle == true
              ? BoxShape.circle
              : BoxShape.rectangle, // Circular shape
          boxShadow: [
            BoxShadow(
              color: Colors.black26, // Shadow color
              blurRadius: 6, // Shadow blur effect
              offset: Offset(0, 3), // Shadow offset
            ),
          ],
        ),
        child: Center(child: isIcon == true ? icon : Text(text ?? '',style: TextStyle(color: Colors.white),))
      ),
    );
  }
}
