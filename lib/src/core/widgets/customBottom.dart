import 'package:flutter/material.dart';
import 'package:my_gallery/src/core/extenstions/empty_box_extention.dart';
import 'package:my_gallery/src/core/extenstions/size_extention.dart';
import 'package:my_gallery/src/core/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double borderRadius;
  final double padding;
  final String iconPath;
  final bool haveIcon;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.mainColor,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.padding = 0.0,
    this.iconPath = '',
    this.haveIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.all(padding),
        width: context.width,
        height: context.height * 0.06,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(borderRadius)),
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: haveIcon == false
              ? Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w700),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      iconPath,
                      height: context.height * 0.1,
                      width: context.width * 0.1,
                    ),
                    (context.width * 0.025).emptyBoxWidth,
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: textColor,
                          fontSize: 25,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
