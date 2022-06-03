import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../household/controllers/category_controller.dart';
import '../../household/controllers/household_controller.dart';
import '../../household/models/category/category.dart';
import '../../localization/generated/l10n.dart';
import '../atoms/form_elements/custom_dropdown.dart';
import '../atoms/form_elements/custom_form_input.dart';
import '../atoms/form_elements/custom_radio_button.dart';

class AddExpenseBottomSheet extends ConsumerStatefulWidget {
  const AddExpenseBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<AddExpenseBottomSheet> createState() => _AddExpenseBottomSheetState();
}

class _AddExpenseBottomSheetState extends ConsumerState<AddExpenseBottomSheet> {
  bool newCategory = false;
  final formGlobalKey = GlobalKey<FormState>();
  String? amount;
  String? categoryName;
  String? categoryBudgetAmount;
  late DateTime date;

  @override
  void initState() {
    super.initState();
    date = DateTime(
      ref.read(householdControllerProvider).selectedYear,
      ref.read(householdControllerProvider).selectedMonth,
    );
    final householdId = ref.read(householdControllerProvider).household.value!.id;
    ref.read(categoryControllerProvider.notifier).fetchCategories(householdId);
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(categoryControllerProvider).categories.when(
          data: (categories) {
            return Wrap(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 30,
                    right: 30,
                    left: 30,
                    bottom: 30 + MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Form(
                    key: formGlobalKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).addExpense,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        const SizedBox(height: 12),
                        CustomFormField(
                          label: S.of(context).sumLabelNotRequired,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).sumRequiredMessage;
                            }
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              amount = value;
                            });
                          },
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(
                              RegExp(r'[\\-|\\ ]'),
                            ),
                            FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d{0,2})'))
                          ],
                        ),
                        CustomRadioButton(
                          title: S.of(context).newCategory,
                          value: newCategory,
                          onChanged: (value) {
                            setState(() {
                              newCategory = value!;
                            });
                          },
                        ),
                        if (!newCategory) ...[
                          const SizedBox(height: 12),
                          CustomDropdownButton<Category>(
                            label: S.of(context).category,
                            value: ref.watch(categoryControllerProvider).category,
                            onChanged: (newValue) {
                              ref.read(categoryControllerProvider.notifier).setCategory(newValue!);
                            },
                            items: categories
                                ?.map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.name),
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(height: 12),
                        ],
                        if (newCategory) ...[
                          CustomFormField(
                            label: S.of(context).categoryNotRequiredLabel,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return S.of(context).categoryRequiredMessage;
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                categoryName = value;
                              });
                            },
                          ),
                          const SizedBox(height: 12),
                          CustomFormField(
                            label: S.of(context).categoryBudget,
                            onSaved: (value) {
                              setState(() {
                                categoryBudgetAmount = value;
                              });
                            },
                          ),
                        ],
                        SizedBox(
                          height: 100,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            initialDateTime: date,
                            maximumDate: DateTime.now(),
                            onDateTimeChanged: (newDateTime) {
                              // Do something
                              setState(() {
                                date = newDateTime;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: TextButton(
                            onPressed: () => addExpense(ref),
                            child: Text(S.of(context).add),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          error: (e, s) => Text(e.toString()),
          loading: () => const CircularProgressIndicator(),
        );
  }

  Future<void> addExpense(WidgetRef ref) async {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState!.save();
      if (categoryName == null || categoryName!.isEmpty) {
        await ref.read(householdControllerProvider.notifier).createExpense(
              double.parse(amount!),
              date,
            );
      } else {
        await ref.read(categoryControllerProvider.notifier).createCategory(
              ref.read(householdControllerProvider).household.value!.id,
              categoryName!,
            );
        await ref.read(householdControllerProvider.notifier).createExpense(
              double.parse(amount!),
              date,
            );
      }
      if (mounted) Navigator.of(context).pop();
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('categoryBudgetAmount', categoryBudgetAmount));
    properties.add(StringProperty('categoryName', categoryName));
    properties.add(StringProperty('amount', amount));
    properties.add(DiagnosticsProperty<bool>('newCategory', newCategory));
    properties.add(DiagnosticsProperty<GlobalKey<FormState>>('formGlobalKey', formGlobalKey));
    properties.add(DiagnosticsProperty<DateTime>('date', date));
  }
}
