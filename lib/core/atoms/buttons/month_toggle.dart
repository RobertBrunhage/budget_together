import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../widget_book/widget_book_multi_center.dart';

@WidgetbookUseCase(name: 'active', type: MonthToggle)
Widget widgetBookMonthToggle(BuildContext context) {
  return WidgetBookCenter(children: [MonthToggle(month: 2, onTap: () {}, isActive: true)]);
}

@WidgetbookUseCase(name: 'not active', type: MonthToggle)
Widget widgetBookMonthToggle2(BuildContext context) {
  return WidgetBookCenter(children: [MonthToggle(month: 2, onTap: () {}, isActive: false)]);
}

class MonthToggle extends ConsumerWidget {
  const MonthToggle({
    Key? key,
    required this.month,
    required this.onTap,
    required this.isActive,
  }) : super(key: key);

  final int month;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 26,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        decoration: BoxDecoration(
          color: isActive ? Colors.purple : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            DateFormat.MMM().format(DateTime(0, month)),
            style: Theme.of(context).textTheme.caption?.copyWith(
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive ? Colors.white : Colors.black,
                ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('month', month));
    properties.add(ObjectFlagProperty<VoidCallback>.has('onTap', onTap));
    properties.add(DiagnosticsProperty<bool>('isActive', isActive));
  }
}
