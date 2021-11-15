import 'package:budget_together/Household/expense.dart';
import 'package:flutter/foundation.dart';

class Household {
  final int id;
  final String creator;
  final String name;
  final List<Expense> expenses;
  Household({
    required this.id,
    required this.creator,
    required this.name,
    required this.expenses,
  });

  Household copyWith({
    int? id,
    String? creator,
    String? name,
    List<Expense>? expenses,
  }) {
    return Household(
      id: id ?? this.id,
      creator: creator ?? this.creator,
      name: name ?? this.name,
      expenses: expenses ?? this.expenses,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'creator': creator,
      'name': name,
      'expenses': expenses.map((x) => x.toMap()).toList(),
    };
  }

  factory Household.fromMap(Map<String, dynamic> map) {
    return Household(
      id: map['id'],
      creator: map['creator'],
      name: map['name'],
      expenses: map['expenses'] == null
          ? []
          : List<Expense>.from(map['expenses']?.map((x) => Expense.fromMap(x))),
    );
  }

  @override
  String toString() {
    return 'Household(id: $id, creator: $creator, name: $name, expenses: $expenses)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Household &&
        other.id == id &&
        other.creator == creator &&
        other.name == name &&
        listEquals(other.expenses, expenses);
  }

  @override
  int get hashCode {
    return id.hashCode ^ creator.hashCode ^ name.hashCode ^ expenses.hashCode;
  }
}
