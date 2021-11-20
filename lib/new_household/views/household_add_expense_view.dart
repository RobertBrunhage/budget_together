import 'package:budget_together/core/atoms/form_elements/custom_input.dart';
import 'package:budget_together/new_household/controllers/category_controller.dart';
import 'package:budget_together/new_household/controllers/household_controller.dart';
import 'package:budget_together/new_household/models/category/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddExpenseView extends ConsumerStatefulWidget {
  const AddExpenseView({Key? key}) : super(key: key);

  @override
  ConsumerState<AddExpenseView> createState() => _AddExpenseViewState();
}

class _AddExpenseViewState extends ConsumerState<AddExpenseView> {
  final _formKey = GlobalKey<FormState>();

  String expense = '';
  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
    final householdId =
        ref.read(householdControllerProvider).household.value!.id;
    ref.read(categoryControllerProvider.notifier).fetchCategories(householdId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              CustomFormInput(
                // The validator receives the text that the user has entered.
                label: 'Summa',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.deny(
                    RegExp('[\\-|\\ ]'),
                  ),
                  FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d{0,2})'))
                ],
                onChanged: (value) {
                  setState(() {
                    expense = value;
                  });
                },
                errorMessage: 'no',
              ),
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: date,
                  onDateTimeChanged: (DateTime newDateTime) {
                    // Do something
                    setState(() {
                      date = newDateTime;
                    });
                  },
                ),
              ),
              ref.watch(categoryControllerProvider).categories.when(
                    data: (categories) {
                      return DropdownButton<Category>(
                          value: ref.watch(categoryControllerProvider).category,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              ref
                                  .read(categoryControllerProvider.notifier)
                                  .setCategory(newValue!);
                            });
                          },
                          items: categories
                              ?.map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.name),
                                  ))
                              .toList());
                    },
                    error: (e, s) => Text(e.toString()),
                    loading: () => const CircularProgressIndicator(),
                  ),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ref
                        .read(householdControllerProvider.notifier)
                        .createExpense(
                          double.parse(expense),
                          date,
                        );

                    context.go('/household');
                  }
                },
                child: const Text('add expense'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
