import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../widget_book/widget_book_multi_center.dart';

@WidgetbookUseCase(name: 'active', type: YearToggle)
Widget widgetBookYearToggle(BuildContext context) {
  return WidgetBookCenter(children: [YearToggle(year: 2019, onTap: () {}, isActive: true)]);
}

@WidgetbookUseCase(name: 'not active', type: YearToggle)
Widget widgetBookYearToggle2(BuildContext context) {
  return WidgetBookCenter(children: [YearToggle(year: 2019, onTap: () {}, isActive: false)]);
}

class YearToggle extends ConsumerWidget {
  const YearToggle({
    Key? key,
    required this.year,
    required this.onTap,
    required this.isActive,
  }) : super(key: key);

  final int year;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        child: Text(
          year.toString(),
          style: Theme.of(context).textTheme.caption?.copyWith(
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<VoidCallback>.has('onTap', onTap));
    properties.add(DiagnosticsProperty<bool>('isActive', isActive));
    properties.add(IntProperty('year', year));
  }
}
