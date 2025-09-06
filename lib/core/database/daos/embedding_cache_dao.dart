import 'dart:typed_data';
import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/embedding_cache.dart';

part 'embedding_cache_dao.g.dart';

@DriftAccessor(tables: [EmbeddingCache])
class EmbeddingCacheDao extends DatabaseAccessor<AppDatabase> with _$EmbeddingCacheDaoMixin {
  EmbeddingCacheDao(AppDatabase db) : super(db);

  Future<int> cacheEmbedding(EmbeddingCacheCompanion embedding) async {
    return await into(embeddingCache).insert(
      embedding,
      onConflict: DoUpdate((old) => embedding.copyWith(
        accessCount: Value(old.accessCount + 1),
        lastAccessedAt: Value(DateTime.now()),
      )),
    );
  }

  Future<EmbeddingCach?> getCachedEmbedding(String contentHash, int dimensions) async {
    final result = await (select(embeddingCache)
      ..where((e) => 
        e.contentHash.equals(contentHash) & 
        e.dimensions.equals(dimensions)
      )
    ).getSingleOrNull();

    if (result != null) {
      // Update access count and last accessed time
      await (update(embeddingCache)..where((e) => e.id.equals(result.id)))
        .write(EmbeddingCacheCompanion(
          accessCount: Value(result.accessCount + 1),
          lastAccessedAt: Value(DateTime.now()),
        ));
    }

    return result;
  }

  Future<List<EmbeddingCach>> getCachedEmbeddingsByType(String contentType, {int limit = 100}) async {
    return await (select(embeddingCache)
      ..where((e) => e.contentType.equals(contentType))
      ..orderBy([(e) => OrderingTerm.desc(e.lastAccessedAt)])
      ..limit(limit)
    ).get();
  }

  // LRU eviction: Remove least recently used embeddings
  Future<int> evictLRUEmbeddings({int keepCount = 1000}) async {
    final totalCount = await (selectOnly(embeddingCache)
      ..addColumns([embeddingCache.id.count()])
    ).getSingle().then((row) => row.read(embeddingCache.id.count()) ?? 0);

    if (totalCount <= keepCount) return 0;

    final toDelete = totalCount - keepCount;
    final oldestEmbeddings = await (select(embeddingCache)
      ..orderBy([(e) => OrderingTerm.asc(e.lastAccessedAt)])
      ..limit(toDelete)
    ).get();

    final idsToDelete = oldestEmbeddings.map((e) => e.id).toList();
    return await (delete(embeddingCache)
      ..where((e) => e.id.isIn(idsToDelete))
    ).go();
  }

  Future<int> clearCacheByType(String contentType) async {
    return await (delete(embeddingCache)
      ..where((e) => e.contentType.equals(contentType))
    ).go();
  }

  Future<Map<String, int>> getCacheStats() async {
    final stats = <String, int>{};
    
    // Get total count
    final total = await (selectOnly(embeddingCache)
      ..addColumns([embeddingCache.id.count()])
    ).getSingle().then((row) => row.read(embeddingCache.id.count()) ?? 0);
    stats['total'] = total;

    // Get counts by content type
    final typeStats = await (selectOnly(embeddingCache)
      ..addColumns([embeddingCache.contentType, embeddingCache.id.count()])
      ..groupBy([embeddingCache.contentType])
    ).get();

    for (final row in typeStats) {
      final type = row.read(embeddingCache.contentType);
      final count = row.read(embeddingCache.id.count()) ?? 0;
      if (type != null) stats[type] = count;
    }

    return stats;
  }
}
