import 'package:flutter/material.dart';

import '../../../core/extensions/extensions.dart';

class OrderField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String hintText;

  const OrderField({
    super.key,
    required this.title,
    required this.controller,
    required this.validator,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    const defaultBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textStyles.textMedium.copyWith(fontSize: 16),
          overflow: TextOverflow.ellipsis,
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: defaultBorder,
            enabledBorder: defaultBorder,
            focusedBorder: defaultBorder,
            contentPadding: EdgeInsets.zero,
          ),
          validator: validator,
        ),
      ],
    );
  }
}
