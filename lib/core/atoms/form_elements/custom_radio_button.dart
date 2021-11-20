import 'package:flutter/material.dart';

class CustomRadioButton extends FormField<bool> {
  CustomRadioButton({
    Key? key,
    required String title,
    required FormFieldSetter<bool>? onSaved,
    FormFieldValidator<bool>? validator,
    bool initialValue = false,
    bool autovalidate = false,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          builder: (FormFieldState<bool> state) {
            return CheckboxListTile(
              dense: state.hasError,
              title: Text(title),
              value: state.value,
              onChanged: state.didChange,
              controlAffinity: ListTileControlAffinity.leading,
            );
          },
        );
}
