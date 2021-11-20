import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class YearItem extends ConsumerWidget {
  const YearItem({
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
}
