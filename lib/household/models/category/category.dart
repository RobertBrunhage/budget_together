import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../entities/category/category_entity.dart';

part 'category.freezed.dart';

@freezed
class Category with _$Category {
  factory Category({
    required int id,
    required String name,
  }) = _Category;
  const Category._();

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
