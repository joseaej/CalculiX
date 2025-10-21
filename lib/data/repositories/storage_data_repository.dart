import 'dart:io';

import 'package:calculix/data/models/user_entity.dart';
import 'package:calculix/domain/repository/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageDataRepository extends StorageRepository{

  final SupabaseClient _client;

  StorageDataRepository(this._client);

  @override
  Future<void> deleteImageFromUser({required UserEntity user}) {
    // TODO: implement deleteImageFromUser
    throw UnimplementedError();
  }

  @override
  Future<String> getImageFromUser({required UserEntity user}) async{
    try {
      final profileImage = _client.storage.from("profile_images").getPublicUrl(user.id);
      return profileImage;
    } catch (e) {
      debugPrint(e.toString());
    }
    return "https://creazilla-store.fra1.digitaloceanspaces.com/icons/3251108/person-icon-md.png";
  }

  @override
  Future<String> uploadImageFromUser({required UserEntity user, required File userImage})async {
    try {
      await _client.storage.from("profile_images").upload(user.id, userImage,fileOptions: FileOptions(upsert: true));
      String fullPath = await getImageFromUser(user: user);
      await _client.from("profiles").update({"avatar_url":fullPath}).eq("id", user.id);
      return fullPath;
    } catch (e) {
      return e.toString();
    }
  }

  
}