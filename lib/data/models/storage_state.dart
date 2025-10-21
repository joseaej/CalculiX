enum StorageState {initial,uploading,succes,error}

class StorageStatus {
  final StorageState state;
  final String? errorMessage;
  final String? imageUrl;

  StorageStatus({
    required this.state,
    this.errorMessage,
    this.imageUrl,
  });

  StorageStatus copyWith({
    StorageState? state,
    String? errorMessage,
    String? imageUrl,
  }) {
    return StorageStatus(
      state: state ?? this.state,
      errorMessage: errorMessage ?? this.errorMessage,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
