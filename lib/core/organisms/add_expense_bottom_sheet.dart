import 'package:budget_together/core/atoms/form_elements/custom_dropdown.dart';
import 'package:budget_together/core/atoms/form_elements/custom_form_input.dart';
import 'package:budget_together/core/atoms/form_elements/custom_radio_button.dart';
import 'package:budget_together/new_household/controllers/category_controller.dart';
import 'package:budget_together/new_household/controllers/household_controller.dart';
import 'package:budget_together/new_household/models/category/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddExpenseBottomSheet extends ConsumerStatefulWidget {
  const AddExpenseBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<AddExpenseBottomSheet> createState() =>
      _AddExpenseBottomSheetState();
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
    date = DateTime(ref.read(householdControllerProvider).selectedYear,
        ref.read(householdControllerProvider).selectedMonth);
    final householdId =
        ref.read(householdControllerProvider).household.value!.id;
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
                          'Lägg till utgift',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        const SizedBox(height: 12),
                        CustomFormField(
                          errorMessage: 'Skriv in en summa',
                          label: 'Summa *',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Skriv in summan av din utgift';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              amount = value;
                            });
                          },
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(
                              RegExp('[\\-|\\ ]'),
                            ),
                            FilteringTextInputFormatter.allow(
                                RegExp(r'(^\d*\.?\d{0,2})'))
                          ],
                        ),
                        CustomRadioButton(
                          title: 'Ny kategori',
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
                              label: 'Kategori',
                              value: ref
                                  .watch(categoryControllerProvider)
                                  .category,
                              onChanged: (newValue) {
                                ref
                                    .read(categoryControllerProvider.notifier)
                                    .setCategory(newValue!);
                              },
                              items: categories
                                  ?.map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e.name),
                                      ))
                                  .toList()),
                          const SizedBox(height: 12),
                        ],
                        if (newCategory) ...[
                          CustomFormField(
                            errorMessage: 'Skriv in en summa',
                            label: 'Kategori *',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Din nya kategori behöver ett namn';
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
                            errorMessage: 'Skriv in en summa',
                            label: 'Kategori Budget',
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
                            onDateTimeChanged: (DateTime newDateTime) {
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
                            child: const Text('Lägg till'),
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
      Navigator.of(context).pop();
    }
  }
}
