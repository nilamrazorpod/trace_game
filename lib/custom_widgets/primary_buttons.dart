import 'package:flutter/material.dart';

import '../app_config/app_size.dart';
import '../app_config/custom_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool fullWidth;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final Widget? imageIcon; // Icon widget for Google sign-in button, etc.

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.fullWidth = true,
    this.backgroundColor = Colors.black,
    this.foregroundColor = Colors.white,
    this.borderColor,
    this.imageIcon,
  });

  @override
  Widget build(BuildContext context) {
    return _buildButton();
  }

  Widget _buildButton() {
    return Row(
      children: [
        if (!fullWidth) const Spacer(),
        Expanded(
          flex: fullWidth ? 1 : 2,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: Sizes.p16),
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Sizes.p8),
                side: BorderSide(
                  color: borderColor ?? Colors.transparent,
                  width: 1.0, // Adjust the width as needed
                ),
              ),
            ),
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (imageIcon != null) ...[
                  imageIcon!, // Display the imageIcon if it's provided
                  const SizedBox(
                    width: Sizes.p8,
                  ), // Add spacing between icon and text
                ],
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: CustomTextSty.style14NTextColor.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
