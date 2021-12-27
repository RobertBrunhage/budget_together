import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../widget_book/widget_book_multi_center.dart';

@WidgetbookUseCase(name: 'default', type: CustomDropdownButton)
Widget widgetBookCustomDropdownButton(BuildContext context) {
  return WidgetBookCenter(
    children: [
      CustomDropdownButton<String>(
        items: const [
          DropdownMenuItem<String>(
            value: 'item',
            child: Text('item'),
          ),
        ],
        label: 'test',
        value: 'item',
        onChanged: (value) {},
      ),
    ],
  );
}

class CustomDropdownButton<T> extends StatelessWidget {
  const CustomDropdownButton({
    Key? key,
    required this.value,
    required this.items,
    required this.label,
    this.onChanged,
  }) : super(key: key);

  final T value;
  final ValueChanged<T?>? onChanged;
  final String label;
  final List<DropdownMenuItem<T>>? items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          DropdownButtonFormField<T>(
            value: value,
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            elevation: 4,
            isExpanded: true,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            onChanged: onChanged,
            items: items,
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('label', label));
    properties.add(DiagnosticsProperty<T>('value', value));
    properties.add(ObjectFlagProperty<ValueChanged<T?>?>.has('onChanged', onChanged));
  }
}
