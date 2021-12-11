import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../widget_book/widget_book_multi_center.dart';

@WidgetbookUseCase(name: 'default', type: CustomFormField)
Widget widgetBookCustomFormField(BuildContext context) {
  return WidgetBookCenter(children: [CustomFormField(label: 'Name')]);
}

class CustomFormField extends FormField<String> {
  CustomFormField({
    Key? key,
    String? initialValue,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    required String label,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          builder: (state) {
            return _CustomFormInputAtom(
              state: state,
              label: label,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
            );
          },
        );
}

class _CustomFormInputAtom extends StatefulWidget {
  const _CustomFormInputAtom({
    Key? key,
    required this.state,
    required this.label,
    this.keyboardType,
    this.inputFormatters,
  }) : super(key: key);

  final String label;
  final FormFieldState<String> state;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<_CustomFormInputAtom> createState() => _CustomFormInputAtomState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('label', label));
    properties.add(DiagnosticsProperty<TextInputType?>('keyboardType', keyboardType));
    properties.add(IterableProperty<TextInputFormatter>('inputFormatters', inputFormatters));
    properties.add(DiagnosticsProperty<FormFieldState<String>>('state', state));
  }
}

class _CustomFormInputAtomState extends State<_CustomFormInputAtom> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _focusNode.requestFocus,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: !widget.state.hasError ? Colors.grey.shade600 : Colors.red,
                        ),
                  ),
                ),
                TextField(
                  focusNode: _focusNode,
                  keyboardType: widget.keyboardType,
                  inputFormatters: widget.inputFormatters,
                  onChanged: widget.state.didChange,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    isDense: true,
                  ),
                ),
              ],
            ),
          ),
          if (widget.state.hasError)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                widget.state.errorText ?? '',
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: !widget.state.hasError ? Colors.grey.shade600 : Colors.red,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
