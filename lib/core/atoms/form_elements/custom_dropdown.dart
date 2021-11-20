import 'package:flutter/material.dart';

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
            iconSize: 24,
            elevation: 4,
            isExpanded: true,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            isDense: true,
            onChanged: onChanged,
            items: items,
          ),
        ],
      ),
    );
  }
}
