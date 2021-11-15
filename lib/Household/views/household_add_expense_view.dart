import 'package:budget_together/Household/category.dart';
import 'package:budget_together/Household/category_controller.dart';
import 'package:budget_together/Household/household_controller.dart';
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
              TextFormField(
                // The validator receives the text that the user has entered.
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
              ),
              ElevatedButton(
                onPressed: () async {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    ref
                        .read(householdControllerProvider.notifier)
                        .createExpense(double.parse(expense));

                    context.go('/household');
                  }
                },
                child: const Text('add expense'),
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
            ],
          ),
        ),
      ),
    );
  }
}
