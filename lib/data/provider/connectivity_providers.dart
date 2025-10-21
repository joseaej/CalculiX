// lib/providers/connectivity_provider.dart

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Un StreamProvider que expone un booleano simple:
/// [true] si hay conexión, [false] si no la hay.
///
/// Maneja automáticamente el estado inicial y las actualizaciones.
final isConnectedProvider = StreamProvider<bool>((ref) async* {
  final connectivity = Connectivity();

  // 1. Emite el estado inicial
  final initialStatus = await connectivity.checkConnectivity();
  yield _isConnected(initialStatus);

  // 2. Escucha y emite los cambios subsecuentes
  // Usamos .map() para transformar la Lista de resultados en un simple booleano
  yield* connectivity.onConnectivityChanged.map((List<ConnectivityResult> results) {
    return _isConnected(results);
  });
});

/// Función helper para interpretar la lista de resultados de Connectivity_plus
///
/// Estamos "conectados" si la lista NO está vacía y NO contiene *únicamente* .none
bool _isConnected(List<ConnectivityResult> results) {
  if (results.isEmpty) {
    return false;
  }
  // Si la lista solo contiene 'none', estamos desconectados.
  if (results.length == 1 && results.first == ConnectivityResult.none) {
    return false;
  }
  // En cualquier otro caso (wifi, mobile, vpn, etc.), estamos conectados.
  return true;
}