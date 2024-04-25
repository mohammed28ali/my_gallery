import 'package:flutter/material.dart';
import 'package:my_gallery/src/core/utils/app_colors.dart';
import 'package:my_gallery/src/core/utils/app_values.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final FormFieldValidator<String> validator;
  final bool obscureText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onToggleVisibility;

  CustomTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    required this.validator,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onToggleVisibility,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField(
      validator: validator,
      builder: (FormFieldState<String> state) {
        final error = state.hasError;
        final height = error ? 70.0 : 50.0;

        return Container(
          height: height,
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 15, color: Colors.black),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              hintText: hintText,
              hintStyle:
                  const TextStyle(color: AppColors.hintColor, fontSize: 15),
              filled: true,
              fillColor: AppColors.whiteColor2,
              isDense: true,
              prefixIcon: prefixIcon != null
                  ? Icon(
                      prefixIcon,
                      color: AppColors.mainColor,
                      size: 25,
                    )
                  : null,
              suffixIcon: suffixIcon != null
                  ? IconButton(
                      icon: Icon(
                        obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.mainColor,
                        size: 25,
                      ),
                      onPressed: () {
                        if (onToggleVisibility != null) {
                          onToggleVisibility!();
                        }
                      },
                    )
                  : null,
              errorText: state.hasError ? state.errorText : null,
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.whiteColor2, width: 1.5),
                borderRadius: BorderRadius.circular(AppSize.s35),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.whiteColor2, width: 1.5),
                borderRadius: BorderRadius.circular(AppSize.s35),
              ),
              errorBorder: OutlineInputBorder(
                gapPadding: 15,
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
                borderRadius: BorderRadius.circular(AppSize.s35),
              ),
              focusedErrorBorder: OutlineInputBorder(
                gapPadding: 15,
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
                borderRadius: BorderRadius.circular(AppSize.s35),
              ),
            ),
            onChanged: (value) {
              state.didChange(value);
            },
          ),
        );
      },
    );
  }
}
