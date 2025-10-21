import 'dart:io';

import 'package:calculix/data/models/storage_state.dart';
import 'package:calculix/data/models/user_entity.dart';
import 'package:calculix/data/provider/storage_provider.dart';
import 'package:calculix/domain/repository/storage_repository.dart';
import 'package:calculix/presentation/auth/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';

final storageNotierProvider =
    StateNotifierProvider<ProfileNotifier, StorageStatus>((ref) {
      final repository = ref.watch(storageProvider);
      return ProfileNotifier(repository, ref);
    });

class ProfileNotifier extends StateNotifier<StorageStatus> {
  final StorageRepository _repository;
  final ImagePicker _picker = ImagePicker();
  final Ref _ref;
  ProfileNotifier(this._repository, this._ref)
    : super(StorageStatus(state: StorageState.initial));

  Future<String> uploadImageFromUser({
    required UserEntity user,
    required ImageSource imageSource,
  }) async {
    state = state.copyWith(state: StorageState.uploading);
    final xFile = await _picker.pickImage(source: imageSource);

    if (xFile != null) {
      final url = await _repository.uploadImageFromUser(
        user: user,
        userImage: File(xFile.path),
      );
      state = state.copyWith(state: StorageState.succes,imageUrl: url);
      final userProvider = _ref.read(authNotifierProvider.notifier);
      userProvider.user = userProvider.user.copyWith(avatarUrl: url);
      return url;
    }

    state = state.copyWith(
      state: StorageState.error,
      errorMessage: "Failed to upload image",
    );
    return state.errorMessage!;
  }

  Future<String> getImageFromUser({required UserEntity user}) async {
    final String path = await _repository.getImageFromUser(user: user);
    debugPrint(path);
    state = state.copyWith(state: StorageState.succes,imageUrl: path);
    debugPrint(state.imageUrl);
    return path;
  }
}
