import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../widget_book/widget_book_multi_center.dart';

@WidgetbookUseCase(name: 'active', type: CustomRadioButton)
Widget widgetBookCustomRadioButton(BuildContext context) {
  return WidgetBookCenter(children: [CustomRadioButton(title: 'isActive', onChanged: (value) {}, value: true)]);
}

@WidgetbookUseCase(name: 'not active', type: CustomRadioButton)
Widget widgetBookCustomRadioButton2(BuildContext context) {
  return WidgetBookCenter(children: [CustomRadioButton(title: 'isActive', onChanged: (value) {})]);
}

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({
    Key? key,
    required this.title,
    required this.onChanged,
    this.value = false,
  }) : super(key: key);

  final String title;
  final bool value;
  final ValueChanged<bool?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<ValueChanged<bool?>?>.has('onChanged', onChanged));
    properties.add(StringProperty('title', title));
    properties.add(DiagnosticsProperty<bool>('value', value));
  }
}
