import 'package:calculix/data/provider/auth_provider.dart';
import 'package:calculix/data/repositories/storage_data_repository.dart';
import 'package:calculix/domain/repository/storage_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storageProvider = Provider<StorageRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return StorageDataRepository(client);
});
