import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/user_entity.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  factory User({
    required String id,
    required String name,
  }) = _User;
  const User._();

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
