import 'package:budget_together/new_authentication/entities/user_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const User._();
  factory User({
    required String id,
    required String name,
  }) = _User;

  factory User.fromEntity(UserEntity userEntity) {
    return User(
      id: userEntity.id,
      name: userEntity.name,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
    );
  }
}
