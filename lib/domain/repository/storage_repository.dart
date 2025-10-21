import 'dart:io';

import 'package:calculix/data/models/user_entity.dart';

abstract class StorageRepository {
  Future<String> getImageFromUser({required UserEntity user});
  Future<String> uploadImageFromUser({required UserEntity user,required File userImage});
  Future<void> deleteImageFromUser({required UserEntity user});
}