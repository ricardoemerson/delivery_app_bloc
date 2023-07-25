import 'package:flutter/material.dart';

import '../extensions/app_colors_extension.dart';
import '../extensions/app_text_styles_extension.dart';

class IncrementDecrementButton extends StatelessWidget {
  final int amount;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const IncrementDecrementButton({
    super.key,
    required this.amount,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: onDecrement,
            icon: Icon(
              Icons.remove,
              color: context.colors.primary,
            ),
          ),
          Text(
            amount.toString(),
            style: context.textStyles.textRegular.copyWith(
              fontSize: 17,
              color: context.colors.secondary,
            ),
          ),
          IconButton(
            onPressed: onIncrement,
            icon: Icon(
              Icons.add,
              color: context.colors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
