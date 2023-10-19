import 'package:flutter/material.dart';

class MyTextFormField extends TextFormField {
  MyTextFormField({
    super.key,
    super.validator,
    super.onChanged,
    super.onSaved,
  }) : super(
          decoration: const InputDecoration(
            filled: true,
          ),
        );
}
