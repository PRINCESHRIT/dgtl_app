import 'package:drift/web.dart';
import 'package:drift/drift.dart';

// Web connection using IndexedDB via drift_web
QueryExecutor openConnection() {
  return WebDatabase('health_tracker');
}
