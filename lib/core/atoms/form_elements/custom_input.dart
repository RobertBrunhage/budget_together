import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormInput extends StatefulWidget {
  const CustomFormInput({
    Key? key,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    required this.errorMessage,
    required this.label,
  }) : super(key: key);

  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final String errorMessage;
  final String label;

  @override
  State<CustomFormInput> createState() => _CustomFormInputState();
}

class _CustomFormInputState extends State<CustomFormInput> {
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _focusNode.requestFocus,
      child: Container(
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
                widget.label,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            TextFormField(
              focusNode: _focusNode,
              validator: widget.validator,
              keyboardType: widget.keyboardType,
              inputFormatters: widget.inputFormatters,
              onChanged: widget.onChanged,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                isDense: true,
                errorStyle: const TextStyle(height: 0),
                labelStyle: Theme.of(context).textTheme.headline2!.copyWith(
                      height: 0.8,
                      color: widget.errorMessage.isEmpty
                          ? Colors.grey.shade600
                          : Colors.red,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
