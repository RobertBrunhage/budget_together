import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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
}
