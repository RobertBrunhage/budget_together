import 'package:budget_together/new_household/entities/category/category_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';

@freezed
class Category with _$Category {
  const Category._();
  factory Category({
    required int id,
    required String name,
  }) = _Category;

  factory Category.fromEntity(CategoryEntity categoryEntity) {
    return Category(
      id: categoryEntity.id,
      name: categoryEntity.name,
    );
  }

  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
    );
  }
}
