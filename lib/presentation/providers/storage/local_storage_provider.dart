import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructure/datasources/local_drift_datasource.dart';
import '../../../infrastructure/datasources/local_tasier_datasource.dart';
import '../../../infrastructure/repositories/local_storage_repository_impl.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(
    localStorageDatasource: kIsWeb
        ? LocalTasierDatasource()
        : LocalDriftDatasource(),
  );
});
