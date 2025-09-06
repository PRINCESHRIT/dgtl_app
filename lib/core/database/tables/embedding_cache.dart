import 'package:drift/drift.dart';

@DataClass(name: 'EmbeddingCach')
class EmbeddingCache extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get contentHash => text()(); // SHA-256 hash of the content
  TextColumn get contentType => text()(); // 'symptom', 'lab_result', 'medication', etc.
  BlobColumn get embedding => blob()(); // The actual vector embedding
  IntColumn get dimensions => integer()(); // Embedding vector dimensions
  TextColumn get modelVersion => text()(); // Version of the model used
  IntColumn get accessCount => integer().withDefault(const Constant(1))(); // Usage tracking
  DateTimeColumn get lastAccessedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
  
  @override
  List<String> get customConstraints => [
    'UNIQUE(contentHash, dimensions)',
    'INDEX(contentType, lastAccessedAt)',
    'INDEX(lastAccessedAt)', // For LRU eviction
  ];
}
