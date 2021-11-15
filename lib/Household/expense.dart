import 'package:budget_together/Authentication/user.dart';
import 'package:budget_together/Household/category.dart';

class Expense {
  final int id;
  final int amount;
  final Category? category;
  final User user;
  Expense({
    required this.id,
    required this.amount,
    required this.category,
    required this.user,
  });

  Expense copyWith({
    int? id,
    int? amount,
    Category? category,
    User? user,
  }) {
    return Expense(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'category': category?.toMap(),
      'user': user.toMap(),
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      amount: map['amount'],
      category: map['categories'] == null
          ? null
          : Category.fromMap(map['categories']),
      user: User.fromMap(map['profiles']),
    );
  }

  @override
  String toString() {
    return 'Expense(id: $id, amount: $amount, category: $category, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Expense &&
        other.id == id &&
        other.amount == amount &&
        other.category == category &&
        other.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^ amount.hashCode ^ category.hashCode ^ user.hashCode;
  }
}
