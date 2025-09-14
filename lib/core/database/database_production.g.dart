// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_production.dart';

// ignore_for_file: type=lint
class $MedicalKnowledgeBaseTable extends MedicalKnowledgeBase
    with TableInfo<$MedicalKnowledgeBaseTable, MedicalKnowledgeBaseData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedicalKnowledgeBaseTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _embeddingMeta =
      const VerificationMeta('embedding');
  @override
  late final GeneratedColumn<String> embedding = GeneratedColumn<String>(
      'embedding', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _confidenceMeta =
      const VerificationMeta('confidence');
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
      'confidence', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        content,
        source,
        category,
        embedding,
        confidence,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medical_knowledge_base';
  @override
  VerificationContext validateIntegrity(
      Insertable<MedicalKnowledgeBaseData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('embedding')) {
      context.handle(_embeddingMeta,
          embedding.isAcceptableOrUnknown(data['embedding']!, _embeddingMeta));
    } else if (isInserting) {
      context.missing(_embeddingMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(
          _confidenceMeta,
          confidence.isAcceptableOrUnknown(
              data['confidence']!, _confidenceMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MedicalKnowledgeBaseData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MedicalKnowledgeBaseData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      embedding: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}embedding'])!,
      confidence: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}confidence'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $MedicalKnowledgeBaseTable createAlias(String alias) {
    return $MedicalKnowledgeBaseTable(attachedDatabase, alias);
  }
}

class MedicalKnowledgeBaseData extends DataClass
    implements Insertable<MedicalKnowledgeBaseData> {
  final int id;
  final String content;
  final String source;
  final String category;
  final String embedding;
  final double confidence;
  final DateTime createdAt;
  final DateTime updatedAt;
  const MedicalKnowledgeBaseData(
      {required this.id,
      required this.content,
      required this.source,
      required this.category,
      required this.embedding,
      required this.confidence,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content'] = Variable<String>(content);
    map['source'] = Variable<String>(source);
    map['category'] = Variable<String>(category);
    map['embedding'] = Variable<String>(embedding);
    map['confidence'] = Variable<double>(confidence);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MedicalKnowledgeBaseCompanion toCompanion(bool nullToAbsent) {
    return MedicalKnowledgeBaseCompanion(
      id: Value(id),
      content: Value(content),
      source: Value(source),
      category: Value(category),
      embedding: Value(embedding),
      confidence: Value(confidence),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MedicalKnowledgeBaseData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MedicalKnowledgeBaseData(
      id: serializer.fromJson<int>(json['id']),
      content: serializer.fromJson<String>(json['content']),
      source: serializer.fromJson<String>(json['source']),
      category: serializer.fromJson<String>(json['category']),
      embedding: serializer.fromJson<String>(json['embedding']),
      confidence: serializer.fromJson<double>(json['confidence']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'content': serializer.toJson<String>(content),
      'source': serializer.toJson<String>(source),
      'category': serializer.toJson<String>(category),
      'embedding': serializer.toJson<String>(embedding),
      'confidence': serializer.toJson<double>(confidence),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MedicalKnowledgeBaseData copyWith(
          {int? id,
          String? content,
          String? source,
          String? category,
          String? embedding,
          double? confidence,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      MedicalKnowledgeBaseData(
        id: id ?? this.id,
        content: content ?? this.content,
        source: source ?? this.source,
        category: category ?? this.category,
        embedding: embedding ?? this.embedding,
        confidence: confidence ?? this.confidence,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  MedicalKnowledgeBaseData copyWithCompanion(
      MedicalKnowledgeBaseCompanion data) {
    return MedicalKnowledgeBaseData(
      id: data.id.present ? data.id.value : this.id,
      content: data.content.present ? data.content.value : this.content,
      source: data.source.present ? data.source.value : this.source,
      category: data.category.present ? data.category.value : this.category,
      embedding: data.embedding.present ? data.embedding.value : this.embedding,
      confidence:
          data.confidence.present ? data.confidence.value : this.confidence,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MedicalKnowledgeBaseData(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('source: $source, ')
          ..write('category: $category, ')
          ..write('embedding: $embedding, ')
          ..write('confidence: $confidence, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, content, source, category, embedding,
      confidence, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MedicalKnowledgeBaseData &&
          other.id == this.id &&
          other.content == this.content &&
          other.source == this.source &&
          other.category == this.category &&
          other.embedding == this.embedding &&
          other.confidence == this.confidence &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MedicalKnowledgeBaseCompanion
    extends UpdateCompanion<MedicalKnowledgeBaseData> {
  final Value<int> id;
  final Value<String> content;
  final Value<String> source;
  final Value<String> category;
  final Value<String> embedding;
  final Value<double> confidence;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const MedicalKnowledgeBaseCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    this.source = const Value.absent(),
    this.category = const Value.absent(),
    this.embedding = const Value.absent(),
    this.confidence = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MedicalKnowledgeBaseCompanion.insert({
    this.id = const Value.absent(),
    required String content,
    required String source,
    required String category,
    required String embedding,
    this.confidence = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : content = Value(content),
        source = Value(source),
        category = Value(category),
        embedding = Value(embedding);
  static Insertable<MedicalKnowledgeBaseData> custom({
    Expression<int>? id,
    Expression<String>? content,
    Expression<String>? source,
    Expression<String>? category,
    Expression<String>? embedding,
    Expression<double>? confidence,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
      if (source != null) 'source': source,
      if (category != null) 'category': category,
      if (embedding != null) 'embedding': embedding,
      if (confidence != null) 'confidence': confidence,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MedicalKnowledgeBaseCompanion copyWith(
      {Value<int>? id,
      Value<String>? content,
      Value<String>? source,
      Value<String>? category,
      Value<String>? embedding,
      Value<double>? confidence,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return MedicalKnowledgeBaseCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
      source: source ?? this.source,
      category: category ?? this.category,
      embedding: embedding ?? this.embedding,
      confidence: confidence ?? this.confidence,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (embedding.present) {
      map['embedding'] = Variable<String>(embedding.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicalKnowledgeBaseCompanion(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('source: $source, ')
          ..write('category: $category, ')
          ..write('embedding: $embedding, ')
          ..write('confidence: $confidence, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PatientsTable extends Patients with TableInfo<$PatientsTable, Patient> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PatientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _encryptedFirstNameMeta =
      const VerificationMeta('encryptedFirstName');
  @override
  late final GeneratedColumn<String> encryptedFirstName =
      GeneratedColumn<String>('encrypted_first_name', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _encryptedLastNameMeta =
      const VerificationMeta('encryptedLastName');
  @override
  late final GeneratedColumn<String> encryptedLastName =
      GeneratedColumn<String>('encrypted_last_name', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _encryptedDateOfBirthMeta =
      const VerificationMeta('encryptedDateOfBirth');
  @override
  late final GeneratedColumn<String> encryptedDateOfBirth =
      GeneratedColumn<String>('encrypted_date_of_birth', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _encryptedNotesMeta =
      const VerificationMeta('encryptedNotes');
  @override
  late final GeneratedColumn<String> encryptedNotes = GeneratedColumn<String>(
      'encrypted_notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        encryptedFirstName,
        encryptedLastName,
        encryptedDateOfBirth,
        gender,
        encryptedNotes,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'patients';
  @override
  VerificationContext validateIntegrity(Insertable<Patient> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('encrypted_first_name')) {
      context.handle(
          _encryptedFirstNameMeta,
          encryptedFirstName.isAcceptableOrUnknown(
              data['encrypted_first_name']!, _encryptedFirstNameMeta));
    } else if (isInserting) {
      context.missing(_encryptedFirstNameMeta);
    }
    if (data.containsKey('encrypted_last_name')) {
      context.handle(
          _encryptedLastNameMeta,
          encryptedLastName.isAcceptableOrUnknown(
              data['encrypted_last_name']!, _encryptedLastNameMeta));
    } else if (isInserting) {
      context.missing(_encryptedLastNameMeta);
    }
    if (data.containsKey('encrypted_date_of_birth')) {
      context.handle(
          _encryptedDateOfBirthMeta,
          encryptedDateOfBirth.isAcceptableOrUnknown(
              data['encrypted_date_of_birth']!, _encryptedDateOfBirthMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('encrypted_notes')) {
      context.handle(
          _encryptedNotesMeta,
          encryptedNotes.isAcceptableOrUnknown(
              data['encrypted_notes']!, _encryptedNotesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Patient map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Patient(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      encryptedFirstName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}encrypted_first_name'])!,
      encryptedLastName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}encrypted_last_name'])!,
      encryptedDateOfBirth: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}encrypted_date_of_birth']),
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender']),
      encryptedNotes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}encrypted_notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $PatientsTable createAlias(String alias) {
    return $PatientsTable(attachedDatabase, alias);
  }
}

class Patient extends DataClass implements Insertable<Patient> {
  final int id;
  final String encryptedFirstName;
  final String encryptedLastName;
  final String? encryptedDateOfBirth;
  final String? gender;
  final String? encryptedNotes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Patient(
      {required this.id,
      required this.encryptedFirstName,
      required this.encryptedLastName,
      this.encryptedDateOfBirth,
      this.gender,
      this.encryptedNotes,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['encrypted_first_name'] = Variable<String>(encryptedFirstName);
    map['encrypted_last_name'] = Variable<String>(encryptedLastName);
    if (!nullToAbsent || encryptedDateOfBirth != null) {
      map['encrypted_date_of_birth'] = Variable<String>(encryptedDateOfBirth);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || encryptedNotes != null) {
      map['encrypted_notes'] = Variable<String>(encryptedNotes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PatientsCompanion toCompanion(bool nullToAbsent) {
    return PatientsCompanion(
      id: Value(id),
      encryptedFirstName: Value(encryptedFirstName),
      encryptedLastName: Value(encryptedLastName),
      encryptedDateOfBirth: encryptedDateOfBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(encryptedDateOfBirth),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      encryptedNotes: encryptedNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(encryptedNotes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Patient.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Patient(
      id: serializer.fromJson<int>(json['id']),
      encryptedFirstName:
          serializer.fromJson<String>(json['encryptedFirstName']),
      encryptedLastName: serializer.fromJson<String>(json['encryptedLastName']),
      encryptedDateOfBirth:
          serializer.fromJson<String?>(json['encryptedDateOfBirth']),
      gender: serializer.fromJson<String?>(json['gender']),
      encryptedNotes: serializer.fromJson<String?>(json['encryptedNotes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'encryptedFirstName': serializer.toJson<String>(encryptedFirstName),
      'encryptedLastName': serializer.toJson<String>(encryptedLastName),
      'encryptedDateOfBirth': serializer.toJson<String?>(encryptedDateOfBirth),
      'gender': serializer.toJson<String?>(gender),
      'encryptedNotes': serializer.toJson<String?>(encryptedNotes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Patient copyWith(
          {int? id,
          String? encryptedFirstName,
          String? encryptedLastName,
          Value<String?> encryptedDateOfBirth = const Value.absent(),
          Value<String?> gender = const Value.absent(),
          Value<String?> encryptedNotes = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Patient(
        id: id ?? this.id,
        encryptedFirstName: encryptedFirstName ?? this.encryptedFirstName,
        encryptedLastName: encryptedLastName ?? this.encryptedLastName,
        encryptedDateOfBirth: encryptedDateOfBirth.present
            ? encryptedDateOfBirth.value
            : this.encryptedDateOfBirth,
        gender: gender.present ? gender.value : this.gender,
        encryptedNotes:
            encryptedNotes.present ? encryptedNotes.value : this.encryptedNotes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Patient copyWithCompanion(PatientsCompanion data) {
    return Patient(
      id: data.id.present ? data.id.value : this.id,
      encryptedFirstName: data.encryptedFirstName.present
          ? data.encryptedFirstName.value
          : this.encryptedFirstName,
      encryptedLastName: data.encryptedLastName.present
          ? data.encryptedLastName.value
          : this.encryptedLastName,
      encryptedDateOfBirth: data.encryptedDateOfBirth.present
          ? data.encryptedDateOfBirth.value
          : this.encryptedDateOfBirth,
      gender: data.gender.present ? data.gender.value : this.gender,
      encryptedNotes: data.encryptedNotes.present
          ? data.encryptedNotes.value
          : this.encryptedNotes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Patient(')
          ..write('id: $id, ')
          ..write('encryptedFirstName: $encryptedFirstName, ')
          ..write('encryptedLastName: $encryptedLastName, ')
          ..write('encryptedDateOfBirth: $encryptedDateOfBirth, ')
          ..write('gender: $gender, ')
          ..write('encryptedNotes: $encryptedNotes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, encryptedFirstName, encryptedLastName,
      encryptedDateOfBirth, gender, encryptedNotes, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Patient &&
          other.id == this.id &&
          other.encryptedFirstName == this.encryptedFirstName &&
          other.encryptedLastName == this.encryptedLastName &&
          other.encryptedDateOfBirth == this.encryptedDateOfBirth &&
          other.gender == this.gender &&
          other.encryptedNotes == this.encryptedNotes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PatientsCompanion extends UpdateCompanion<Patient> {
  final Value<int> id;
  final Value<String> encryptedFirstName;
  final Value<String> encryptedLastName;
  final Value<String?> encryptedDateOfBirth;
  final Value<String?> gender;
  final Value<String?> encryptedNotes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PatientsCompanion({
    this.id = const Value.absent(),
    this.encryptedFirstName = const Value.absent(),
    this.encryptedLastName = const Value.absent(),
    this.encryptedDateOfBirth = const Value.absent(),
    this.gender = const Value.absent(),
    this.encryptedNotes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PatientsCompanion.insert({
    this.id = const Value.absent(),
    required String encryptedFirstName,
    required String encryptedLastName,
    this.encryptedDateOfBirth = const Value.absent(),
    this.gender = const Value.absent(),
    this.encryptedNotes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : encryptedFirstName = Value(encryptedFirstName),
        encryptedLastName = Value(encryptedLastName);
  static Insertable<Patient> custom({
    Expression<int>? id,
    Expression<String>? encryptedFirstName,
    Expression<String>? encryptedLastName,
    Expression<String>? encryptedDateOfBirth,
    Expression<String>? gender,
    Expression<String>? encryptedNotes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (encryptedFirstName != null)
        'encrypted_first_name': encryptedFirstName,
      if (encryptedLastName != null) 'encrypted_last_name': encryptedLastName,
      if (encryptedDateOfBirth != null)
        'encrypted_date_of_birth': encryptedDateOfBirth,
      if (gender != null) 'gender': gender,
      if (encryptedNotes != null) 'encrypted_notes': encryptedNotes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PatientsCompanion copyWith(
      {Value<int>? id,
      Value<String>? encryptedFirstName,
      Value<String>? encryptedLastName,
      Value<String?>? encryptedDateOfBirth,
      Value<String?>? gender,
      Value<String?>? encryptedNotes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return PatientsCompanion(
      id: id ?? this.id,
      encryptedFirstName: encryptedFirstName ?? this.encryptedFirstName,
      encryptedLastName: encryptedLastName ?? this.encryptedLastName,
      encryptedDateOfBirth: encryptedDateOfBirth ?? this.encryptedDateOfBirth,
      gender: gender ?? this.gender,
      encryptedNotes: encryptedNotes ?? this.encryptedNotes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (encryptedFirstName.present) {
      map['encrypted_first_name'] = Variable<String>(encryptedFirstName.value);
    }
    if (encryptedLastName.present) {
      map['encrypted_last_name'] = Variable<String>(encryptedLastName.value);
    }
    if (encryptedDateOfBirth.present) {
      map['encrypted_date_of_birth'] =
          Variable<String>(encryptedDateOfBirth.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (encryptedNotes.present) {
      map['encrypted_notes'] = Variable<String>(encryptedNotes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PatientsCompanion(')
          ..write('id: $id, ')
          ..write('encryptedFirstName: $encryptedFirstName, ')
          ..write('encryptedLastName: $encryptedLastName, ')
          ..write('encryptedDateOfBirth: $encryptedDateOfBirth, ')
          ..write('gender: $gender, ')
          ..write('encryptedNotes: $encryptedNotes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ClinicalAssessmentsTable extends ClinicalAssessments
    with TableInfo<$ClinicalAssessmentsTable, ClinicalAssessment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClinicalAssessmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _patientIdMeta =
      const VerificationMeta('patientId');
  @override
  late final GeneratedColumn<int> patientId = GeneratedColumn<int>(
      'patient_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES patients (id)'));
  static const VerificationMeta _assessmentTypeMeta =
      const VerificationMeta('assessmentType');
  @override
  late final GeneratedColumn<String> assessmentType = GeneratedColumn<String>(
      'assessment_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ragContextMeta =
      const VerificationMeta('ragContext');
  @override
  late final GeneratedColumn<String> ragContext = GeneratedColumn<String>(
      'rag_context', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _aiRecommendationsMeta =
      const VerificationMeta('aiRecommendations');
  @override
  late final GeneratedColumn<String> aiRecommendations =
      GeneratedColumn<String>('ai_recommendations', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _clinicalFindingsMeta =
      const VerificationMeta('clinicalFindings');
  @override
  late final GeneratedColumn<String> clinicalFindings = GeneratedColumn<String>(
      'clinical_findings', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _confidenceScoreMeta =
      const VerificationMeta('confidenceScore');
  @override
  late final GeneratedColumn<double> confidenceScore = GeneratedColumn<double>(
      'confidence_score', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        patientId,
        assessmentType,
        ragContext,
        aiRecommendations,
        clinicalFindings,
        confidenceScore,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clinical_assessments';
  @override
  VerificationContext validateIntegrity(Insertable<ClinicalAssessment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('patient_id')) {
      context.handle(_patientIdMeta,
          patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta));
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('assessment_type')) {
      context.handle(
          _assessmentTypeMeta,
          assessmentType.isAcceptableOrUnknown(
              data['assessment_type']!, _assessmentTypeMeta));
    } else if (isInserting) {
      context.missing(_assessmentTypeMeta);
    }
    if (data.containsKey('rag_context')) {
      context.handle(
          _ragContextMeta,
          ragContext.isAcceptableOrUnknown(
              data['rag_context']!, _ragContextMeta));
    } else if (isInserting) {
      context.missing(_ragContextMeta);
    }
    if (data.containsKey('ai_recommendations')) {
      context.handle(
          _aiRecommendationsMeta,
          aiRecommendations.isAcceptableOrUnknown(
              data['ai_recommendations']!, _aiRecommendationsMeta));
    } else if (isInserting) {
      context.missing(_aiRecommendationsMeta);
    }
    if (data.containsKey('clinical_findings')) {
      context.handle(
          _clinicalFindingsMeta,
          clinicalFindings.isAcceptableOrUnknown(
              data['clinical_findings']!, _clinicalFindingsMeta));
    } else if (isInserting) {
      context.missing(_clinicalFindingsMeta);
    }
    if (data.containsKey('confidence_score')) {
      context.handle(
          _confidenceScoreMeta,
          confidenceScore.isAcceptableOrUnknown(
              data['confidence_score']!, _confidenceScoreMeta));
    } else if (isInserting) {
      context.missing(_confidenceScoreMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ClinicalAssessment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClinicalAssessment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      patientId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}patient_id'])!,
      assessmentType: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}assessment_type'])!,
      ragContext: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rag_context'])!,
      aiRecommendations: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}ai_recommendations'])!,
      clinicalFindings: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}clinical_findings'])!,
      confidenceScore: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}confidence_score'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ClinicalAssessmentsTable createAlias(String alias) {
    return $ClinicalAssessmentsTable(attachedDatabase, alias);
  }
}

class ClinicalAssessment extends DataClass
    implements Insertable<ClinicalAssessment> {
  final int id;
  final int patientId;
  final String assessmentType;
  final String ragContext;
  final String aiRecommendations;
  final String clinicalFindings;
  final double confidenceScore;
  final DateTime createdAt;
  const ClinicalAssessment(
      {required this.id,
      required this.patientId,
      required this.assessmentType,
      required this.ragContext,
      required this.aiRecommendations,
      required this.clinicalFindings,
      required this.confidenceScore,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['patient_id'] = Variable<int>(patientId);
    map['assessment_type'] = Variable<String>(assessmentType);
    map['rag_context'] = Variable<String>(ragContext);
    map['ai_recommendations'] = Variable<String>(aiRecommendations);
    map['clinical_findings'] = Variable<String>(clinicalFindings);
    map['confidence_score'] = Variable<double>(confidenceScore);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ClinicalAssessmentsCompanion toCompanion(bool nullToAbsent) {
    return ClinicalAssessmentsCompanion(
      id: Value(id),
      patientId: Value(patientId),
      assessmentType: Value(assessmentType),
      ragContext: Value(ragContext),
      aiRecommendations: Value(aiRecommendations),
      clinicalFindings: Value(clinicalFindings),
      confidenceScore: Value(confidenceScore),
      createdAt: Value(createdAt),
    );
  }

  factory ClinicalAssessment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClinicalAssessment(
      id: serializer.fromJson<int>(json['id']),
      patientId: serializer.fromJson<int>(json['patientId']),
      assessmentType: serializer.fromJson<String>(json['assessmentType']),
      ragContext: serializer.fromJson<String>(json['ragContext']),
      aiRecommendations: serializer.fromJson<String>(json['aiRecommendations']),
      clinicalFindings: serializer.fromJson<String>(json['clinicalFindings']),
      confidenceScore: serializer.fromJson<double>(json['confidenceScore']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'patientId': serializer.toJson<int>(patientId),
      'assessmentType': serializer.toJson<String>(assessmentType),
      'ragContext': serializer.toJson<String>(ragContext),
      'aiRecommendations': serializer.toJson<String>(aiRecommendations),
      'clinicalFindings': serializer.toJson<String>(clinicalFindings),
      'confidenceScore': serializer.toJson<double>(confidenceScore),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ClinicalAssessment copyWith(
          {int? id,
          int? patientId,
          String? assessmentType,
          String? ragContext,
          String? aiRecommendations,
          String? clinicalFindings,
          double? confidenceScore,
          DateTime? createdAt}) =>
      ClinicalAssessment(
        id: id ?? this.id,
        patientId: patientId ?? this.patientId,
        assessmentType: assessmentType ?? this.assessmentType,
        ragContext: ragContext ?? this.ragContext,
        aiRecommendations: aiRecommendations ?? this.aiRecommendations,
        clinicalFindings: clinicalFindings ?? this.clinicalFindings,
        confidenceScore: confidenceScore ?? this.confidenceScore,
        createdAt: createdAt ?? this.createdAt,
      );
  ClinicalAssessment copyWithCompanion(ClinicalAssessmentsCompanion data) {
    return ClinicalAssessment(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      assessmentType: data.assessmentType.present
          ? data.assessmentType.value
          : this.assessmentType,
      ragContext:
          data.ragContext.present ? data.ragContext.value : this.ragContext,
      aiRecommendations: data.aiRecommendations.present
          ? data.aiRecommendations.value
          : this.aiRecommendations,
      clinicalFindings: data.clinicalFindings.present
          ? data.clinicalFindings.value
          : this.clinicalFindings,
      confidenceScore: data.confidenceScore.present
          ? data.confidenceScore.value
          : this.confidenceScore,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClinicalAssessment(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('assessmentType: $assessmentType, ')
          ..write('ragContext: $ragContext, ')
          ..write('aiRecommendations: $aiRecommendations, ')
          ..write('clinicalFindings: $clinicalFindings, ')
          ..write('confidenceScore: $confidenceScore, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, patientId, assessmentType, ragContext,
      aiRecommendations, clinicalFindings, confidenceScore, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClinicalAssessment &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.assessmentType == this.assessmentType &&
          other.ragContext == this.ragContext &&
          other.aiRecommendations == this.aiRecommendations &&
          other.clinicalFindings == this.clinicalFindings &&
          other.confidenceScore == this.confidenceScore &&
          other.createdAt == this.createdAt);
}

class ClinicalAssessmentsCompanion extends UpdateCompanion<ClinicalAssessment> {
  final Value<int> id;
  final Value<int> patientId;
  final Value<String> assessmentType;
  final Value<String> ragContext;
  final Value<String> aiRecommendations;
  final Value<String> clinicalFindings;
  final Value<double> confidenceScore;
  final Value<DateTime> createdAt;
  const ClinicalAssessmentsCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.assessmentType = const Value.absent(),
    this.ragContext = const Value.absent(),
    this.aiRecommendations = const Value.absent(),
    this.clinicalFindings = const Value.absent(),
    this.confidenceScore = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ClinicalAssessmentsCompanion.insert({
    this.id = const Value.absent(),
    required int patientId,
    required String assessmentType,
    required String ragContext,
    required String aiRecommendations,
    required String clinicalFindings,
    required double confidenceScore,
    this.createdAt = const Value.absent(),
  })  : patientId = Value(patientId),
        assessmentType = Value(assessmentType),
        ragContext = Value(ragContext),
        aiRecommendations = Value(aiRecommendations),
        clinicalFindings = Value(clinicalFindings),
        confidenceScore = Value(confidenceScore);
  static Insertable<ClinicalAssessment> custom({
    Expression<int>? id,
    Expression<int>? patientId,
    Expression<String>? assessmentType,
    Expression<String>? ragContext,
    Expression<String>? aiRecommendations,
    Expression<String>? clinicalFindings,
    Expression<double>? confidenceScore,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (assessmentType != null) 'assessment_type': assessmentType,
      if (ragContext != null) 'rag_context': ragContext,
      if (aiRecommendations != null) 'ai_recommendations': aiRecommendations,
      if (clinicalFindings != null) 'clinical_findings': clinicalFindings,
      if (confidenceScore != null) 'confidence_score': confidenceScore,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ClinicalAssessmentsCompanion copyWith(
      {Value<int>? id,
      Value<int>? patientId,
      Value<String>? assessmentType,
      Value<String>? ragContext,
      Value<String>? aiRecommendations,
      Value<String>? clinicalFindings,
      Value<double>? confidenceScore,
      Value<DateTime>? createdAt}) {
    return ClinicalAssessmentsCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      assessmentType: assessmentType ?? this.assessmentType,
      ragContext: ragContext ?? this.ragContext,
      aiRecommendations: aiRecommendations ?? this.aiRecommendations,
      clinicalFindings: clinicalFindings ?? this.clinicalFindings,
      confidenceScore: confidenceScore ?? this.confidenceScore,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<int>(patientId.value);
    }
    if (assessmentType.present) {
      map['assessment_type'] = Variable<String>(assessmentType.value);
    }
    if (ragContext.present) {
      map['rag_context'] = Variable<String>(ragContext.value);
    }
    if (aiRecommendations.present) {
      map['ai_recommendations'] = Variable<String>(aiRecommendations.value);
    }
    if (clinicalFindings.present) {
      map['clinical_findings'] = Variable<String>(clinicalFindings.value);
    }
    if (confidenceScore.present) {
      map['confidence_score'] = Variable<double>(confidenceScore.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClinicalAssessmentsCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('assessmentType: $assessmentType, ')
          ..write('ragContext: $ragContext, ')
          ..write('aiRecommendations: $aiRecommendations, ')
          ..write('clinicalFindings: $clinicalFindings, ')
          ..write('confidenceScore: $confidenceScore, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $LabResultsTable extends LabResults
    with TableInfo<$LabResultsTable, LabResult> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LabResultsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _patientIdMeta =
      const VerificationMeta('patientId');
  @override
  late final GeneratedColumn<int> patientId = GeneratedColumn<int>(
      'patient_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES patients (id)'));
  static const VerificationMeta _testNameMeta =
      const VerificationMeta('testName');
  @override
  late final GeneratedColumn<String> testName = GeneratedColumn<String>(
      'test_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
      'value', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
      'unit', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _referenceMinMeta =
      const VerificationMeta('referenceMin');
  @override
  late final GeneratedColumn<double> referenceMin = GeneratedColumn<double>(
      'reference_min', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _referenceMaxMeta =
      const VerificationMeta('referenceMax');
  @override
  late final GeneratedColumn<double> referenceMax = GeneratedColumn<double>(
      'reference_max', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _interpretationMeta =
      const VerificationMeta('interpretation');
  @override
  late final GeneratedColumn<String> interpretation = GeneratedColumn<String>(
      'interpretation', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _testDateMeta =
      const VerificationMeta('testDate');
  @override
  late final GeneratedColumn<DateTime> testDate = GeneratedColumn<DateTime>(
      'test_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        patientId,
        testName,
        value,
        unit,
        referenceMin,
        referenceMax,
        interpretation,
        testDate,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lab_results';
  @override
  VerificationContext validateIntegrity(Insertable<LabResult> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('patient_id')) {
      context.handle(_patientIdMeta,
          patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta));
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('test_name')) {
      context.handle(_testNameMeta,
          testName.isAcceptableOrUnknown(data['test_name']!, _testNameMeta));
    } else if (isInserting) {
      context.missing(_testNameMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('reference_min')) {
      context.handle(
          _referenceMinMeta,
          referenceMin.isAcceptableOrUnknown(
              data['reference_min']!, _referenceMinMeta));
    }
    if (data.containsKey('reference_max')) {
      context.handle(
          _referenceMaxMeta,
          referenceMax.isAcceptableOrUnknown(
              data['reference_max']!, _referenceMaxMeta));
    }
    if (data.containsKey('interpretation')) {
      context.handle(
          _interpretationMeta,
          interpretation.isAcceptableOrUnknown(
              data['interpretation']!, _interpretationMeta));
    }
    if (data.containsKey('test_date')) {
      context.handle(_testDateMeta,
          testDate.isAcceptableOrUnknown(data['test_date']!, _testDateMeta));
    } else if (isInserting) {
      context.missing(_testDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LabResult map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LabResult(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      patientId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}patient_id'])!,
      testName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}test_name'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}value'])!,
      unit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit'])!,
      referenceMin: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}reference_min']),
      referenceMax: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}reference_max']),
      interpretation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}interpretation']),
      testDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}test_date'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $LabResultsTable createAlias(String alias) {
    return $LabResultsTable(attachedDatabase, alias);
  }
}

class LabResult extends DataClass implements Insertable<LabResult> {
  final int id;
  final int patientId;
  final String testName;
  final double value;
  final String unit;
  final double? referenceMin;
  final double? referenceMax;
  final String? interpretation;
  final DateTime testDate;
  final DateTime createdAt;
  const LabResult(
      {required this.id,
      required this.patientId,
      required this.testName,
      required this.value,
      required this.unit,
      this.referenceMin,
      this.referenceMax,
      this.interpretation,
      required this.testDate,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['patient_id'] = Variable<int>(patientId);
    map['test_name'] = Variable<String>(testName);
    map['value'] = Variable<double>(value);
    map['unit'] = Variable<String>(unit);
    if (!nullToAbsent || referenceMin != null) {
      map['reference_min'] = Variable<double>(referenceMin);
    }
    if (!nullToAbsent || referenceMax != null) {
      map['reference_max'] = Variable<double>(referenceMax);
    }
    if (!nullToAbsent || interpretation != null) {
      map['interpretation'] = Variable<String>(interpretation);
    }
    map['test_date'] = Variable<DateTime>(testDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LabResultsCompanion toCompanion(bool nullToAbsent) {
    return LabResultsCompanion(
      id: Value(id),
      patientId: Value(patientId),
      testName: Value(testName),
      value: Value(value),
      unit: Value(unit),
      referenceMin: referenceMin == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceMin),
      referenceMax: referenceMax == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceMax),
      interpretation: interpretation == null && nullToAbsent
          ? const Value.absent()
          : Value(interpretation),
      testDate: Value(testDate),
      createdAt: Value(createdAt),
    );
  }

  factory LabResult.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LabResult(
      id: serializer.fromJson<int>(json['id']),
      patientId: serializer.fromJson<int>(json['patientId']),
      testName: serializer.fromJson<String>(json['testName']),
      value: serializer.fromJson<double>(json['value']),
      unit: serializer.fromJson<String>(json['unit']),
      referenceMin: serializer.fromJson<double?>(json['referenceMin']),
      referenceMax: serializer.fromJson<double?>(json['referenceMax']),
      interpretation: serializer.fromJson<String?>(json['interpretation']),
      testDate: serializer.fromJson<DateTime>(json['testDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'patientId': serializer.toJson<int>(patientId),
      'testName': serializer.toJson<String>(testName),
      'value': serializer.toJson<double>(value),
      'unit': serializer.toJson<String>(unit),
      'referenceMin': serializer.toJson<double?>(referenceMin),
      'referenceMax': serializer.toJson<double?>(referenceMax),
      'interpretation': serializer.toJson<String?>(interpretation),
      'testDate': serializer.toJson<DateTime>(testDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LabResult copyWith(
          {int? id,
          int? patientId,
          String? testName,
          double? value,
          String? unit,
          Value<double?> referenceMin = const Value.absent(),
          Value<double?> referenceMax = const Value.absent(),
          Value<String?> interpretation = const Value.absent(),
          DateTime? testDate,
          DateTime? createdAt}) =>
      LabResult(
        id: id ?? this.id,
        patientId: patientId ?? this.patientId,
        testName: testName ?? this.testName,
        value: value ?? this.value,
        unit: unit ?? this.unit,
        referenceMin:
            referenceMin.present ? referenceMin.value : this.referenceMin,
        referenceMax:
            referenceMax.present ? referenceMax.value : this.referenceMax,
        interpretation:
            interpretation.present ? interpretation.value : this.interpretation,
        testDate: testDate ?? this.testDate,
        createdAt: createdAt ?? this.createdAt,
      );
  LabResult copyWithCompanion(LabResultsCompanion data) {
    return LabResult(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      testName: data.testName.present ? data.testName.value : this.testName,
      value: data.value.present ? data.value.value : this.value,
      unit: data.unit.present ? data.unit.value : this.unit,
      referenceMin: data.referenceMin.present
          ? data.referenceMin.value
          : this.referenceMin,
      referenceMax: data.referenceMax.present
          ? data.referenceMax.value
          : this.referenceMax,
      interpretation: data.interpretation.present
          ? data.interpretation.value
          : this.interpretation,
      testDate: data.testDate.present ? data.testDate.value : this.testDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LabResult(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('testName: $testName, ')
          ..write('value: $value, ')
          ..write('unit: $unit, ')
          ..write('referenceMin: $referenceMin, ')
          ..write('referenceMax: $referenceMax, ')
          ..write('interpretation: $interpretation, ')
          ..write('testDate: $testDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, patientId, testName, value, unit,
      referenceMin, referenceMax, interpretation, testDate, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LabResult &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.testName == this.testName &&
          other.value == this.value &&
          other.unit == this.unit &&
          other.referenceMin == this.referenceMin &&
          other.referenceMax == this.referenceMax &&
          other.interpretation == this.interpretation &&
          other.testDate == this.testDate &&
          other.createdAt == this.createdAt);
}

class LabResultsCompanion extends UpdateCompanion<LabResult> {
  final Value<int> id;
  final Value<int> patientId;
  final Value<String> testName;
  final Value<double> value;
  final Value<String> unit;
  final Value<double?> referenceMin;
  final Value<double?> referenceMax;
  final Value<String?> interpretation;
  final Value<DateTime> testDate;
  final Value<DateTime> createdAt;
  const LabResultsCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.testName = const Value.absent(),
    this.value = const Value.absent(),
    this.unit = const Value.absent(),
    this.referenceMin = const Value.absent(),
    this.referenceMax = const Value.absent(),
    this.interpretation = const Value.absent(),
    this.testDate = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  LabResultsCompanion.insert({
    this.id = const Value.absent(),
    required int patientId,
    required String testName,
    required double value,
    required String unit,
    this.referenceMin = const Value.absent(),
    this.referenceMax = const Value.absent(),
    this.interpretation = const Value.absent(),
    required DateTime testDate,
    this.createdAt = const Value.absent(),
  })  : patientId = Value(patientId),
        testName = Value(testName),
        value = Value(value),
        unit = Value(unit),
        testDate = Value(testDate);
  static Insertable<LabResult> custom({
    Expression<int>? id,
    Expression<int>? patientId,
    Expression<String>? testName,
    Expression<double>? value,
    Expression<String>? unit,
    Expression<double>? referenceMin,
    Expression<double>? referenceMax,
    Expression<String>? interpretation,
    Expression<DateTime>? testDate,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (testName != null) 'test_name': testName,
      if (value != null) 'value': value,
      if (unit != null) 'unit': unit,
      if (referenceMin != null) 'reference_min': referenceMin,
      if (referenceMax != null) 'reference_max': referenceMax,
      if (interpretation != null) 'interpretation': interpretation,
      if (testDate != null) 'test_date': testDate,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  LabResultsCompanion copyWith(
      {Value<int>? id,
      Value<int>? patientId,
      Value<String>? testName,
      Value<double>? value,
      Value<String>? unit,
      Value<double?>? referenceMin,
      Value<double?>? referenceMax,
      Value<String?>? interpretation,
      Value<DateTime>? testDate,
      Value<DateTime>? createdAt}) {
    return LabResultsCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      testName: testName ?? this.testName,
      value: value ?? this.value,
      unit: unit ?? this.unit,
      referenceMin: referenceMin ?? this.referenceMin,
      referenceMax: referenceMax ?? this.referenceMax,
      interpretation: interpretation ?? this.interpretation,
      testDate: testDate ?? this.testDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<int>(patientId.value);
    }
    if (testName.present) {
      map['test_name'] = Variable<String>(testName.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (referenceMin.present) {
      map['reference_min'] = Variable<double>(referenceMin.value);
    }
    if (referenceMax.present) {
      map['reference_max'] = Variable<double>(referenceMax.value);
    }
    if (interpretation.present) {
      map['interpretation'] = Variable<String>(interpretation.value);
    }
    if (testDate.present) {
      map['test_date'] = Variable<DateTime>(testDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LabResultsCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('testName: $testName, ')
          ..write('value: $value, ')
          ..write('unit: $unit, ')
          ..write('referenceMin: $referenceMin, ')
          ..write('referenceMax: $referenceMax, ')
          ..write('interpretation: $interpretation, ')
          ..write('testDate: $testDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SymptomsTable extends Symptoms with TableInfo<$SymptomsTable, Symptom> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SymptomsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _patientIdMeta =
      const VerificationMeta('patientId');
  @override
  late final GeneratedColumn<int> patientId = GeneratedColumn<int>(
      'patient_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES patients (id)'));
  static const VerificationMeta _symptomTextMeta =
      const VerificationMeta('symptomText');
  @override
  late final GeneratedColumn<String> symptomText = GeneratedColumn<String>(
      'symptom_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _processedSymptomsMeta =
      const VerificationMeta('processedSymptoms');
  @override
  late final GeneratedColumn<String> processedSymptoms =
      GeneratedColumn<String>('processed_symptoms', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _severityMeta =
      const VerificationMeta('severity');
  @override
  late final GeneratedColumn<String> severity = GeneratedColumn<String>(
      'severity', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _embeddingMeta =
      const VerificationMeta('embedding');
  @override
  late final GeneratedColumn<String> embedding = GeneratedColumn<String>(
      'embedding', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _reportedAtMeta =
      const VerificationMeta('reportedAt');
  @override
  late final GeneratedColumn<DateTime> reportedAt = GeneratedColumn<DateTime>(
      'reported_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        patientId,
        symptomText,
        processedSymptoms,
        severity,
        embedding,
        reportedAt,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'symptoms';
  @override
  VerificationContext validateIntegrity(Insertable<Symptom> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('patient_id')) {
      context.handle(_patientIdMeta,
          patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta));
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('symptom_text')) {
      context.handle(
          _symptomTextMeta,
          symptomText.isAcceptableOrUnknown(
              data['symptom_text']!, _symptomTextMeta));
    } else if (isInserting) {
      context.missing(_symptomTextMeta);
    }
    if (data.containsKey('processed_symptoms')) {
      context.handle(
          _processedSymptomsMeta,
          processedSymptoms.isAcceptableOrUnknown(
              data['processed_symptoms']!, _processedSymptomsMeta));
    } else if (isInserting) {
      context.missing(_processedSymptomsMeta);
    }
    if (data.containsKey('severity')) {
      context.handle(_severityMeta,
          severity.isAcceptableOrUnknown(data['severity']!, _severityMeta));
    } else if (isInserting) {
      context.missing(_severityMeta);
    }
    if (data.containsKey('embedding')) {
      context.handle(_embeddingMeta,
          embedding.isAcceptableOrUnknown(data['embedding']!, _embeddingMeta));
    }
    if (data.containsKey('reported_at')) {
      context.handle(
          _reportedAtMeta,
          reportedAt.isAcceptableOrUnknown(
              data['reported_at']!, _reportedAtMeta));
    } else if (isInserting) {
      context.missing(_reportedAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Symptom map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Symptom(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      patientId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}patient_id'])!,
      symptomText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}symptom_text'])!,
      processedSymptoms: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}processed_symptoms'])!,
      severity: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}severity'])!,
      embedding: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}embedding']),
      reportedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}reported_at'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SymptomsTable createAlias(String alias) {
    return $SymptomsTable(attachedDatabase, alias);
  }
}

class Symptom extends DataClass implements Insertable<Symptom> {
  final int id;
  final int patientId;
  final String symptomText;
  final String processedSymptoms;
  final String severity;
  final String? embedding;
  final DateTime reportedAt;
  final DateTime createdAt;
  const Symptom(
      {required this.id,
      required this.patientId,
      required this.symptomText,
      required this.processedSymptoms,
      required this.severity,
      this.embedding,
      required this.reportedAt,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['patient_id'] = Variable<int>(patientId);
    map['symptom_text'] = Variable<String>(symptomText);
    map['processed_symptoms'] = Variable<String>(processedSymptoms);
    map['severity'] = Variable<String>(severity);
    if (!nullToAbsent || embedding != null) {
      map['embedding'] = Variable<String>(embedding);
    }
    map['reported_at'] = Variable<DateTime>(reportedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SymptomsCompanion toCompanion(bool nullToAbsent) {
    return SymptomsCompanion(
      id: Value(id),
      patientId: Value(patientId),
      symptomText: Value(symptomText),
      processedSymptoms: Value(processedSymptoms),
      severity: Value(severity),
      embedding: embedding == null && nullToAbsent
          ? const Value.absent()
          : Value(embedding),
      reportedAt: Value(reportedAt),
      createdAt: Value(createdAt),
    );
  }

  factory Symptom.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Symptom(
      id: serializer.fromJson<int>(json['id']),
      patientId: serializer.fromJson<int>(json['patientId']),
      symptomText: serializer.fromJson<String>(json['symptomText']),
      processedSymptoms: serializer.fromJson<String>(json['processedSymptoms']),
      severity: serializer.fromJson<String>(json['severity']),
      embedding: serializer.fromJson<String?>(json['embedding']),
      reportedAt: serializer.fromJson<DateTime>(json['reportedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'patientId': serializer.toJson<int>(patientId),
      'symptomText': serializer.toJson<String>(symptomText),
      'processedSymptoms': serializer.toJson<String>(processedSymptoms),
      'severity': serializer.toJson<String>(severity),
      'embedding': serializer.toJson<String?>(embedding),
      'reportedAt': serializer.toJson<DateTime>(reportedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Symptom copyWith(
          {int? id,
          int? patientId,
          String? symptomText,
          String? processedSymptoms,
          String? severity,
          Value<String?> embedding = const Value.absent(),
          DateTime? reportedAt,
          DateTime? createdAt}) =>
      Symptom(
        id: id ?? this.id,
        patientId: patientId ?? this.patientId,
        symptomText: symptomText ?? this.symptomText,
        processedSymptoms: processedSymptoms ?? this.processedSymptoms,
        severity: severity ?? this.severity,
        embedding: embedding.present ? embedding.value : this.embedding,
        reportedAt: reportedAt ?? this.reportedAt,
        createdAt: createdAt ?? this.createdAt,
      );
  Symptom copyWithCompanion(SymptomsCompanion data) {
    return Symptom(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      symptomText:
          data.symptomText.present ? data.symptomText.value : this.symptomText,
      processedSymptoms: data.processedSymptoms.present
          ? data.processedSymptoms.value
          : this.processedSymptoms,
      severity: data.severity.present ? data.severity.value : this.severity,
      embedding: data.embedding.present ? data.embedding.value : this.embedding,
      reportedAt:
          data.reportedAt.present ? data.reportedAt.value : this.reportedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Symptom(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('symptomText: $symptomText, ')
          ..write('processedSymptoms: $processedSymptoms, ')
          ..write('severity: $severity, ')
          ..write('embedding: $embedding, ')
          ..write('reportedAt: $reportedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, patientId, symptomText, processedSymptoms,
      severity, embedding, reportedAt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Symptom &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.symptomText == this.symptomText &&
          other.processedSymptoms == this.processedSymptoms &&
          other.severity == this.severity &&
          other.embedding == this.embedding &&
          other.reportedAt == this.reportedAt &&
          other.createdAt == this.createdAt);
}

class SymptomsCompanion extends UpdateCompanion<Symptom> {
  final Value<int> id;
  final Value<int> patientId;
  final Value<String> symptomText;
  final Value<String> processedSymptoms;
  final Value<String> severity;
  final Value<String?> embedding;
  final Value<DateTime> reportedAt;
  final Value<DateTime> createdAt;
  const SymptomsCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.symptomText = const Value.absent(),
    this.processedSymptoms = const Value.absent(),
    this.severity = const Value.absent(),
    this.embedding = const Value.absent(),
    this.reportedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SymptomsCompanion.insert({
    this.id = const Value.absent(),
    required int patientId,
    required String symptomText,
    required String processedSymptoms,
    required String severity,
    this.embedding = const Value.absent(),
    required DateTime reportedAt,
    this.createdAt = const Value.absent(),
  })  : patientId = Value(patientId),
        symptomText = Value(symptomText),
        processedSymptoms = Value(processedSymptoms),
        severity = Value(severity),
        reportedAt = Value(reportedAt);
  static Insertable<Symptom> custom({
    Expression<int>? id,
    Expression<int>? patientId,
    Expression<String>? symptomText,
    Expression<String>? processedSymptoms,
    Expression<String>? severity,
    Expression<String>? embedding,
    Expression<DateTime>? reportedAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (symptomText != null) 'symptom_text': symptomText,
      if (processedSymptoms != null) 'processed_symptoms': processedSymptoms,
      if (severity != null) 'severity': severity,
      if (embedding != null) 'embedding': embedding,
      if (reportedAt != null) 'reported_at': reportedAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SymptomsCompanion copyWith(
      {Value<int>? id,
      Value<int>? patientId,
      Value<String>? symptomText,
      Value<String>? processedSymptoms,
      Value<String>? severity,
      Value<String?>? embedding,
      Value<DateTime>? reportedAt,
      Value<DateTime>? createdAt}) {
    return SymptomsCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      symptomText: symptomText ?? this.symptomText,
      processedSymptoms: processedSymptoms ?? this.processedSymptoms,
      severity: severity ?? this.severity,
      embedding: embedding ?? this.embedding,
      reportedAt: reportedAt ?? this.reportedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<int>(patientId.value);
    }
    if (symptomText.present) {
      map['symptom_text'] = Variable<String>(symptomText.value);
    }
    if (processedSymptoms.present) {
      map['processed_symptoms'] = Variable<String>(processedSymptoms.value);
    }
    if (severity.present) {
      map['severity'] = Variable<String>(severity.value);
    }
    if (embedding.present) {
      map['embedding'] = Variable<String>(embedding.value);
    }
    if (reportedAt.present) {
      map['reported_at'] = Variable<DateTime>(reportedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SymptomsCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('symptomText: $symptomText, ')
          ..write('processedSymptoms: $processedSymptoms, ')
          ..write('severity: $severity, ')
          ..write('embedding: $embedding, ')
          ..write('reportedAt: $reportedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MedicationsTable extends Medications
    with TableInfo<$MedicationsTable, Medication> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedicationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _patientIdMeta =
      const VerificationMeta('patientId');
  @override
  late final GeneratedColumn<int> patientId = GeneratedColumn<int>(
      'patient_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES patients (id)'));
  static const VerificationMeta _medicationNameMeta =
      const VerificationMeta('medicationName');
  @override
  late final GeneratedColumn<String> medicationName = GeneratedColumn<String>(
      'medication_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dosageMeta = const VerificationMeta('dosage');
  @override
  late final GeneratedColumn<String> dosage = GeneratedColumn<String>(
      'dosage', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _frequencyMeta =
      const VerificationMeta('frequency');
  @override
  late final GeneratedColumn<String> frequency = GeneratedColumn<String>(
      'frequency', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _safetyAlertsMeta =
      const VerificationMeta('safetyAlerts');
  @override
  late final GeneratedColumn<String> safetyAlerts = GeneratedColumn<String>(
      'safety_alerts', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        patientId,
        medicationName,
        dosage,
        frequency,
        safetyAlerts,
        isActive,
        startDate,
        endDate,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medications';
  @override
  VerificationContext validateIntegrity(Insertable<Medication> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('patient_id')) {
      context.handle(_patientIdMeta,
          patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta));
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('medication_name')) {
      context.handle(
          _medicationNameMeta,
          medicationName.isAcceptableOrUnknown(
              data['medication_name']!, _medicationNameMeta));
    } else if (isInserting) {
      context.missing(_medicationNameMeta);
    }
    if (data.containsKey('dosage')) {
      context.handle(_dosageMeta,
          dosage.isAcceptableOrUnknown(data['dosage']!, _dosageMeta));
    } else if (isInserting) {
      context.missing(_dosageMeta);
    }
    if (data.containsKey('frequency')) {
      context.handle(_frequencyMeta,
          frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta));
    } else if (isInserting) {
      context.missing(_frequencyMeta);
    }
    if (data.containsKey('safety_alerts')) {
      context.handle(
          _safetyAlertsMeta,
          safetyAlerts.isAcceptableOrUnknown(
              data['safety_alerts']!, _safetyAlertsMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Medication map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Medication(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      patientId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}patient_id'])!,
      medicationName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}medication_name'])!,
      dosage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dosage'])!,
      frequency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}frequency'])!,
      safetyAlerts: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}safety_alerts']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $MedicationsTable createAlias(String alias) {
    return $MedicationsTable(attachedDatabase, alias);
  }
}

class Medication extends DataClass implements Insertable<Medication> {
  final int id;
  final int patientId;
  final String medicationName;
  final String dosage;
  final String frequency;
  final String? safetyAlerts;
  final bool isActive;
  final DateTime startDate;
  final DateTime? endDate;
  final DateTime createdAt;
  const Medication(
      {required this.id,
      required this.patientId,
      required this.medicationName,
      required this.dosage,
      required this.frequency,
      this.safetyAlerts,
      required this.isActive,
      required this.startDate,
      this.endDate,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['patient_id'] = Variable<int>(patientId);
    map['medication_name'] = Variable<String>(medicationName);
    map['dosage'] = Variable<String>(dosage);
    map['frequency'] = Variable<String>(frequency);
    if (!nullToAbsent || safetyAlerts != null) {
      map['safety_alerts'] = Variable<String>(safetyAlerts);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MedicationsCompanion toCompanion(bool nullToAbsent) {
    return MedicationsCompanion(
      id: Value(id),
      patientId: Value(patientId),
      medicationName: Value(medicationName),
      dosage: Value(dosage),
      frequency: Value(frequency),
      safetyAlerts: safetyAlerts == null && nullToAbsent
          ? const Value.absent()
          : Value(safetyAlerts),
      isActive: Value(isActive),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      createdAt: Value(createdAt),
    );
  }

  factory Medication.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Medication(
      id: serializer.fromJson<int>(json['id']),
      patientId: serializer.fromJson<int>(json['patientId']),
      medicationName: serializer.fromJson<String>(json['medicationName']),
      dosage: serializer.fromJson<String>(json['dosage']),
      frequency: serializer.fromJson<String>(json['frequency']),
      safetyAlerts: serializer.fromJson<String?>(json['safetyAlerts']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'patientId': serializer.toJson<int>(patientId),
      'medicationName': serializer.toJson<String>(medicationName),
      'dosage': serializer.toJson<String>(dosage),
      'frequency': serializer.toJson<String>(frequency),
      'safetyAlerts': serializer.toJson<String?>(safetyAlerts),
      'isActive': serializer.toJson<bool>(isActive),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Medication copyWith(
          {int? id,
          int? patientId,
          String? medicationName,
          String? dosage,
          String? frequency,
          Value<String?> safetyAlerts = const Value.absent(),
          bool? isActive,
          DateTime? startDate,
          Value<DateTime?> endDate = const Value.absent(),
          DateTime? createdAt}) =>
      Medication(
        id: id ?? this.id,
        patientId: patientId ?? this.patientId,
        medicationName: medicationName ?? this.medicationName,
        dosage: dosage ?? this.dosage,
        frequency: frequency ?? this.frequency,
        safetyAlerts:
            safetyAlerts.present ? safetyAlerts.value : this.safetyAlerts,
        isActive: isActive ?? this.isActive,
        startDate: startDate ?? this.startDate,
        endDate: endDate.present ? endDate.value : this.endDate,
        createdAt: createdAt ?? this.createdAt,
      );
  Medication copyWithCompanion(MedicationsCompanion data) {
    return Medication(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      medicationName: data.medicationName.present
          ? data.medicationName.value
          : this.medicationName,
      dosage: data.dosage.present ? data.dosage.value : this.dosage,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      safetyAlerts: data.safetyAlerts.present
          ? data.safetyAlerts.value
          : this.safetyAlerts,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Medication(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('medicationName: $medicationName, ')
          ..write('dosage: $dosage, ')
          ..write('frequency: $frequency, ')
          ..write('safetyAlerts: $safetyAlerts, ')
          ..write('isActive: $isActive, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, patientId, medicationName, dosage,
      frequency, safetyAlerts, isActive, startDate, endDate, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Medication &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.medicationName == this.medicationName &&
          other.dosage == this.dosage &&
          other.frequency == this.frequency &&
          other.safetyAlerts == this.safetyAlerts &&
          other.isActive == this.isActive &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.createdAt == this.createdAt);
}

class MedicationsCompanion extends UpdateCompanion<Medication> {
  final Value<int> id;
  final Value<int> patientId;
  final Value<String> medicationName;
  final Value<String> dosage;
  final Value<String> frequency;
  final Value<String?> safetyAlerts;
  final Value<bool> isActive;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<DateTime> createdAt;
  const MedicationsCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.medicationName = const Value.absent(),
    this.dosage = const Value.absent(),
    this.frequency = const Value.absent(),
    this.safetyAlerts = const Value.absent(),
    this.isActive = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MedicationsCompanion.insert({
    this.id = const Value.absent(),
    required int patientId,
    required String medicationName,
    required String dosage,
    required String frequency,
    this.safetyAlerts = const Value.absent(),
    this.isActive = const Value.absent(),
    required DateTime startDate,
    this.endDate = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : patientId = Value(patientId),
        medicationName = Value(medicationName),
        dosage = Value(dosage),
        frequency = Value(frequency),
        startDate = Value(startDate);
  static Insertable<Medication> custom({
    Expression<int>? id,
    Expression<int>? patientId,
    Expression<String>? medicationName,
    Expression<String>? dosage,
    Expression<String>? frequency,
    Expression<String>? safetyAlerts,
    Expression<bool>? isActive,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (medicationName != null) 'medication_name': medicationName,
      if (dosage != null) 'dosage': dosage,
      if (frequency != null) 'frequency': frequency,
      if (safetyAlerts != null) 'safety_alerts': safetyAlerts,
      if (isActive != null) 'is_active': isActive,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MedicationsCompanion copyWith(
      {Value<int>? id,
      Value<int>? patientId,
      Value<String>? medicationName,
      Value<String>? dosage,
      Value<String>? frequency,
      Value<String?>? safetyAlerts,
      Value<bool>? isActive,
      Value<DateTime>? startDate,
      Value<DateTime?>? endDate,
      Value<DateTime>? createdAt}) {
    return MedicationsCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      medicationName: medicationName ?? this.medicationName,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
      safetyAlerts: safetyAlerts ?? this.safetyAlerts,
      isActive: isActive ?? this.isActive,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<int>(patientId.value);
    }
    if (medicationName.present) {
      map['medication_name'] = Variable<String>(medicationName.value);
    }
    if (dosage.present) {
      map['dosage'] = Variable<String>(dosage.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (safetyAlerts.present) {
      map['safety_alerts'] = Variable<String>(safetyAlerts.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicationsCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('medicationName: $medicationName, ')
          ..write('dosage: $dosage, ')
          ..write('frequency: $frequency, ')
          ..write('safetyAlerts: $safetyAlerts, ')
          ..write('isActive: $isActive, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $RagQueryCacheTable extends RagQueryCache
    with TableInfo<$RagQueryCacheTable, RagQueryCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RagQueryCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _queryHashMeta =
      const VerificationMeta('queryHash');
  @override
  late final GeneratedColumn<String> queryHash = GeneratedColumn<String>(
      'query_hash', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _queryMeta = const VerificationMeta('query');
  @override
  late final GeneratedColumn<String> query = GeneratedColumn<String>(
      'query', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _retrievedContextMeta =
      const VerificationMeta('retrievedContext');
  @override
  late final GeneratedColumn<String> retrievedContext = GeneratedColumn<String>(
      'retrieved_context', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _generatedResponseMeta =
      const VerificationMeta('generatedResponse');
  @override
  late final GeneratedColumn<String> generatedResponse =
      GeneratedColumn<String>('generated_response', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _relevanceScoreMeta =
      const VerificationMeta('relevanceScore');
  @override
  late final GeneratedColumn<double> relevanceScore = GeneratedColumn<double>(
      'relevance_score', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _expiresAtMeta =
      const VerificationMeta('expiresAt');
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
      'expires_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        queryHash,
        query,
        retrievedContext,
        generatedResponse,
        relevanceScore,
        createdAt,
        expiresAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rag_query_cache';
  @override
  VerificationContext validateIntegrity(Insertable<RagQueryCacheData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('query_hash')) {
      context.handle(_queryHashMeta,
          queryHash.isAcceptableOrUnknown(data['query_hash']!, _queryHashMeta));
    } else if (isInserting) {
      context.missing(_queryHashMeta);
    }
    if (data.containsKey('query')) {
      context.handle(
          _queryMeta, query.isAcceptableOrUnknown(data['query']!, _queryMeta));
    } else if (isInserting) {
      context.missing(_queryMeta);
    }
    if (data.containsKey('retrieved_context')) {
      context.handle(
          _retrievedContextMeta,
          retrievedContext.isAcceptableOrUnknown(
              data['retrieved_context']!, _retrievedContextMeta));
    } else if (isInserting) {
      context.missing(_retrievedContextMeta);
    }
    if (data.containsKey('generated_response')) {
      context.handle(
          _generatedResponseMeta,
          generatedResponse.isAcceptableOrUnknown(
              data['generated_response']!, _generatedResponseMeta));
    } else if (isInserting) {
      context.missing(_generatedResponseMeta);
    }
    if (data.containsKey('relevance_score')) {
      context.handle(
          _relevanceScoreMeta,
          relevanceScore.isAcceptableOrUnknown(
              data['relevance_score']!, _relevanceScoreMeta));
    } else if (isInserting) {
      context.missing(_relevanceScoreMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('expires_at')) {
      context.handle(_expiresAtMeta,
          expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta));
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RagQueryCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RagQueryCacheData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      queryHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}query_hash'])!,
      query: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}query'])!,
      retrievedContext: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}retrieved_context'])!,
      generatedResponse: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}generated_response'])!,
      relevanceScore: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}relevance_score'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      expiresAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}expires_at'])!,
    );
  }

  @override
  $RagQueryCacheTable createAlias(String alias) {
    return $RagQueryCacheTable(attachedDatabase, alias);
  }
}

class RagQueryCacheData extends DataClass
    implements Insertable<RagQueryCacheData> {
  final int id;
  final String queryHash;
  final String query;
  final String retrievedContext;
  final String generatedResponse;
  final double relevanceScore;
  final DateTime createdAt;
  final DateTime expiresAt;
  const RagQueryCacheData(
      {required this.id,
      required this.queryHash,
      required this.query,
      required this.retrievedContext,
      required this.generatedResponse,
      required this.relevanceScore,
      required this.createdAt,
      required this.expiresAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['query_hash'] = Variable<String>(queryHash);
    map['query'] = Variable<String>(query);
    map['retrieved_context'] = Variable<String>(retrievedContext);
    map['generated_response'] = Variable<String>(generatedResponse);
    map['relevance_score'] = Variable<double>(relevanceScore);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['expires_at'] = Variable<DateTime>(expiresAt);
    return map;
  }

  RagQueryCacheCompanion toCompanion(bool nullToAbsent) {
    return RagQueryCacheCompanion(
      id: Value(id),
      queryHash: Value(queryHash),
      query: Value(query),
      retrievedContext: Value(retrievedContext),
      generatedResponse: Value(generatedResponse),
      relevanceScore: Value(relevanceScore),
      createdAt: Value(createdAt),
      expiresAt: Value(expiresAt),
    );
  }

  factory RagQueryCacheData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RagQueryCacheData(
      id: serializer.fromJson<int>(json['id']),
      queryHash: serializer.fromJson<String>(json['queryHash']),
      query: serializer.fromJson<String>(json['query']),
      retrievedContext: serializer.fromJson<String>(json['retrievedContext']),
      generatedResponse: serializer.fromJson<String>(json['generatedResponse']),
      relevanceScore: serializer.fromJson<double>(json['relevanceScore']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      expiresAt: serializer.fromJson<DateTime>(json['expiresAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'queryHash': serializer.toJson<String>(queryHash),
      'query': serializer.toJson<String>(query),
      'retrievedContext': serializer.toJson<String>(retrievedContext),
      'generatedResponse': serializer.toJson<String>(generatedResponse),
      'relevanceScore': serializer.toJson<double>(relevanceScore),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'expiresAt': serializer.toJson<DateTime>(expiresAt),
    };
  }

  RagQueryCacheData copyWith(
          {int? id,
          String? queryHash,
          String? query,
          String? retrievedContext,
          String? generatedResponse,
          double? relevanceScore,
          DateTime? createdAt,
          DateTime? expiresAt}) =>
      RagQueryCacheData(
        id: id ?? this.id,
        queryHash: queryHash ?? this.queryHash,
        query: query ?? this.query,
        retrievedContext: retrievedContext ?? this.retrievedContext,
        generatedResponse: generatedResponse ?? this.generatedResponse,
        relevanceScore: relevanceScore ?? this.relevanceScore,
        createdAt: createdAt ?? this.createdAt,
        expiresAt: expiresAt ?? this.expiresAt,
      );
  RagQueryCacheData copyWithCompanion(RagQueryCacheCompanion data) {
    return RagQueryCacheData(
      id: data.id.present ? data.id.value : this.id,
      queryHash: data.queryHash.present ? data.queryHash.value : this.queryHash,
      query: data.query.present ? data.query.value : this.query,
      retrievedContext: data.retrievedContext.present
          ? data.retrievedContext.value
          : this.retrievedContext,
      generatedResponse: data.generatedResponse.present
          ? data.generatedResponse.value
          : this.generatedResponse,
      relevanceScore: data.relevanceScore.present
          ? data.relevanceScore.value
          : this.relevanceScore,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RagQueryCacheData(')
          ..write('id: $id, ')
          ..write('queryHash: $queryHash, ')
          ..write('query: $query, ')
          ..write('retrievedContext: $retrievedContext, ')
          ..write('generatedResponse: $generatedResponse, ')
          ..write('relevanceScore: $relevanceScore, ')
          ..write('createdAt: $createdAt, ')
          ..write('expiresAt: $expiresAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, queryHash, query, retrievedContext,
      generatedResponse, relevanceScore, createdAt, expiresAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RagQueryCacheData &&
          other.id == this.id &&
          other.queryHash == this.queryHash &&
          other.query == this.query &&
          other.retrievedContext == this.retrievedContext &&
          other.generatedResponse == this.generatedResponse &&
          other.relevanceScore == this.relevanceScore &&
          other.createdAt == this.createdAt &&
          other.expiresAt == this.expiresAt);
}

class RagQueryCacheCompanion extends UpdateCompanion<RagQueryCacheData> {
  final Value<int> id;
  final Value<String> queryHash;
  final Value<String> query;
  final Value<String> retrievedContext;
  final Value<String> generatedResponse;
  final Value<double> relevanceScore;
  final Value<DateTime> createdAt;
  final Value<DateTime> expiresAt;
  const RagQueryCacheCompanion({
    this.id = const Value.absent(),
    this.queryHash = const Value.absent(),
    this.query = const Value.absent(),
    this.retrievedContext = const Value.absent(),
    this.generatedResponse = const Value.absent(),
    this.relevanceScore = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
  });
  RagQueryCacheCompanion.insert({
    this.id = const Value.absent(),
    required String queryHash,
    required String query,
    required String retrievedContext,
    required String generatedResponse,
    required double relevanceScore,
    this.createdAt = const Value.absent(),
    required DateTime expiresAt,
  })  : queryHash = Value(queryHash),
        query = Value(query),
        retrievedContext = Value(retrievedContext),
        generatedResponse = Value(generatedResponse),
        relevanceScore = Value(relevanceScore),
        expiresAt = Value(expiresAt);
  static Insertable<RagQueryCacheData> custom({
    Expression<int>? id,
    Expression<String>? queryHash,
    Expression<String>? query,
    Expression<String>? retrievedContext,
    Expression<String>? generatedResponse,
    Expression<double>? relevanceScore,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? expiresAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (queryHash != null) 'query_hash': queryHash,
      if (query != null) 'query': query,
      if (retrievedContext != null) 'retrieved_context': retrievedContext,
      if (generatedResponse != null) 'generated_response': generatedResponse,
      if (relevanceScore != null) 'relevance_score': relevanceScore,
      if (createdAt != null) 'created_at': createdAt,
      if (expiresAt != null) 'expires_at': expiresAt,
    });
  }

  RagQueryCacheCompanion copyWith(
      {Value<int>? id,
      Value<String>? queryHash,
      Value<String>? query,
      Value<String>? retrievedContext,
      Value<String>? generatedResponse,
      Value<double>? relevanceScore,
      Value<DateTime>? createdAt,
      Value<DateTime>? expiresAt}) {
    return RagQueryCacheCompanion(
      id: id ?? this.id,
      queryHash: queryHash ?? this.queryHash,
      query: query ?? this.query,
      retrievedContext: retrievedContext ?? this.retrievedContext,
      generatedResponse: generatedResponse ?? this.generatedResponse,
      relevanceScore: relevanceScore ?? this.relevanceScore,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (queryHash.present) {
      map['query_hash'] = Variable<String>(queryHash.value);
    }
    if (query.present) {
      map['query'] = Variable<String>(query.value);
    }
    if (retrievedContext.present) {
      map['retrieved_context'] = Variable<String>(retrievedContext.value);
    }
    if (generatedResponse.present) {
      map['generated_response'] = Variable<String>(generatedResponse.value);
    }
    if (relevanceScore.present) {
      map['relevance_score'] = Variable<double>(relevanceScore.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RagQueryCacheCompanion(')
          ..write('id: $id, ')
          ..write('queryHash: $queryHash, ')
          ..write('query: $query, ')
          ..write('retrievedContext: $retrievedContext, ')
          ..write('generatedResponse: $generatedResponse, ')
          ..write('relevanceScore: $relevanceScore, ')
          ..write('createdAt: $createdAt, ')
          ..write('expiresAt: $expiresAt')
          ..write(')'))
        .toString();
  }
}

class $VitalsTable extends Vitals with TableInfo<$VitalsTable, Vital> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VitalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _clientIdMeta =
      const VerificationMeta('clientId');
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
      'client_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _patientIdMeta =
      const VerificationMeta('patientId');
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
      'patient_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
      'value', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
      'unit', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _recordedAtMeta =
      const VerificationMeta('recordedAt');
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
      'recorded_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _versionMeta =
      const VerificationMeta('version');
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
      'version', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _deviceIdMeta =
      const VerificationMeta('deviceId');
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
      'device_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        clientId,
        patientId,
        type,
        value,
        unit,
        status,
        notes,
        recordedAt,
        createdAt,
        updatedAt,
        version,
        synced,
        deviceId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vitals';
  @override
  VerificationContext validateIntegrity(Insertable<Vital> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(_patientIdMeta,
          patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta));
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
          _recordedAtMeta,
          recordedAt.isAcceptableOrUnknown(
              data['recorded_at']!, _recordedAtMeta));
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('version')) {
      context.handle(_versionMeta,
          version.isAcceptableOrUnknown(data['version']!, _versionMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    if (data.containsKey('device_id')) {
      context.handle(_deviceIdMeta,
          deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Vital map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Vital(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      clientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}client_id'])!,
      patientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}patient_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}value'])!,
      unit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      recordedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}recorded_at'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      version: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}version'])!,
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
      deviceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_id']),
    );
  }

  @override
  $VitalsTable createAlias(String alias) {
    return $VitalsTable(attachedDatabase, alias);
  }
}

class Vital extends DataClass implements Insertable<Vital> {
  final String id;
  final String clientId;
  final String patientId;
  final String type;
  final double value;
  final String unit;
  final String? status;
  final String? notes;
  final DateTime recordedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  final bool synced;
  final String? deviceId;
  const Vital(
      {required this.id,
      required this.clientId,
      required this.patientId,
      required this.type,
      required this.value,
      required this.unit,
      this.status,
      this.notes,
      required this.recordedAt,
      required this.createdAt,
      required this.updatedAt,
      required this.version,
      required this.synced,
      this.deviceId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['client_id'] = Variable<String>(clientId);
    map['patient_id'] = Variable<String>(patientId);
    map['type'] = Variable<String>(type);
    map['value'] = Variable<double>(value);
    map['unit'] = Variable<String>(unit);
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['version'] = Variable<int>(version);
    map['synced'] = Variable<bool>(synced);
    if (!nullToAbsent || deviceId != null) {
      map['device_id'] = Variable<String>(deviceId);
    }
    return map;
  }

  VitalsCompanion toCompanion(bool nullToAbsent) {
    return VitalsCompanion(
      id: Value(id),
      clientId: Value(clientId),
      patientId: Value(patientId),
      type: Value(type),
      value: Value(value),
      unit: Value(unit),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      recordedAt: Value(recordedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      version: Value(version),
      synced: Value(synced),
      deviceId: deviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceId),
    );
  }

  factory Vital.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vital(
      id: serializer.fromJson<String>(json['id']),
      clientId: serializer.fromJson<String>(json['clientId']),
      patientId: serializer.fromJson<String>(json['patientId']),
      type: serializer.fromJson<String>(json['type']),
      value: serializer.fromJson<double>(json['value']),
      unit: serializer.fromJson<String>(json['unit']),
      status: serializer.fromJson<String?>(json['status']),
      notes: serializer.fromJson<String?>(json['notes']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      version: serializer.fromJson<int>(json['version']),
      synced: serializer.fromJson<bool>(json['synced']),
      deviceId: serializer.fromJson<String?>(json['deviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'clientId': serializer.toJson<String>(clientId),
      'patientId': serializer.toJson<String>(patientId),
      'type': serializer.toJson<String>(type),
      'value': serializer.toJson<double>(value),
      'unit': serializer.toJson<String>(unit),
      'status': serializer.toJson<String?>(status),
      'notes': serializer.toJson<String?>(notes),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'version': serializer.toJson<int>(version),
      'synced': serializer.toJson<bool>(synced),
      'deviceId': serializer.toJson<String?>(deviceId),
    };
  }

  Vital copyWith(
          {String? id,
          String? clientId,
          String? patientId,
          String? type,
          double? value,
          String? unit,
          Value<String?> status = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? recordedAt,
          DateTime? createdAt,
          DateTime? updatedAt,
          int? version,
          bool? synced,
          Value<String?> deviceId = const Value.absent()}) =>
      Vital(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        patientId: patientId ?? this.patientId,
        type: type ?? this.type,
        value: value ?? this.value,
        unit: unit ?? this.unit,
        status: status.present ? status.value : this.status,
        notes: notes.present ? notes.value : this.notes,
        recordedAt: recordedAt ?? this.recordedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        version: version ?? this.version,
        synced: synced ?? this.synced,
        deviceId: deviceId.present ? deviceId.value : this.deviceId,
      );
  Vital copyWithCompanion(VitalsCompanion data) {
    return Vital(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      type: data.type.present ? data.type.value : this.type,
      value: data.value.present ? data.value.value : this.value,
      unit: data.unit.present ? data.unit.value : this.unit,
      status: data.status.present ? data.status.value : this.status,
      notes: data.notes.present ? data.notes.value : this.notes,
      recordedAt:
          data.recordedAt.present ? data.recordedAt.value : this.recordedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      version: data.version.present ? data.version.value : this.version,
      synced: data.synced.present ? data.synced.value : this.synced,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Vital(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('patientId: $patientId, ')
          ..write('type: $type, ')
          ..write('value: $value, ')
          ..write('unit: $unit, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('version: $version, ')
          ..write('synced: $synced, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      clientId,
      patientId,
      type,
      value,
      unit,
      status,
      notes,
      recordedAt,
      createdAt,
      updatedAt,
      version,
      synced,
      deviceId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vital &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.patientId == this.patientId &&
          other.type == this.type &&
          other.value == this.value &&
          other.unit == this.unit &&
          other.status == this.status &&
          other.notes == this.notes &&
          other.recordedAt == this.recordedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.version == this.version &&
          other.synced == this.synced &&
          other.deviceId == this.deviceId);
}

class VitalsCompanion extends UpdateCompanion<Vital> {
  final Value<String> id;
  final Value<String> clientId;
  final Value<String> patientId;
  final Value<String> type;
  final Value<double> value;
  final Value<String> unit;
  final Value<String?> status;
  final Value<String?> notes;
  final Value<DateTime> recordedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> version;
  final Value<bool> synced;
  final Value<String?> deviceId;
  final Value<int> rowid;
  const VitalsCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.patientId = const Value.absent(),
    this.type = const Value.absent(),
    this.value = const Value.absent(),
    this.unit = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.synced = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VitalsCompanion.insert({
    required String id,
    required String clientId,
    required String patientId,
    required String type,
    required double value,
    required String unit,
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime recordedAt,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.synced = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        clientId = Value(clientId),
        patientId = Value(patientId),
        type = Value(type),
        value = Value(value),
        unit = Value(unit),
        recordedAt = Value(recordedAt);
  static Insertable<Vital> custom({
    Expression<String>? id,
    Expression<String>? clientId,
    Expression<String>? patientId,
    Expression<String>? type,
    Expression<double>? value,
    Expression<String>? unit,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<DateTime>? recordedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? version,
    Expression<bool>? synced,
    Expression<String>? deviceId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (patientId != null) 'patient_id': patientId,
      if (type != null) 'type': type,
      if (value != null) 'value': value,
      if (unit != null) 'unit': unit,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (version != null) 'version': version,
      if (synced != null) 'synced': synced,
      if (deviceId != null) 'device_id': deviceId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VitalsCompanion copyWith(
      {Value<String>? id,
      Value<String>? clientId,
      Value<String>? patientId,
      Value<String>? type,
      Value<double>? value,
      Value<String>? unit,
      Value<String?>? status,
      Value<String?>? notes,
      Value<DateTime>? recordedAt,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? version,
      Value<bool>? synced,
      Value<String?>? deviceId,
      Value<int>? rowid}) {
    return VitalsCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      patientId: patientId ?? this.patientId,
      type: type ?? this.type,
      value: value ?? this.value,
      unit: unit ?? this.unit,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      recordedAt: recordedAt ?? this.recordedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
      synced: synced ?? this.synced,
      deviceId: deviceId ?? this.deviceId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VitalsCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('patientId: $patientId, ')
          ..write('type: $type, ')
          ..write('value: $value, ')
          ..write('unit: $unit, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('version: $version, ')
          ..write('synced: $synced, ')
          ..write('deviceId: $deviceId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BPReadingsTable extends BPReadings
    with TableInfo<$BPReadingsTable, BPReading> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BPReadingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _clientIdMeta =
      const VerificationMeta('clientId');
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
      'client_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _patientIdMeta =
      const VerificationMeta('patientId');
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
      'patient_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _systolicMeta =
      const VerificationMeta('systolic');
  @override
  late final GeneratedColumn<int> systolic = GeneratedColumn<int>(
      'systolic', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _diastolicMeta =
      const VerificationMeta('diastolic');
  @override
  late final GeneratedColumn<int> diastolic = GeneratedColumn<int>(
      'diastolic', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _heartRateMeta =
      const VerificationMeta('heartRate');
  @override
  late final GeneratedColumn<int> heartRate = GeneratedColumn<int>(
      'heart_rate', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
      'position', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _armMeta = const VerificationMeta('arm');
  @override
  late final GeneratedColumn<String> arm = GeneratedColumn<String>(
      'arm', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fatigueLevelMeta =
      const VerificationMeta('fatigueLevel');
  @override
  late final GeneratedColumn<double> fatigueLevel = GeneratedColumn<double>(
      'fatigue_level', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _symptomsMeta =
      const VerificationMeta('symptoms');
  @override
  late final GeneratedColumn<String> symptoms = GeneratedColumn<String>(
      'symptoms', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _recordedAtMeta =
      const VerificationMeta('recordedAt');
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
      'recorded_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _versionMeta =
      const VerificationMeta('version');
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
      'version', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        clientId,
        patientId,
        systolic,
        diastolic,
        heartRate,
        status,
        position,
        arm,
        fatigueLevel,
        symptoms,
        recordedAt,
        createdAt,
        version,
        synced
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'b_p_readings';
  @override
  VerificationContext validateIntegrity(Insertable<BPReading> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(_patientIdMeta,
          patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta));
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('systolic')) {
      context.handle(_systolicMeta,
          systolic.isAcceptableOrUnknown(data['systolic']!, _systolicMeta));
    } else if (isInserting) {
      context.missing(_systolicMeta);
    }
    if (data.containsKey('diastolic')) {
      context.handle(_diastolicMeta,
          diastolic.isAcceptableOrUnknown(data['diastolic']!, _diastolicMeta));
    } else if (isInserting) {
      context.missing(_diastolicMeta);
    }
    if (data.containsKey('heart_rate')) {
      context.handle(_heartRateMeta,
          heartRate.isAcceptableOrUnknown(data['heart_rate']!, _heartRateMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    }
    if (data.containsKey('arm')) {
      context.handle(
          _armMeta, arm.isAcceptableOrUnknown(data['arm']!, _armMeta));
    }
    if (data.containsKey('fatigue_level')) {
      context.handle(
          _fatigueLevelMeta,
          fatigueLevel.isAcceptableOrUnknown(
              data['fatigue_level']!, _fatigueLevelMeta));
    }
    if (data.containsKey('symptoms')) {
      context.handle(_symptomsMeta,
          symptoms.isAcceptableOrUnknown(data['symptoms']!, _symptomsMeta));
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
          _recordedAtMeta,
          recordedAt.isAcceptableOrUnknown(
              data['recorded_at']!, _recordedAtMeta));
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('version')) {
      context.handle(_versionMeta,
          version.isAcceptableOrUnknown(data['version']!, _versionMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  BPReading map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BPReading(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      clientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}client_id'])!,
      patientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}patient_id'])!,
      systolic: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}systolic'])!,
      diastolic: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}diastolic'])!,
      heartRate: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}heart_rate']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}position']),
      arm: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}arm']),
      fatigueLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fatigue_level']),
      symptoms: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}symptoms']),
      recordedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}recorded_at'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      version: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}version'])!,
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
    );
  }

  @override
  $BPReadingsTable createAlias(String alias) {
    return $BPReadingsTable(attachedDatabase, alias);
  }
}

class BPReading extends DataClass implements Insertable<BPReading> {
  final String id;
  final String clientId;
  final String patientId;
  final int systolic;
  final int diastolic;
  final int? heartRate;
  final String status;
  final String? position;
  final String? arm;
  final double? fatigueLevel;
  final String? symptoms;
  final DateTime recordedAt;
  final DateTime createdAt;
  final int version;
  final bool synced;
  const BPReading(
      {required this.id,
      required this.clientId,
      required this.patientId,
      required this.systolic,
      required this.diastolic,
      this.heartRate,
      required this.status,
      this.position,
      this.arm,
      this.fatigueLevel,
      this.symptoms,
      required this.recordedAt,
      required this.createdAt,
      required this.version,
      required this.synced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['client_id'] = Variable<String>(clientId);
    map['patient_id'] = Variable<String>(patientId);
    map['systolic'] = Variable<int>(systolic);
    map['diastolic'] = Variable<int>(diastolic);
    if (!nullToAbsent || heartRate != null) {
      map['heart_rate'] = Variable<int>(heartRate);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || position != null) {
      map['position'] = Variable<String>(position);
    }
    if (!nullToAbsent || arm != null) {
      map['arm'] = Variable<String>(arm);
    }
    if (!nullToAbsent || fatigueLevel != null) {
      map['fatigue_level'] = Variable<double>(fatigueLevel);
    }
    if (!nullToAbsent || symptoms != null) {
      map['symptoms'] = Variable<String>(symptoms);
    }
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['version'] = Variable<int>(version);
    map['synced'] = Variable<bool>(synced);
    return map;
  }

  BPReadingsCompanion toCompanion(bool nullToAbsent) {
    return BPReadingsCompanion(
      id: Value(id),
      clientId: Value(clientId),
      patientId: Value(patientId),
      systolic: Value(systolic),
      diastolic: Value(diastolic),
      heartRate: heartRate == null && nullToAbsent
          ? const Value.absent()
          : Value(heartRate),
      status: Value(status),
      position: position == null && nullToAbsent
          ? const Value.absent()
          : Value(position),
      arm: arm == null && nullToAbsent ? const Value.absent() : Value(arm),
      fatigueLevel: fatigueLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(fatigueLevel),
      symptoms: symptoms == null && nullToAbsent
          ? const Value.absent()
          : Value(symptoms),
      recordedAt: Value(recordedAt),
      createdAt: Value(createdAt),
      version: Value(version),
      synced: Value(synced),
    );
  }

  factory BPReading.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BPReading(
      id: serializer.fromJson<String>(json['id']),
      clientId: serializer.fromJson<String>(json['clientId']),
      patientId: serializer.fromJson<String>(json['patientId']),
      systolic: serializer.fromJson<int>(json['systolic']),
      diastolic: serializer.fromJson<int>(json['diastolic']),
      heartRate: serializer.fromJson<int?>(json['heartRate']),
      status: serializer.fromJson<String>(json['status']),
      position: serializer.fromJson<String?>(json['position']),
      arm: serializer.fromJson<String?>(json['arm']),
      fatigueLevel: serializer.fromJson<double?>(json['fatigueLevel']),
      symptoms: serializer.fromJson<String?>(json['symptoms']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      version: serializer.fromJson<int>(json['version']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'clientId': serializer.toJson<String>(clientId),
      'patientId': serializer.toJson<String>(patientId),
      'systolic': serializer.toJson<int>(systolic),
      'diastolic': serializer.toJson<int>(diastolic),
      'heartRate': serializer.toJson<int?>(heartRate),
      'status': serializer.toJson<String>(status),
      'position': serializer.toJson<String?>(position),
      'arm': serializer.toJson<String?>(arm),
      'fatigueLevel': serializer.toJson<double?>(fatigueLevel),
      'symptoms': serializer.toJson<String?>(symptoms),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'version': serializer.toJson<int>(version),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  BPReading copyWith(
          {String? id,
          String? clientId,
          String? patientId,
          int? systolic,
          int? diastolic,
          Value<int?> heartRate = const Value.absent(),
          String? status,
          Value<String?> position = const Value.absent(),
          Value<String?> arm = const Value.absent(),
          Value<double?> fatigueLevel = const Value.absent(),
          Value<String?> symptoms = const Value.absent(),
          DateTime? recordedAt,
          DateTime? createdAt,
          int? version,
          bool? synced}) =>
      BPReading(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        patientId: patientId ?? this.patientId,
        systolic: systolic ?? this.systolic,
        diastolic: diastolic ?? this.diastolic,
        heartRate: heartRate.present ? heartRate.value : this.heartRate,
        status: status ?? this.status,
        position: position.present ? position.value : this.position,
        arm: arm.present ? arm.value : this.arm,
        fatigueLevel:
            fatigueLevel.present ? fatigueLevel.value : this.fatigueLevel,
        symptoms: symptoms.present ? symptoms.value : this.symptoms,
        recordedAt: recordedAt ?? this.recordedAt,
        createdAt: createdAt ?? this.createdAt,
        version: version ?? this.version,
        synced: synced ?? this.synced,
      );
  BPReading copyWithCompanion(BPReadingsCompanion data) {
    return BPReading(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      systolic: data.systolic.present ? data.systolic.value : this.systolic,
      diastolic: data.diastolic.present ? data.diastolic.value : this.diastolic,
      heartRate: data.heartRate.present ? data.heartRate.value : this.heartRate,
      status: data.status.present ? data.status.value : this.status,
      position: data.position.present ? data.position.value : this.position,
      arm: data.arm.present ? data.arm.value : this.arm,
      fatigueLevel: data.fatigueLevel.present
          ? data.fatigueLevel.value
          : this.fatigueLevel,
      symptoms: data.symptoms.present ? data.symptoms.value : this.symptoms,
      recordedAt:
          data.recordedAt.present ? data.recordedAt.value : this.recordedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      version: data.version.present ? data.version.value : this.version,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BPReading(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('patientId: $patientId, ')
          ..write('systolic: $systolic, ')
          ..write('diastolic: $diastolic, ')
          ..write('heartRate: $heartRate, ')
          ..write('status: $status, ')
          ..write('position: $position, ')
          ..write('arm: $arm, ')
          ..write('fatigueLevel: $fatigueLevel, ')
          ..write('symptoms: $symptoms, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('version: $version, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      clientId,
      patientId,
      systolic,
      diastolic,
      heartRate,
      status,
      position,
      arm,
      fatigueLevel,
      symptoms,
      recordedAt,
      createdAt,
      version,
      synced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BPReading &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.patientId == this.patientId &&
          other.systolic == this.systolic &&
          other.diastolic == this.diastolic &&
          other.heartRate == this.heartRate &&
          other.status == this.status &&
          other.position == this.position &&
          other.arm == this.arm &&
          other.fatigueLevel == this.fatigueLevel &&
          other.symptoms == this.symptoms &&
          other.recordedAt == this.recordedAt &&
          other.createdAt == this.createdAt &&
          other.version == this.version &&
          other.synced == this.synced);
}

class BPReadingsCompanion extends UpdateCompanion<BPReading> {
  final Value<String> id;
  final Value<String> clientId;
  final Value<String> patientId;
  final Value<int> systolic;
  final Value<int> diastolic;
  final Value<int?> heartRate;
  final Value<String> status;
  final Value<String?> position;
  final Value<String?> arm;
  final Value<double?> fatigueLevel;
  final Value<String?> symptoms;
  final Value<DateTime> recordedAt;
  final Value<DateTime> createdAt;
  final Value<int> version;
  final Value<bool> synced;
  final Value<int> rowid;
  const BPReadingsCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.patientId = const Value.absent(),
    this.systolic = const Value.absent(),
    this.diastolic = const Value.absent(),
    this.heartRate = const Value.absent(),
    this.status = const Value.absent(),
    this.position = const Value.absent(),
    this.arm = const Value.absent(),
    this.fatigueLevel = const Value.absent(),
    this.symptoms = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.version = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BPReadingsCompanion.insert({
    required String id,
    required String clientId,
    required String patientId,
    required int systolic,
    required int diastolic,
    this.heartRate = const Value.absent(),
    required String status,
    this.position = const Value.absent(),
    this.arm = const Value.absent(),
    this.fatigueLevel = const Value.absent(),
    this.symptoms = const Value.absent(),
    required DateTime recordedAt,
    this.createdAt = const Value.absent(),
    this.version = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        clientId = Value(clientId),
        patientId = Value(patientId),
        systolic = Value(systolic),
        diastolic = Value(diastolic),
        status = Value(status),
        recordedAt = Value(recordedAt);
  static Insertable<BPReading> custom({
    Expression<String>? id,
    Expression<String>? clientId,
    Expression<String>? patientId,
    Expression<int>? systolic,
    Expression<int>? diastolic,
    Expression<int>? heartRate,
    Expression<String>? status,
    Expression<String>? position,
    Expression<String>? arm,
    Expression<double>? fatigueLevel,
    Expression<String>? symptoms,
    Expression<DateTime>? recordedAt,
    Expression<DateTime>? createdAt,
    Expression<int>? version,
    Expression<bool>? synced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (patientId != null) 'patient_id': patientId,
      if (systolic != null) 'systolic': systolic,
      if (diastolic != null) 'diastolic': diastolic,
      if (heartRate != null) 'heart_rate': heartRate,
      if (status != null) 'status': status,
      if (position != null) 'position': position,
      if (arm != null) 'arm': arm,
      if (fatigueLevel != null) 'fatigue_level': fatigueLevel,
      if (symptoms != null) 'symptoms': symptoms,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (version != null) 'version': version,
      if (synced != null) 'synced': synced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BPReadingsCompanion copyWith(
      {Value<String>? id,
      Value<String>? clientId,
      Value<String>? patientId,
      Value<int>? systolic,
      Value<int>? diastolic,
      Value<int?>? heartRate,
      Value<String>? status,
      Value<String?>? position,
      Value<String?>? arm,
      Value<double?>? fatigueLevel,
      Value<String?>? symptoms,
      Value<DateTime>? recordedAt,
      Value<DateTime>? createdAt,
      Value<int>? version,
      Value<bool>? synced,
      Value<int>? rowid}) {
    return BPReadingsCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      patientId: patientId ?? this.patientId,
      systolic: systolic ?? this.systolic,
      diastolic: diastolic ?? this.diastolic,
      heartRate: heartRate ?? this.heartRate,
      status: status ?? this.status,
      position: position ?? this.position,
      arm: arm ?? this.arm,
      fatigueLevel: fatigueLevel ?? this.fatigueLevel,
      symptoms: symptoms ?? this.symptoms,
      recordedAt: recordedAt ?? this.recordedAt,
      createdAt: createdAt ?? this.createdAt,
      version: version ?? this.version,
      synced: synced ?? this.synced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (systolic.present) {
      map['systolic'] = Variable<int>(systolic.value);
    }
    if (diastolic.present) {
      map['diastolic'] = Variable<int>(diastolic.value);
    }
    if (heartRate.present) {
      map['heart_rate'] = Variable<int>(heartRate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (arm.present) {
      map['arm'] = Variable<String>(arm.value);
    }
    if (fatigueLevel.present) {
      map['fatigue_level'] = Variable<double>(fatigueLevel.value);
    }
    if (symptoms.present) {
      map['symptoms'] = Variable<String>(symptoms.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BPReadingsCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('patientId: $patientId, ')
          ..write('systolic: $systolic, ')
          ..write('diastolic: $diastolic, ')
          ..write('heartRate: $heartRate, ')
          ..write('status: $status, ')
          ..write('position: $position, ')
          ..write('arm: $arm, ')
          ..write('fatigueLevel: $fatigueLevel, ')
          ..write('symptoms: $symptoms, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('version: $version, ')
          ..write('synced: $synced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _opTypeMeta = const VerificationMeta('opType');
  @override
  late final GeneratedColumn<String> opType = GeneratedColumn<String>(
      'op_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityTypeMeta =
      const VerificationMeta('entityType');
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
      'entity_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityIdMeta =
      const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
      'entity_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _clientIdMeta =
      const VerificationMeta('clientId');
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
      'client_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadMeta =
      const VerificationMeta('payload');
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
      'payload', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _attemptsMeta =
      const VerificationMeta('attempts');
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
      'attempts', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _nextAttemptAtMeta =
      const VerificationMeta('nextAttemptAt');
  @override
  late final GeneratedColumn<DateTime> nextAttemptAt =
      GeneratedColumn<DateTime>('next_attempt_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _lastErrorMeta =
      const VerificationMeta('lastError');
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
      'last_error', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        opType,
        entityType,
        entityId,
        clientId,
        payload,
        attempts,
        nextAttemptAt,
        lastError,
        status,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(Insertable<SyncQueueData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('op_type')) {
      context.handle(_opTypeMeta,
          opType.isAcceptableOrUnknown(data['op_type']!, _opTypeMeta));
    } else if (isInserting) {
      context.missing(_opTypeMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
          _entityTypeMeta,
          entityType.isAcceptableOrUnknown(
              data['entity_type']!, _entityTypeMeta));
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('attempts')) {
      context.handle(_attemptsMeta,
          attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta));
    }
    if (data.containsKey('next_attempt_at')) {
      context.handle(
          _nextAttemptAtMeta,
          nextAttemptAt.isAcceptableOrUnknown(
              data['next_attempt_at']!, _nextAttemptAtMeta));
    }
    if (data.containsKey('last_error')) {
      context.handle(_lastErrorMeta,
          lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      opType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}op_type'])!,
      entityType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_type'])!,
      entityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_id'])!,
      clientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}client_id'])!,
      payload: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload'])!,
      attempts: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}attempts'])!,
      nextAttemptAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}next_attempt_at']),
      lastError: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_error']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  final int id;
  final String opType;
  final String entityType;
  final String entityId;
  final String clientId;
  final String payload;
  final int attempts;
  final DateTime? nextAttemptAt;
  final String? lastError;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SyncQueueData(
      {required this.id,
      required this.opType,
      required this.entityType,
      required this.entityId,
      required this.clientId,
      required this.payload,
      required this.attempts,
      this.nextAttemptAt,
      this.lastError,
      required this.status,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['op_type'] = Variable<String>(opType);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['client_id'] = Variable<String>(clientId);
    map['payload'] = Variable<String>(payload);
    map['attempts'] = Variable<int>(attempts);
    if (!nullToAbsent || nextAttemptAt != null) {
      map['next_attempt_at'] = Variable<DateTime>(nextAttemptAt);
    }
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      opType: Value(opType),
      entityType: Value(entityType),
      entityId: Value(entityId),
      clientId: Value(clientId),
      payload: Value(payload),
      attempts: Value(attempts),
      nextAttemptAt: nextAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(nextAttemptAt),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SyncQueueData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<int>(json['id']),
      opType: serializer.fromJson<String>(json['opType']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      clientId: serializer.fromJson<String>(json['clientId']),
      payload: serializer.fromJson<String>(json['payload']),
      attempts: serializer.fromJson<int>(json['attempts']),
      nextAttemptAt: serializer.fromJson<DateTime?>(json['nextAttemptAt']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'opType': serializer.toJson<String>(opType),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'clientId': serializer.toJson<String>(clientId),
      'payload': serializer.toJson<String>(payload),
      'attempts': serializer.toJson<int>(attempts),
      'nextAttemptAt': serializer.toJson<DateTime?>(nextAttemptAt),
      'lastError': serializer.toJson<String?>(lastError),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SyncQueueData copyWith(
          {int? id,
          String? opType,
          String? entityType,
          String? entityId,
          String? clientId,
          String? payload,
          int? attempts,
          Value<DateTime?> nextAttemptAt = const Value.absent(),
          Value<String?> lastError = const Value.absent(),
          String? status,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      SyncQueueData(
        id: id ?? this.id,
        opType: opType ?? this.opType,
        entityType: entityType ?? this.entityType,
        entityId: entityId ?? this.entityId,
        clientId: clientId ?? this.clientId,
        payload: payload ?? this.payload,
        attempts: attempts ?? this.attempts,
        nextAttemptAt:
            nextAttemptAt.present ? nextAttemptAt.value : this.nextAttemptAt,
        lastError: lastError.present ? lastError.value : this.lastError,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      opType: data.opType.present ? data.opType.value : this.opType,
      entityType:
          data.entityType.present ? data.entityType.value : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      payload: data.payload.present ? data.payload.value : this.payload,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      nextAttemptAt: data.nextAttemptAt.present
          ? data.nextAttemptAt.value
          : this.nextAttemptAt,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('id: $id, ')
          ..write('opType: $opType, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('clientId: $clientId, ')
          ..write('payload: $payload, ')
          ..write('attempts: $attempts, ')
          ..write('nextAttemptAt: $nextAttemptAt, ')
          ..write('lastError: $lastError, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      opType,
      entityType,
      entityId,
      clientId,
      payload,
      attempts,
      nextAttemptAt,
      lastError,
      status,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.id == this.id &&
          other.opType == this.opType &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.clientId == this.clientId &&
          other.payload == this.payload &&
          other.attempts == this.attempts &&
          other.nextAttemptAt == this.nextAttemptAt &&
          other.lastError == this.lastError &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<int> id;
  final Value<String> opType;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> clientId;
  final Value<String> payload;
  final Value<int> attempts;
  final Value<DateTime?> nextAttemptAt;
  final Value<String?> lastError;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.opType = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.payload = const Value.absent(),
    this.attempts = const Value.absent(),
    this.nextAttemptAt = const Value.absent(),
    this.lastError = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    this.id = const Value.absent(),
    required String opType,
    required String entityType,
    required String entityId,
    required String clientId,
    required String payload,
    this.attempts = const Value.absent(),
    this.nextAttemptAt = const Value.absent(),
    this.lastError = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : opType = Value(opType),
        entityType = Value(entityType),
        entityId = Value(entityId),
        clientId = Value(clientId),
        payload = Value(payload);
  static Insertable<SyncQueueData> custom({
    Expression<int>? id,
    Expression<String>? opType,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? clientId,
    Expression<String>? payload,
    Expression<int>? attempts,
    Expression<DateTime>? nextAttemptAt,
    Expression<String>? lastError,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (opType != null) 'op_type': opType,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (clientId != null) 'client_id': clientId,
      if (payload != null) 'payload': payload,
      if (attempts != null) 'attempts': attempts,
      if (nextAttemptAt != null) 'next_attempt_at': nextAttemptAt,
      if (lastError != null) 'last_error': lastError,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SyncQueueCompanion copyWith(
      {Value<int>? id,
      Value<String>? opType,
      Value<String>? entityType,
      Value<String>? entityId,
      Value<String>? clientId,
      Value<String>? payload,
      Value<int>? attempts,
      Value<DateTime?>? nextAttemptAt,
      Value<String?>? lastError,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      opType: opType ?? this.opType,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      clientId: clientId ?? this.clientId,
      payload: payload ?? this.payload,
      attempts: attempts ?? this.attempts,
      nextAttemptAt: nextAttemptAt ?? this.nextAttemptAt,
      lastError: lastError ?? this.lastError,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (opType.present) {
      map['op_type'] = Variable<String>(opType.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (nextAttemptAt.present) {
      map['next_attempt_at'] = Variable<DateTime>(nextAttemptAt.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('opType: $opType, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('clientId: $clientId, ')
          ..write('payload: $payload, ')
          ..write('attempts: $attempts, ')
          ..write('nextAttemptAt: $nextAttemptAt, ')
          ..write('lastError: $lastError, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AIRecommendationsTable extends AIRecommendations
    with TableInfo<$AIRecommendationsTable, AIRecommendation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AIRecommendationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _patientIdMeta =
      const VerificationMeta('patientId');
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
      'patient_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
      'priority', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _confidenceMeta =
      const VerificationMeta('confidence');
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
      'confidence', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _triggersMeta =
      const VerificationMeta('triggers');
  @override
  late final GeneratedColumn<String> triggers = GeneratedColumn<String>(
      'triggers', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _relatedVitalsMeta =
      const VerificationMeta('relatedVitals');
  @override
  late final GeneratedColumn<String> relatedVitals = GeneratedColumn<String>(
      'related_vitals', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _validUntilMeta =
      const VerificationMeta('validUntil');
  @override
  late final GeneratedColumn<DateTime> validUntil = GeneratedColumn<DateTime>(
      'valid_until', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _versionMeta =
      const VerificationMeta('version');
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
      'version', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _acknowledgedMeta =
      const VerificationMeta('acknowledged');
  @override
  late final GeneratedColumn<bool> acknowledged = GeneratedColumn<bool>(
      'acknowledged', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("acknowledged" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        patientId,
        type,
        title,
        content,
        priority,
        confidence,
        triggers,
        relatedVitals,
        validUntil,
        createdAt,
        version,
        synced,
        acknowledged
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'a_i_recommendations';
  @override
  VerificationContext validateIntegrity(Insertable<AIRecommendation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(_patientIdMeta,
          patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta));
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(
          _confidenceMeta,
          confidence.isAcceptableOrUnknown(
              data['confidence']!, _confidenceMeta));
    } else if (isInserting) {
      context.missing(_confidenceMeta);
    }
    if (data.containsKey('triggers')) {
      context.handle(_triggersMeta,
          triggers.isAcceptableOrUnknown(data['triggers']!, _triggersMeta));
    }
    if (data.containsKey('related_vitals')) {
      context.handle(
          _relatedVitalsMeta,
          relatedVitals.isAcceptableOrUnknown(
              data['related_vitals']!, _relatedVitalsMeta));
    }
    if (data.containsKey('valid_until')) {
      context.handle(
          _validUntilMeta,
          validUntil.isAcceptableOrUnknown(
              data['valid_until']!, _validUntilMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('version')) {
      context.handle(_versionMeta,
          version.isAcceptableOrUnknown(data['version']!, _versionMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    if (data.containsKey('acknowledged')) {
      context.handle(
          _acknowledgedMeta,
          acknowledged.isAcceptableOrUnknown(
              data['acknowledged']!, _acknowledgedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AIRecommendation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AIRecommendation(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      patientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}patient_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}priority'])!,
      confidence: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}confidence'])!,
      triggers: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}triggers']),
      relatedVitals: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}related_vitals']),
      validUntil: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}valid_until']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      version: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}version'])!,
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
      acknowledged: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}acknowledged'])!,
    );
  }

  @override
  $AIRecommendationsTable createAlias(String alias) {
    return $AIRecommendationsTable(attachedDatabase, alias);
  }
}

class AIRecommendation extends DataClass
    implements Insertable<AIRecommendation> {
  final String id;
  final String patientId;
  final String type;
  final String title;
  final String content;
  final String priority;
  final double confidence;
  final String? triggers;
  final String? relatedVitals;
  final DateTime? validUntil;
  final DateTime createdAt;
  final int version;
  final bool synced;
  final bool acknowledged;
  const AIRecommendation(
      {required this.id,
      required this.patientId,
      required this.type,
      required this.title,
      required this.content,
      required this.priority,
      required this.confidence,
      this.triggers,
      this.relatedVitals,
      this.validUntil,
      required this.createdAt,
      required this.version,
      required this.synced,
      required this.acknowledged});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    map['type'] = Variable<String>(type);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    map['priority'] = Variable<String>(priority);
    map['confidence'] = Variable<double>(confidence);
    if (!nullToAbsent || triggers != null) {
      map['triggers'] = Variable<String>(triggers);
    }
    if (!nullToAbsent || relatedVitals != null) {
      map['related_vitals'] = Variable<String>(relatedVitals);
    }
    if (!nullToAbsent || validUntil != null) {
      map['valid_until'] = Variable<DateTime>(validUntil);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['version'] = Variable<int>(version);
    map['synced'] = Variable<bool>(synced);
    map['acknowledged'] = Variable<bool>(acknowledged);
    return map;
  }

  AIRecommendationsCompanion toCompanion(bool nullToAbsent) {
    return AIRecommendationsCompanion(
      id: Value(id),
      patientId: Value(patientId),
      type: Value(type),
      title: Value(title),
      content: Value(content),
      priority: Value(priority),
      confidence: Value(confidence),
      triggers: triggers == null && nullToAbsent
          ? const Value.absent()
          : Value(triggers),
      relatedVitals: relatedVitals == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedVitals),
      validUntil: validUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(validUntil),
      createdAt: Value(createdAt),
      version: Value(version),
      synced: Value(synced),
      acknowledged: Value(acknowledged),
    );
  }

  factory AIRecommendation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AIRecommendation(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      type: serializer.fromJson<String>(json['type']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      priority: serializer.fromJson<String>(json['priority']),
      confidence: serializer.fromJson<double>(json['confidence']),
      triggers: serializer.fromJson<String?>(json['triggers']),
      relatedVitals: serializer.fromJson<String?>(json['relatedVitals']),
      validUntil: serializer.fromJson<DateTime?>(json['validUntil']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      version: serializer.fromJson<int>(json['version']),
      synced: serializer.fromJson<bool>(json['synced']),
      acknowledged: serializer.fromJson<bool>(json['acknowledged']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'type': serializer.toJson<String>(type),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'priority': serializer.toJson<String>(priority),
      'confidence': serializer.toJson<double>(confidence),
      'triggers': serializer.toJson<String?>(triggers),
      'relatedVitals': serializer.toJson<String?>(relatedVitals),
      'validUntil': serializer.toJson<DateTime?>(validUntil),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'version': serializer.toJson<int>(version),
      'synced': serializer.toJson<bool>(synced),
      'acknowledged': serializer.toJson<bool>(acknowledged),
    };
  }

  AIRecommendation copyWith(
          {String? id,
          String? patientId,
          String? type,
          String? title,
          String? content,
          String? priority,
          double? confidence,
          Value<String?> triggers = const Value.absent(),
          Value<String?> relatedVitals = const Value.absent(),
          Value<DateTime?> validUntil = const Value.absent(),
          DateTime? createdAt,
          int? version,
          bool? synced,
          bool? acknowledged}) =>
      AIRecommendation(
        id: id ?? this.id,
        patientId: patientId ?? this.patientId,
        type: type ?? this.type,
        title: title ?? this.title,
        content: content ?? this.content,
        priority: priority ?? this.priority,
        confidence: confidence ?? this.confidence,
        triggers: triggers.present ? triggers.value : this.triggers,
        relatedVitals:
            relatedVitals.present ? relatedVitals.value : this.relatedVitals,
        validUntil: validUntil.present ? validUntil.value : this.validUntil,
        createdAt: createdAt ?? this.createdAt,
        version: version ?? this.version,
        synced: synced ?? this.synced,
        acknowledged: acknowledged ?? this.acknowledged,
      );
  AIRecommendation copyWithCompanion(AIRecommendationsCompanion data) {
    return AIRecommendation(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      type: data.type.present ? data.type.value : this.type,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      priority: data.priority.present ? data.priority.value : this.priority,
      confidence:
          data.confidence.present ? data.confidence.value : this.confidence,
      triggers: data.triggers.present ? data.triggers.value : this.triggers,
      relatedVitals: data.relatedVitals.present
          ? data.relatedVitals.value
          : this.relatedVitals,
      validUntil:
          data.validUntil.present ? data.validUntil.value : this.validUntil,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      version: data.version.present ? data.version.value : this.version,
      synced: data.synced.present ? data.synced.value : this.synced,
      acknowledged: data.acknowledged.present
          ? data.acknowledged.value
          : this.acknowledged,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AIRecommendation(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('priority: $priority, ')
          ..write('confidence: $confidence, ')
          ..write('triggers: $triggers, ')
          ..write('relatedVitals: $relatedVitals, ')
          ..write('validUntil: $validUntil, ')
          ..write('createdAt: $createdAt, ')
          ..write('version: $version, ')
          ..write('synced: $synced, ')
          ..write('acknowledged: $acknowledged')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      patientId,
      type,
      title,
      content,
      priority,
      confidence,
      triggers,
      relatedVitals,
      validUntil,
      createdAt,
      version,
      synced,
      acknowledged);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AIRecommendation &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.type == this.type &&
          other.title == this.title &&
          other.content == this.content &&
          other.priority == this.priority &&
          other.confidence == this.confidence &&
          other.triggers == this.triggers &&
          other.relatedVitals == this.relatedVitals &&
          other.validUntil == this.validUntil &&
          other.createdAt == this.createdAt &&
          other.version == this.version &&
          other.synced == this.synced &&
          other.acknowledged == this.acknowledged);
}

class AIRecommendationsCompanion extends UpdateCompanion<AIRecommendation> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<String> type;
  final Value<String> title;
  final Value<String> content;
  final Value<String> priority;
  final Value<double> confidence;
  final Value<String?> triggers;
  final Value<String?> relatedVitals;
  final Value<DateTime?> validUntil;
  final Value<DateTime> createdAt;
  final Value<int> version;
  final Value<bool> synced;
  final Value<bool> acknowledged;
  final Value<int> rowid;
  const AIRecommendationsCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.priority = const Value.absent(),
    this.confidence = const Value.absent(),
    this.triggers = const Value.absent(),
    this.relatedVitals = const Value.absent(),
    this.validUntil = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.version = const Value.absent(),
    this.synced = const Value.absent(),
    this.acknowledged = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AIRecommendationsCompanion.insert({
    required String id,
    required String patientId,
    required String type,
    required String title,
    required String content,
    required String priority,
    required double confidence,
    this.triggers = const Value.absent(),
    this.relatedVitals = const Value.absent(),
    this.validUntil = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.version = const Value.absent(),
    this.synced = const Value.absent(),
    this.acknowledged = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        patientId = Value(patientId),
        type = Value(type),
        title = Value(title),
        content = Value(content),
        priority = Value(priority),
        confidence = Value(confidence);
  static Insertable<AIRecommendation> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<String>? type,
    Expression<String>? title,
    Expression<String>? content,
    Expression<String>? priority,
    Expression<double>? confidence,
    Expression<String>? triggers,
    Expression<String>? relatedVitals,
    Expression<DateTime>? validUntil,
    Expression<DateTime>? createdAt,
    Expression<int>? version,
    Expression<bool>? synced,
    Expression<bool>? acknowledged,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (priority != null) 'priority': priority,
      if (confidence != null) 'confidence': confidence,
      if (triggers != null) 'triggers': triggers,
      if (relatedVitals != null) 'related_vitals': relatedVitals,
      if (validUntil != null) 'valid_until': validUntil,
      if (createdAt != null) 'created_at': createdAt,
      if (version != null) 'version': version,
      if (synced != null) 'synced': synced,
      if (acknowledged != null) 'acknowledged': acknowledged,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AIRecommendationsCompanion copyWith(
      {Value<String>? id,
      Value<String>? patientId,
      Value<String>? type,
      Value<String>? title,
      Value<String>? content,
      Value<String>? priority,
      Value<double>? confidence,
      Value<String?>? triggers,
      Value<String?>? relatedVitals,
      Value<DateTime?>? validUntil,
      Value<DateTime>? createdAt,
      Value<int>? version,
      Value<bool>? synced,
      Value<bool>? acknowledged,
      Value<int>? rowid}) {
    return AIRecommendationsCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      type: type ?? this.type,
      title: title ?? this.title,
      content: content ?? this.content,
      priority: priority ?? this.priority,
      confidence: confidence ?? this.confidence,
      triggers: triggers ?? this.triggers,
      relatedVitals: relatedVitals ?? this.relatedVitals,
      validUntil: validUntil ?? this.validUntil,
      createdAt: createdAt ?? this.createdAt,
      version: version ?? this.version,
      synced: synced ?? this.synced,
      acknowledged: acknowledged ?? this.acknowledged,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (triggers.present) {
      map['triggers'] = Variable<String>(triggers.value);
    }
    if (relatedVitals.present) {
      map['related_vitals'] = Variable<String>(relatedVitals.value);
    }
    if (validUntil.present) {
      map['valid_until'] = Variable<DateTime>(validUntil.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (acknowledged.present) {
      map['acknowledged'] = Variable<bool>(acknowledged.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AIRecommendationsCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('priority: $priority, ')
          ..write('confidence: $confidence, ')
          ..write('triggers: $triggers, ')
          ..write('relatedVitals: $relatedVitals, ')
          ..write('validUntil: $validUntil, ')
          ..write('createdAt: $createdAt, ')
          ..write('version: $version, ')
          ..write('synced: $synced, ')
          ..write('acknowledged: $acknowledged, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$DgtlDatabase extends GeneratedDatabase {
  _$DgtlDatabase(QueryExecutor e) : super(e);
  $DgtlDatabaseManager get managers => $DgtlDatabaseManager(this);
  late final $MedicalKnowledgeBaseTable medicalKnowledgeBase =
      $MedicalKnowledgeBaseTable(this);
  late final $PatientsTable patients = $PatientsTable(this);
  late final $ClinicalAssessmentsTable clinicalAssessments =
      $ClinicalAssessmentsTable(this);
  late final $LabResultsTable labResults = $LabResultsTable(this);
  late final $SymptomsTable symptoms = $SymptomsTable(this);
  late final $MedicationsTable medications = $MedicationsTable(this);
  late final $RagQueryCacheTable ragQueryCache = $RagQueryCacheTable(this);
  late final $VitalsTable vitals = $VitalsTable(this);
  late final $BPReadingsTable bPReadings = $BPReadingsTable(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  late final $AIRecommendationsTable aIRecommendations =
      $AIRecommendationsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        medicalKnowledgeBase,
        patients,
        clinicalAssessments,
        labResults,
        symptoms,
        medications,
        ragQueryCache,
        vitals,
        bPReadings,
        syncQueue,
        aIRecommendations
      ];
}

typedef $$MedicalKnowledgeBaseTableCreateCompanionBuilder
    = MedicalKnowledgeBaseCompanion Function({
  Value<int> id,
  required String content,
  required String source,
  required String category,
  required String embedding,
  Value<double> confidence,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$MedicalKnowledgeBaseTableUpdateCompanionBuilder
    = MedicalKnowledgeBaseCompanion Function({
  Value<int> id,
  Value<String> content,
  Value<String> source,
  Value<String> category,
  Value<String> embedding,
  Value<double> confidence,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$MedicalKnowledgeBaseTableFilterComposer
    extends Composer<_$DgtlDatabase, $MedicalKnowledgeBaseTable> {
  $$MedicalKnowledgeBaseTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get embedding => $composableBuilder(
      column: $table.embedding, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get confidence => $composableBuilder(
      column: $table.confidence, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$MedicalKnowledgeBaseTableOrderingComposer
    extends Composer<_$DgtlDatabase, $MedicalKnowledgeBaseTable> {
  $$MedicalKnowledgeBaseTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get embedding => $composableBuilder(
      column: $table.embedding, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get confidence => $composableBuilder(
      column: $table.confidence, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$MedicalKnowledgeBaseTableAnnotationComposer
    extends Composer<_$DgtlDatabase, $MedicalKnowledgeBaseTable> {
  $$MedicalKnowledgeBaseTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get embedding =>
      $composableBuilder(column: $table.embedding, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
      column: $table.confidence, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MedicalKnowledgeBaseTableTableManager extends RootTableManager<
    _$DgtlDatabase,
    $MedicalKnowledgeBaseTable,
    MedicalKnowledgeBaseData,
    $$MedicalKnowledgeBaseTableFilterComposer,
    $$MedicalKnowledgeBaseTableOrderingComposer,
    $$MedicalKnowledgeBaseTableAnnotationComposer,
    $$MedicalKnowledgeBaseTableCreateCompanionBuilder,
    $$MedicalKnowledgeBaseTableUpdateCompanionBuilder,
    (
      MedicalKnowledgeBaseData,
      BaseReferences<_$DgtlDatabase, $MedicalKnowledgeBaseTable,
          MedicalKnowledgeBaseData>
    ),
    MedicalKnowledgeBaseData,
    PrefetchHooks Function()> {
  $$MedicalKnowledgeBaseTableTableManager(
      _$DgtlDatabase db, $MedicalKnowledgeBaseTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MedicalKnowledgeBaseTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MedicalKnowledgeBaseTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MedicalKnowledgeBaseTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> embedding = const Value.absent(),
            Value<double> confidence = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              MedicalKnowledgeBaseCompanion(
            id: id,
            content: content,
            source: source,
            category: category,
            embedding: embedding,
            confidence: confidence,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String content,
            required String source,
            required String category,
            required String embedding,
            Value<double> confidence = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              MedicalKnowledgeBaseCompanion.insert(
            id: id,
            content: content,
            source: source,
            category: category,
            embedding: embedding,
            confidence: confidence,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MedicalKnowledgeBaseTableProcessedTableManager
    = ProcessedTableManager<
        _$DgtlDatabase,
        $MedicalKnowledgeBaseTable,
        MedicalKnowledgeBaseData,
        $$MedicalKnowledgeBaseTableFilterComposer,
        $$MedicalKnowledgeBaseTableOrderingComposer,
        $$MedicalKnowledgeBaseTableAnnotationComposer,
        $$MedicalKnowledgeBaseTableCreateCompanionBuilder,
        $$MedicalKnowledgeBaseTableUpdateCompanionBuilder,
        (
          MedicalKnowledgeBaseData,
          BaseReferences<_$DgtlDatabase, $MedicalKnowledgeBaseTable,
              MedicalKnowledgeBaseData>
        ),
        MedicalKnowledgeBaseData,
        PrefetchHooks Function()>;
typedef $$PatientsTableCreateCompanionBuilder = PatientsCompanion Function({
  Value<int> id,
  required String encryptedFirstName,
  required String encryptedLastName,
  Value<String?> encryptedDateOfBirth,
  Value<String?> gender,
  Value<String?> encryptedNotes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$PatientsTableUpdateCompanionBuilder = PatientsCompanion Function({
  Value<int> id,
  Value<String> encryptedFirstName,
  Value<String> encryptedLastName,
  Value<String?> encryptedDateOfBirth,
  Value<String?> gender,
  Value<String?> encryptedNotes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$PatientsTableReferences
    extends BaseReferences<_$DgtlDatabase, $PatientsTable, Patient> {
  $$PatientsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ClinicalAssessmentsTable,
      List<ClinicalAssessment>> _clinicalAssessmentsRefsTable(
          _$DgtlDatabase db) =>
      MultiTypedResultKey.fromTable(db.clinicalAssessments,
          aliasName: $_aliasNameGenerator(
              db.patients.id, db.clinicalAssessments.patientId));

  $$ClinicalAssessmentsTableProcessedTableManager get clinicalAssessmentsRefs {
    final manager =
        $$ClinicalAssessmentsTableTableManager($_db, $_db.clinicalAssessments)
            .filter((f) => f.patientId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_clinicalAssessmentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$LabResultsTable, List<LabResult>>
      _labResultsRefsTable(_$DgtlDatabase db) => MultiTypedResultKey.fromTable(
          db.labResults,
          aliasName:
              $_aliasNameGenerator(db.patients.id, db.labResults.patientId));

  $$LabResultsTableProcessedTableManager get labResultsRefs {
    final manager = $$LabResultsTableTableManager($_db, $_db.labResults)
        .filter((f) => f.patientId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_labResultsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SymptomsTable, List<Symptom>> _symptomsRefsTable(
          _$DgtlDatabase db) =>
      MultiTypedResultKey.fromTable(db.symptoms,
          aliasName:
              $_aliasNameGenerator(db.patients.id, db.symptoms.patientId));

  $$SymptomsTableProcessedTableManager get symptomsRefs {
    final manager = $$SymptomsTableTableManager($_db, $_db.symptoms)
        .filter((f) => f.patientId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_symptomsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MedicationsTable, List<Medication>>
      _medicationsRefsTable(_$DgtlDatabase db) => MultiTypedResultKey.fromTable(
          db.medications,
          aliasName:
              $_aliasNameGenerator(db.patients.id, db.medications.patientId));

  $$MedicationsTableProcessedTableManager get medicationsRefs {
    final manager = $$MedicationsTableTableManager($_db, $_db.medications)
        .filter((f) => f.patientId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_medicationsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PatientsTableFilterComposer
    extends Composer<_$DgtlDatabase, $PatientsTable> {
  $$PatientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get encryptedFirstName => $composableBuilder(
      column: $table.encryptedFirstName,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get encryptedLastName => $composableBuilder(
      column: $table.encryptedLastName,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get encryptedDateOfBirth => $composableBuilder(
      column: $table.encryptedDateOfBirth,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get encryptedNotes => $composableBuilder(
      column: $table.encryptedNotes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> clinicalAssessmentsRefs(
      Expression<bool> Function($$ClinicalAssessmentsTableFilterComposer f) f) {
    final $$ClinicalAssessmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.clinicalAssessments,
        getReferencedColumn: (t) => t.patientId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClinicalAssessmentsTableFilterComposer(
              $db: $db,
              $table: $db.clinicalAssessments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> labResultsRefs(
      Expression<bool> Function($$LabResultsTableFilterComposer f) f) {
    final $$LabResultsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.labResults,
        getReferencedColumn: (t) => t.patientId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LabResultsTableFilterComposer(
              $db: $db,
              $table: $db.labResults,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> symptomsRefs(
      Expression<bool> Function($$SymptomsTableFilterComposer f) f) {
    final $$SymptomsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.symptoms,
        getReferencedColumn: (t) => t.patientId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SymptomsTableFilterComposer(
              $db: $db,
              $table: $db.symptoms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> medicationsRefs(
      Expression<bool> Function($$MedicationsTableFilterComposer f) f) {
    final $$MedicationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.medications,
        getReferencedColumn: (t) => t.patientId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MedicationsTableFilterComposer(
              $db: $db,
              $table: $db.medications,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PatientsTableOrderingComposer
    extends Composer<_$DgtlDatabase, $PatientsTable> {
  $$PatientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get encryptedFirstName => $composableBuilder(
      column: $table.encryptedFirstName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get encryptedLastName => $composableBuilder(
      column: $table.encryptedLastName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get encryptedDateOfBirth => $composableBuilder(
      column: $table.encryptedDateOfBirth,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get encryptedNotes => $composableBuilder(
      column: $table.encryptedNotes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$PatientsTableAnnotationComposer
    extends Composer<_$DgtlDatabase, $PatientsTable> {
  $$PatientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get encryptedFirstName => $composableBuilder(
      column: $table.encryptedFirstName, builder: (column) => column);

  GeneratedColumn<String> get encryptedLastName => $composableBuilder(
      column: $table.encryptedLastName, builder: (column) => column);

  GeneratedColumn<String> get encryptedDateOfBirth => $composableBuilder(
      column: $table.encryptedDateOfBirth, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get encryptedNotes => $composableBuilder(
      column: $table.encryptedNotes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> clinicalAssessmentsRefs<T extends Object>(
      Expression<T> Function($$ClinicalAssessmentsTableAnnotationComposer a)
          f) {
    final $$ClinicalAssessmentsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.clinicalAssessments,
            getReferencedColumn: (t) => t.patientId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ClinicalAssessmentsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.clinicalAssessments,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> labResultsRefs<T extends Object>(
      Expression<T> Function($$LabResultsTableAnnotationComposer a) f) {
    final $$LabResultsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.labResults,
        getReferencedColumn: (t) => t.patientId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LabResultsTableAnnotationComposer(
              $db: $db,
              $table: $db.labResults,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> symptomsRefs<T extends Object>(
      Expression<T> Function($$SymptomsTableAnnotationComposer a) f) {
    final $$SymptomsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.symptoms,
        getReferencedColumn: (t) => t.patientId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SymptomsTableAnnotationComposer(
              $db: $db,
              $table: $db.symptoms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> medicationsRefs<T extends Object>(
      Expression<T> Function($$MedicationsTableAnnotationComposer a) f) {
    final $$MedicationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.medications,
        getReferencedColumn: (t) => t.patientId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MedicationsTableAnnotationComposer(
              $db: $db,
              $table: $db.medications,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PatientsTableTableManager extends RootTableManager<
    _$DgtlDatabase,
    $PatientsTable,
    Patient,
    $$PatientsTableFilterComposer,
    $$PatientsTableOrderingComposer,
    $$PatientsTableAnnotationComposer,
    $$PatientsTableCreateCompanionBuilder,
    $$PatientsTableUpdateCompanionBuilder,
    (Patient, $$PatientsTableReferences),
    Patient,
    PrefetchHooks Function(
        {bool clinicalAssessmentsRefs,
        bool labResultsRefs,
        bool symptomsRefs,
        bool medicationsRefs})> {
  $$PatientsTableTableManager(_$DgtlDatabase db, $PatientsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PatientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PatientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PatientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> encryptedFirstName = const Value.absent(),
            Value<String> encryptedLastName = const Value.absent(),
            Value<String?> encryptedDateOfBirth = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<String?> encryptedNotes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              PatientsCompanion(
            id: id,
            encryptedFirstName: encryptedFirstName,
            encryptedLastName: encryptedLastName,
            encryptedDateOfBirth: encryptedDateOfBirth,
            gender: gender,
            encryptedNotes: encryptedNotes,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String encryptedFirstName,
            required String encryptedLastName,
            Value<String?> encryptedDateOfBirth = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<String?> encryptedNotes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              PatientsCompanion.insert(
            id: id,
            encryptedFirstName: encryptedFirstName,
            encryptedLastName: encryptedLastName,
            encryptedDateOfBirth: encryptedDateOfBirth,
            gender: gender,
            encryptedNotes: encryptedNotes,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PatientsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {clinicalAssessmentsRefs = false,
              labResultsRefs = false,
              symptomsRefs = false,
              medicationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (clinicalAssessmentsRefs) db.clinicalAssessments,
                if (labResultsRefs) db.labResults,
                if (symptomsRefs) db.symptoms,
                if (medicationsRefs) db.medications
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (clinicalAssessmentsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$PatientsTableReferences
                            ._clinicalAssessmentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PatientsTableReferences(db, table, p0)
                                .clinicalAssessmentsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.patientId == item.id),
                        typedResults: items),
                  if (labResultsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$PatientsTableReferences._labResultsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PatientsTableReferences(db, table, p0)
                                .labResultsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.patientId == item.id),
                        typedResults: items),
                  if (symptomsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$PatientsTableReferences._symptomsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PatientsTableReferences(db, table, p0)
                                .symptomsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.patientId == item.id),
                        typedResults: items),
                  if (medicationsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$PatientsTableReferences._medicationsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PatientsTableReferences(db, table, p0)
                                .medicationsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.patientId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PatientsTableProcessedTableManager = ProcessedTableManager<
    _$DgtlDatabase,
    $PatientsTable,
    Patient,
    $$PatientsTableFilterComposer,
    $$PatientsTableOrderingComposer,
    $$PatientsTableAnnotationComposer,
    $$PatientsTableCreateCompanionBuilder,
    $$PatientsTableUpdateCompanionBuilder,
    (Patient, $$PatientsTableReferences),
    Patient,
    PrefetchHooks Function(
        {bool clinicalAssessmentsRefs,
        bool labResultsRefs,
        bool symptomsRefs,
        bool medicationsRefs})>;
typedef $$ClinicalAssessmentsTableCreateCompanionBuilder
    = ClinicalAssessmentsCompanion Function({
  Value<int> id,
  required int patientId,
  required String assessmentType,
  required String ragContext,
  required String aiRecommendations,
  required String clinicalFindings,
  required double confidenceScore,
  Value<DateTime> createdAt,
});
typedef $$ClinicalAssessmentsTableUpdateCompanionBuilder
    = ClinicalAssessmentsCompanion Function({
  Value<int> id,
  Value<int> patientId,
  Value<String> assessmentType,
  Value<String> ragContext,
  Value<String> aiRecommendations,
  Value<String> clinicalFindings,
  Value<double> confidenceScore,
  Value<DateTime> createdAt,
});

final class $$ClinicalAssessmentsTableReferences extends BaseReferences<
    _$DgtlDatabase, $ClinicalAssessmentsTable, ClinicalAssessment> {
  $$ClinicalAssessmentsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PatientsTable _patientIdTable(_$DgtlDatabase db) =>
      db.patients.createAlias($_aliasNameGenerator(
          db.clinicalAssessments.patientId, db.patients.id));

  $$PatientsTableProcessedTableManager? get patientId {
    if ($_item.patientId == null) return null;
    final manager = $$PatientsTableTableManager($_db, $_db.patients)
        .filter((f) => f.id($_item.patientId!));
    final item = $_typedResult.readTableOrNull(_patientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ClinicalAssessmentsTableFilterComposer
    extends Composer<_$DgtlDatabase, $ClinicalAssessmentsTable> {
  $$ClinicalAssessmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get assessmentType => $composableBuilder(
      column: $table.assessmentType,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ragContext => $composableBuilder(
      column: $table.ragContext, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get aiRecommendations => $composableBuilder(
      column: $table.aiRecommendations,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get clinicalFindings => $composableBuilder(
      column: $table.clinicalFindings,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get confidenceScore => $composableBuilder(
      column: $table.confidenceScore,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$PatientsTableFilterComposer get patientId {
    final $$PatientsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.patientId,
        referencedTable: $db.patients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PatientsTableFilterComposer(
              $db: $db,
              $table: $db.patients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ClinicalAssessmentsTableOrderingComposer
    extends Composer<_$DgtlDatabase, $ClinicalAssessmentsTable> {
  $$ClinicalAssessmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get assessmentType => $composableBuilder(
      column: $table.assessmentType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ragContext => $composableBuilder(
      column: $table.ragContext, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get aiRecommendations => $composableBuilder(
      column: $table.aiRecommendations,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get clinicalFindings => $composableBuilder(
      column: $table.clinicalFindings,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get confidenceScore => $composableBuilder(
      column: $table.confidenceScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$PatientsTableOrderingComposer get patientId {
    final $$PatientsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.patientId,
        referencedTable: $db.patients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PatientsTableOrderingComposer(
              $db: $db,
              $table: $db.patients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ClinicalAssessmentsTableAnnotationComposer
    extends Composer<_$DgtlDatabase, $ClinicalAssessmentsTable> {
  $$ClinicalAssessmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get assessmentType => $composableBuilder(
      column: $table.assessmentType, builder: (column) => column);

  GeneratedColumn<String> get ragContext => $composableBuilder(
      column: $table.ragContext, builder: (column) => column);

  GeneratedColumn<String> get aiRecommendations => $composableBuilder(
      column: $table.aiRecommendations, builder: (column) => column);

  GeneratedColumn<String> get clinicalFindings => $composableBuilder(
      column: $table.clinicalFindings, builder: (column) => column);

  GeneratedColumn<double> get confidenceScore => $composableBuilder(
      column: $table.confidenceScore, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PatientsTableAnnotationComposer get patientId {
    final $$PatientsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.patientId,
        referencedTable: $db.patients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PatientsTableAnnotationComposer(
              $db: $db,
              $table: $db.patients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ClinicalAssessmentsTableTableManager extends RootTableManager<
    _$DgtlDatabase,
    $ClinicalAssessmentsTable,
    ClinicalAssessment,
    $$ClinicalAssessmentsTableFilterComposer,
    $$ClinicalAssessmentsTableOrderingComposer,
    $$ClinicalAssessmentsTableAnnotationComposer,
    $$ClinicalAssessmentsTableCreateCompanionBuilder,
    $$ClinicalAssessmentsTableUpdateCompanionBuilder,
    (ClinicalAssessment, $$ClinicalAssessmentsTableReferences),
    ClinicalAssessment,
    PrefetchHooks Function({bool patientId})> {
  $$ClinicalAssessmentsTableTableManager(
      _$DgtlDatabase db, $ClinicalAssessmentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClinicalAssessmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClinicalAssessmentsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClinicalAssessmentsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> patientId = const Value.absent(),
            Value<String> assessmentType = const Value.absent(),
            Value<String> ragContext = const Value.absent(),
            Value<String> aiRecommendations = const Value.absent(),
            Value<String> clinicalFindings = const Value.absent(),
            Value<double> confidenceScore = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ClinicalAssessmentsCompanion(
            id: id,
            patientId: patientId,
            assessmentType: assessmentType,
            ragContext: ragContext,
            aiRecommendations: aiRecommendations,
            clinicalFindings: clinicalFindings,
            confidenceScore: confidenceScore,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int patientId,
            required String assessmentType,
            required String ragContext,
            required String aiRecommendations,
            required String clinicalFindings,
            required double confidenceScore,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ClinicalAssessmentsCompanion.insert(
            id: id,
            patientId: patientId,
            assessmentType: assessmentType,
            ragContext: ragContext,
            aiRecommendations: aiRecommendations,
            clinicalFindings: clinicalFindings,
            confidenceScore: confidenceScore,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ClinicalAssessmentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({patientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (patientId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.patientId,
                    referencedTable: $$ClinicalAssessmentsTableReferences
                        ._patientIdTable(db),
                    referencedColumn: $$ClinicalAssessmentsTableReferences
                        ._patientIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ClinicalAssessmentsTableProcessedTableManager = ProcessedTableManager<
    _$DgtlDatabase,
    $ClinicalAssessmentsTable,
    ClinicalAssessment,
    $$ClinicalAssessmentsTableFilterComposer,
    $$ClinicalAssessmentsTableOrderingComposer,
    $$ClinicalAssessmentsTableAnnotationComposer,
    $$ClinicalAssessmentsTableCreateCompanionBuilder,
    $$ClinicalAssessmentsTableUpdateCompanionBuilder,
    (ClinicalAssessment, $$ClinicalAssessmentsTableReferences),
    ClinicalAssessment,
    PrefetchHooks Function({bool patientId})>;
typedef $$LabResultsTableCreateCompanionBuilder = LabResultsCompanion Function({
  Value<int> id,
  required int patientId,
  required String testName,
  required double value,
  required String unit,
  Value<double?> referenceMin,
  Value<double?> referenceMax,
  Value<String?> interpretation,
  required DateTime testDate,
  Value<DateTime> createdAt,
});
typedef $$LabResultsTableUpdateCompanionBuilder = LabResultsCompanion Function({
  Value<int> id,
  Value<int> patientId,
  Value<String> testName,
  Value<double> value,
  Value<String> unit,
  Value<double?> referenceMin,
  Value<double?> referenceMax,
  Value<String?> interpretation,
  Value<DateTime> testDate,
  Value<DateTime> createdAt,
});

final class $$LabResultsTableReferences
    extends BaseReferences<_$DgtlDatabase, $LabResultsTable, LabResult> {
  $$LabResultsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PatientsTable _patientIdTable(_$DgtlDatabase db) =>
      db.patients.createAlias(
          $_aliasNameGenerator(db.labResults.patientId, db.patients.id));

  $$PatientsTableProcessedTableManager? get patientId {
    if ($_item.patientId == null) return null;
    final manager = $$PatientsTableTableManager($_db, $_db.patients)
        .filter((f) => f.id($_item.patientId!));
    final item = $_typedResult.readTableOrNull(_patientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$LabResultsTableFilterComposer
    extends Composer<_$DgtlDatabase, $LabResultsTable> {
  $$LabResultsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get testName => $composableBuilder(
      column: $table.testName, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get referenceMin => $composableBuilder(
      column: $table.referenceMin, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get referenceMax => $composableBuilder(
      column: $table.referenceMax, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get interpretation => $composableBuilder(
      column: $table.interpretation,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get testDate => $composableBuilder(
      column: $table.testDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$PatientsTableFilterComposer get patientId {
    final $$PatientsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.patientId,
        referencedTable: $db.patients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PatientsTableFilterComposer(
              $db: $db,
              $table: $db.patients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LabResultsTableOrderingComposer
    extends Composer<_$DgtlDatabase, $LabResultsTable> {
  $$LabResultsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get testName => $composableBuilder(
      column: $table.testName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get referenceMin => $composableBuilder(
      column: $table.referenceMin,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get referenceMax => $composableBuilder(
      column: $table.referenceMax,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get interpretation => $composableBuilder(
      column: $table.interpretation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get testDate => $composableBuilder(
      column: $table.testDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$PatientsTableOrderingComposer get patientId {
    final $$PatientsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.patientId,
        referencedTable: $db.patients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PatientsTableOrderingComposer(
              $db: $db,
              $table: $db.patients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LabResultsTableAnnotationComposer
    extends Composer<_$DgtlDatabase, $LabResultsTable> {
  $$LabResultsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get testName =>
      $composableBuilder(column: $table.testName, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<double> get referenceMin => $composableBuilder(
      column: $table.referenceMin, builder: (column) => column);

  GeneratedColumn<double> get referenceMax => $composableBuilder(
      column: $table.referenceMax, builder: (column) => column);

  GeneratedColumn<String> get interpretation => $composableBuilder(
      column: $table.interpretation, builder: (column) => column);

  GeneratedColumn<DateTime> get testDate =>
      $composableBuilder(column: $table.testDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PatientsTableAnnotationComposer get patientId {
    final $$PatientsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.patientId,
        referencedTable: $db.patients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PatientsTableAnnotationComposer(
              $db: $db,
              $table: $db.patients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LabResultsTableTableManager extends RootTableManager<
    _$DgtlDatabase,
    $LabResultsTable,
    LabResult,
    $$LabResultsTableFilterComposer,
    $$LabResultsTableOrderingComposer,
    $$LabResultsTableAnnotationComposer,
    $$LabResultsTableCreateCompanionBuilder,
    $$LabResultsTableUpdateCompanionBuilder,
    (LabResult, $$LabResultsTableReferences),
    LabResult,
    PrefetchHooks Function({bool patientId})> {
  $$LabResultsTableTableManager(_$DgtlDatabase db, $LabResultsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LabResultsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LabResultsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LabResultsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> patientId = const Value.absent(),
            Value<String> testName = const Value.absent(),
            Value<double> value = const Value.absent(),
            Value<String> unit = const Value.absent(),
            Value<double?> referenceMin = const Value.absent(),
            Value<double?> referenceMax = const Value.absent(),
            Value<String?> interpretation = const Value.absent(),
            Value<DateTime> testDate = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              LabResultsCompanion(
            id: id,
            patientId: patientId,
            testName: testName,
            value: value,
            unit: unit,
            referenceMin: referenceMin,
            referenceMax: referenceMax,
            interpretation: interpretation,
            testDate: testDate,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int patientId,
            required String testName,
            required double value,
            required String unit,
            Value<double?> referenceMin = const Value.absent(),
            Value<double?> referenceMax = const Value.absent(),
            Value<String?> interpretation = const Value.absent(),
            required DateTime testDate,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              LabResultsCompanion.insert(
            id: id,
            patientId: patientId,
            testName: testName,
            value: value,
            unit: unit,
            referenceMin: referenceMin,
            referenceMax: referenceMax,
            interpretation: interpretation,
            testDate: testDate,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LabResultsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({patientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (patientId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.patientId,
                    referencedTable:
                        $$LabResultsTableReferences._patientIdTable(db),
                    referencedColumn:
                        $$LabResultsTableReferences._patientIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$LabResultsTableProcessedTableManager = ProcessedTableManager<
    _$DgtlDatabase,
    $LabResultsTable,
    LabResult,
    $$LabResultsTableFilterComposer,
    $$LabResultsTableOrderingComposer,
    $$LabResultsTableAnnotationComposer,
    $$LabResultsTableCreateCompanionBuilder,
    $$LabResultsTableUpdateCompanionBuilder,
    (LabResult, $$LabResultsTableReferences),
    LabResult,
    PrefetchHooks Function({bool patientId})>;
typedef $$SymptomsTableCreateCompanionBuilder = SymptomsCompanion Function({
  Value<int> id,
  required int patientId,
  required String symptomText,
  required String processedSymptoms,
  required String severity,
  Value<String?> embedding,
  required DateTime reportedAt,
  Value<DateTime> createdAt,
});
typedef $$SymptomsTableUpdateCompanionBuilder = SymptomsCompanion Function({
  Value<int> id,
  Value<int> patientId,
  Value<String> symptomText,
  Value<String> processedSymptoms,
  Value<String> severity,
  Value<String?> embedding,
  Value<DateTime> reportedAt,
  Value<DateTime> createdAt,
});

final class $$SymptomsTableReferences
    extends BaseReferences<_$DgtlDatabase, $SymptomsTable, Symptom> {
  $$SymptomsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PatientsTable _patientIdTable(_$DgtlDatabase db) => db.patients
      .createAlias($_aliasNameGenerator(db.symptoms.patientId, db.patients.id));

  $$PatientsTableProcessedTableManager? get patientId {
    if ($_item.patientId == null) return null;
    final manager = $$PatientsTableTableManager($_db, $_db.patients)
        .filter((f) => f.id($_item.patientId!));
    final item = $_typedResult.readTableOrNull(_patientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SymptomsTableFilterComposer
    extends Composer<_$DgtlDatabase, $SymptomsTable> {
  $$SymptomsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get symptomText => $composableBuilder(
      column: $table.symptomText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get processedSymptoms => $composableBuilder(
      column: $table.processedSymptoms,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get severity => $composableBuilder(
      column: $table.severity, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get embedding => $composableBuilder(
      column: $table.embedding, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get reportedAt => $composableBuilder(
      column: $table.reportedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$PatientsTableFilterComposer get patientId {
    final $$PatientsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.patientId,
        referencedTable: $db.patients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PatientsTableFilterComposer(
              $db: $db,
              $table: $db.patients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SymptomsTableOrderingComposer
    extends Composer<_$DgtlDatabase, $SymptomsTable> {
  $$SymptomsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get symptomText => $composableBuilder(
      column: $table.symptomText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get processedSymptoms => $composableBuilder(
      column: $table.processedSymptoms,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get severity => $composableBuilder(
      column: $table.severity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get embedding => $composableBuilder(
      column: $table.embedding, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get reportedAt => $composableBuilder(
      column: $table.reportedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$PatientsTableOrderingComposer get patientId {
    final $$PatientsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.patientId,
        referencedTable: $db.patients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PatientsTableOrderingComposer(
              $db: $db,
              $table: $db.patients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SymptomsTableAnnotationComposer
    extends Composer<_$DgtlDatabase, $SymptomsTable> {
  $$SymptomsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get symptomText => $composableBuilder(
      column: $table.symptomText, builder: (column) => column);

  GeneratedColumn<String> get processedSymptoms => $composableBuilder(
      column: $table.processedSymptoms, builder: (column) => column);

  GeneratedColumn<String> get severity =>
      $composableBuilder(column: $table.severity, builder: (column) => column);

  GeneratedColumn<String> get embedding =>
      $composableBuilder(column: $table.embedding, builder: (column) => column);

  GeneratedColumn<DateTime> get reportedAt => $composableBuilder(
      column: $table.reportedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PatientsTableAnnotationComposer get patientId {
    final $$PatientsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.patientId,
        referencedTable: $db.patients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PatientsTableAnnotationComposer(
              $db: $db,
              $table: $db.patients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SymptomsTableTableManager extends RootTableManager<
    _$DgtlDatabase,
    $SymptomsTable,
    Symptom,
    $$SymptomsTableFilterComposer,
    $$SymptomsTableOrderingComposer,
    $$SymptomsTableAnnotationComposer,
    $$SymptomsTableCreateCompanionBuilder,
    $$SymptomsTableUpdateCompanionBuilder,
    (Symptom, $$SymptomsTableReferences),
    Symptom,
    PrefetchHooks Function({bool patientId})> {
  $$SymptomsTableTableManager(_$DgtlDatabase db, $SymptomsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SymptomsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SymptomsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SymptomsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> patientId = const Value.absent(),
            Value<String> symptomText = const Value.absent(),
            Value<String> processedSymptoms = const Value.absent(),
            Value<String> severity = const Value.absent(),
            Value<String?> embedding = const Value.absent(),
            Value<DateTime> reportedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              SymptomsCompanion(
            id: id,
            patientId: patientId,
            symptomText: symptomText,
            processedSymptoms: processedSymptoms,
            severity: severity,
            embedding: embedding,
            reportedAt: reportedAt,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int patientId,
            required String symptomText,
            required String processedSymptoms,
            required String severity,
            Value<String?> embedding = const Value.absent(),
            required DateTime reportedAt,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              SymptomsCompanion.insert(
            id: id,
            patientId: patientId,
            symptomText: symptomText,
            processedSymptoms: processedSymptoms,
            severity: severity,
            embedding: embedding,
            reportedAt: reportedAt,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$SymptomsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({patientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (patientId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.patientId,
                    referencedTable:
                        $$SymptomsTableReferences._patientIdTable(db),
                    referencedColumn:
                        $$SymptomsTableReferences._patientIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SymptomsTableProcessedTableManager = ProcessedTableManager<
    _$DgtlDatabase,
    $SymptomsTable,
    Symptom,
    $$SymptomsTableFilterComposer,
    $$SymptomsTableOrderingComposer,
    $$SymptomsTableAnnotationComposer,
    $$SymptomsTableCreateCompanionBuilder,
    $$SymptomsTableUpdateCompanionBuilder,
    (Symptom, $$SymptomsTableReferences),
    Symptom,
    PrefetchHooks Function({bool patientId})>;
typedef $$MedicationsTableCreateCompanionBuilder = MedicationsCompanion
    Function({
  Value<int> id,
  required int patientId,
  required String medicationName,
  required String dosage,
  required String frequency,
  Value<String?> safetyAlerts,
  Value<bool> isActive,
  required DateTime startDate,
  Value<DateTime?> endDate,
  Value<DateTime> createdAt,
});
typedef $$MedicationsTableUpdateCompanionBuilder = MedicationsCompanion
    Function({
  Value<int> id,
  Value<int> patientId,
  Value<String> medicationName,
  Value<String> dosage,
  Value<String> frequency,
  Value<String?> safetyAlerts,
  Value<bool> isActive,
  Value<DateTime> startDate,
  Value<DateTime?> endDate,
  Value<DateTime> createdAt,
});

final class $$MedicationsTableReferences
    extends BaseReferences<_$DgtlDatabase, $MedicationsTable, Medication> {
  $$MedicationsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PatientsTable _patientIdTable(_$DgtlDatabase db) =>
      db.patients.createAlias(
          $_aliasNameGenerator(db.medications.patientId, db.patients.id));

  $$PatientsTableProcessedTableManager? get patientId {
    if ($_item.patientId == null) return null;
    final manager = $$PatientsTableTableManager($_db, $_db.patients)
        .filter((f) => f.id($_item.patientId!));
    final item = $_typedResult.readTableOrNull(_patientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$MedicationsTableFilterComposer
    extends Composer<_$DgtlDatabase, $MedicationsTable> {
  $$MedicationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get medicationName => $composableBuilder(
      column: $table.medicationName,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dosage => $composableBuilder(
      column: $table.dosage, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get safetyAlerts => $composableBuilder(
      column: $table.safetyAlerts, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$PatientsTableFilterComposer get patientId {
    final $$PatientsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.patientId,
        referencedTable: $db.patients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PatientsTableFilterComposer(
              $db: $db,
              $table: $db.patients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MedicationsTableOrderingComposer
    extends Composer<_$DgtlDatabase, $MedicationsTable> {
  $$MedicationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get medicationName => $composableBuilder(
      column: $table.medicationName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dosage => $composableBuilder(
      column: $table.dosage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get safetyAlerts => $composableBuilder(
      column: $table.safetyAlerts,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$PatientsTableOrderingComposer get patientId {
    final $$PatientsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.patientId,
        referencedTable: $db.patients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PatientsTableOrderingComposer(
              $db: $db,
              $table: $db.patients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MedicationsTableAnnotationComposer
    extends Composer<_$DgtlDatabase, $MedicationsTable> {
  $$MedicationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get medicationName => $composableBuilder(
      column: $table.medicationName, builder: (column) => column);

  GeneratedColumn<String> get dosage =>
      $composableBuilder(column: $table.dosage, builder: (column) => column);

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<String> get safetyAlerts => $composableBuilder(
      column: $table.safetyAlerts, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PatientsTableAnnotationComposer get patientId {
    final $$PatientsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.patientId,
        referencedTable: $db.patients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PatientsTableAnnotationComposer(
              $db: $db,
              $table: $db.patients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MedicationsTableTableManager extends RootTableManager<
    _$DgtlDatabase,
    $MedicationsTable,
    Medication,
    $$MedicationsTableFilterComposer,
    $$MedicationsTableOrderingComposer,
    $$MedicationsTableAnnotationComposer,
    $$MedicationsTableCreateCompanionBuilder,
    $$MedicationsTableUpdateCompanionBuilder,
    (Medication, $$MedicationsTableReferences),
    Medication,
    PrefetchHooks Function({bool patientId})> {
  $$MedicationsTableTableManager(_$DgtlDatabase db, $MedicationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MedicationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MedicationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MedicationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> patientId = const Value.absent(),
            Value<String> medicationName = const Value.absent(),
            Value<String> dosage = const Value.absent(),
            Value<String> frequency = const Value.absent(),
            Value<String?> safetyAlerts = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> startDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              MedicationsCompanion(
            id: id,
            patientId: patientId,
            medicationName: medicationName,
            dosage: dosage,
            frequency: frequency,
            safetyAlerts: safetyAlerts,
            isActive: isActive,
            startDate: startDate,
            endDate: endDate,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int patientId,
            required String medicationName,
            required String dosage,
            required String frequency,
            Value<String?> safetyAlerts = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            required DateTime startDate,
            Value<DateTime?> endDate = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              MedicationsCompanion.insert(
            id: id,
            patientId: patientId,
            medicationName: medicationName,
            dosage: dosage,
            frequency: frequency,
            safetyAlerts: safetyAlerts,
            isActive: isActive,
            startDate: startDate,
            endDate: endDate,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MedicationsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({patientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (patientId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.patientId,
                    referencedTable:
                        $$MedicationsTableReferences._patientIdTable(db),
                    referencedColumn:
                        $$MedicationsTableReferences._patientIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$MedicationsTableProcessedTableManager = ProcessedTableManager<
    _$DgtlDatabase,
    $MedicationsTable,
    Medication,
    $$MedicationsTableFilterComposer,
    $$MedicationsTableOrderingComposer,
    $$MedicationsTableAnnotationComposer,
    $$MedicationsTableCreateCompanionBuilder,
    $$MedicationsTableUpdateCompanionBuilder,
    (Medication, $$MedicationsTableReferences),
    Medication,
    PrefetchHooks Function({bool patientId})>;
typedef $$RagQueryCacheTableCreateCompanionBuilder = RagQueryCacheCompanion
    Function({
  Value<int> id,
  required String queryHash,
  required String query,
  required String retrievedContext,
  required String generatedResponse,
  required double relevanceScore,
  Value<DateTime> createdAt,
  required DateTime expiresAt,
});
typedef $$RagQueryCacheTableUpdateCompanionBuilder = RagQueryCacheCompanion
    Function({
  Value<int> id,
  Value<String> queryHash,
  Value<String> query,
  Value<String> retrievedContext,
  Value<String> generatedResponse,
  Value<double> relevanceScore,
  Value<DateTime> createdAt,
  Value<DateTime> expiresAt,
});

class $$RagQueryCacheTableFilterComposer
    extends Composer<_$DgtlDatabase, $RagQueryCacheTable> {
  $$RagQueryCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get queryHash => $composableBuilder(
      column: $table.queryHash, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get query => $composableBuilder(
      column: $table.query, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get retrievedContext => $composableBuilder(
      column: $table.retrievedContext,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get generatedResponse => $composableBuilder(
      column: $table.generatedResponse,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get relevanceScore => $composableBuilder(
      column: $table.relevanceScore,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
      column: $table.expiresAt, builder: (column) => ColumnFilters(column));
}

class $$RagQueryCacheTableOrderingComposer
    extends Composer<_$DgtlDatabase, $RagQueryCacheTable> {
  $$RagQueryCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get queryHash => $composableBuilder(
      column: $table.queryHash, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get query => $composableBuilder(
      column: $table.query, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get retrievedContext => $composableBuilder(
      column: $table.retrievedContext,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get generatedResponse => $composableBuilder(
      column: $table.generatedResponse,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get relevanceScore => $composableBuilder(
      column: $table.relevanceScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
      column: $table.expiresAt, builder: (column) => ColumnOrderings(column));
}

class $$RagQueryCacheTableAnnotationComposer
    extends Composer<_$DgtlDatabase, $RagQueryCacheTable> {
  $$RagQueryCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get queryHash =>
      $composableBuilder(column: $table.queryHash, builder: (column) => column);

  GeneratedColumn<String> get query =>
      $composableBuilder(column: $table.query, builder: (column) => column);

  GeneratedColumn<String> get retrievedContext => $composableBuilder(
      column: $table.retrievedContext, builder: (column) => column);

  GeneratedColumn<String> get generatedResponse => $composableBuilder(
      column: $table.generatedResponse, builder: (column) => column);

  GeneratedColumn<double> get relevanceScore => $composableBuilder(
      column: $table.relevanceScore, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);
}

class $$RagQueryCacheTableTableManager extends RootTableManager<
    _$DgtlDatabase,
    $RagQueryCacheTable,
    RagQueryCacheData,
    $$RagQueryCacheTableFilterComposer,
    $$RagQueryCacheTableOrderingComposer,
    $$RagQueryCacheTableAnnotationComposer,
    $$RagQueryCacheTableCreateCompanionBuilder,
    $$RagQueryCacheTableUpdateCompanionBuilder,
    (
      RagQueryCacheData,
      BaseReferences<_$DgtlDatabase, $RagQueryCacheTable, RagQueryCacheData>
    ),
    RagQueryCacheData,
    PrefetchHooks Function()> {
  $$RagQueryCacheTableTableManager(_$DgtlDatabase db, $RagQueryCacheTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RagQueryCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RagQueryCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RagQueryCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> queryHash = const Value.absent(),
            Value<String> query = const Value.absent(),
            Value<String> retrievedContext = const Value.absent(),
            Value<String> generatedResponse = const Value.absent(),
            Value<double> relevanceScore = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> expiresAt = const Value.absent(),
          }) =>
              RagQueryCacheCompanion(
            id: id,
            queryHash: queryHash,
            query: query,
            retrievedContext: retrievedContext,
            generatedResponse: generatedResponse,
            relevanceScore: relevanceScore,
            createdAt: createdAt,
            expiresAt: expiresAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String queryHash,
            required String query,
            required String retrievedContext,
            required String generatedResponse,
            required double relevanceScore,
            Value<DateTime> createdAt = const Value.absent(),
            required DateTime expiresAt,
          }) =>
              RagQueryCacheCompanion.insert(
            id: id,
            queryHash: queryHash,
            query: query,
            retrievedContext: retrievedContext,
            generatedResponse: generatedResponse,
            relevanceScore: relevanceScore,
            createdAt: createdAt,
            expiresAt: expiresAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RagQueryCacheTableProcessedTableManager = ProcessedTableManager<
    _$DgtlDatabase,
    $RagQueryCacheTable,
    RagQueryCacheData,
    $$RagQueryCacheTableFilterComposer,
    $$RagQueryCacheTableOrderingComposer,
    $$RagQueryCacheTableAnnotationComposer,
    $$RagQueryCacheTableCreateCompanionBuilder,
    $$RagQueryCacheTableUpdateCompanionBuilder,
    (
      RagQueryCacheData,
      BaseReferences<_$DgtlDatabase, $RagQueryCacheTable, RagQueryCacheData>
    ),
    RagQueryCacheData,
    PrefetchHooks Function()>;
typedef $$VitalsTableCreateCompanionBuilder = VitalsCompanion Function({
  required String id,
  required String clientId,
  required String patientId,
  required String type,
  required double value,
  required String unit,
  Value<String?> status,
  Value<String?> notes,
  required DateTime recordedAt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> version,
  Value<bool> synced,
  Value<String?> deviceId,
  Value<int> rowid,
});
typedef $$VitalsTableUpdateCompanionBuilder = VitalsCompanion Function({
  Value<String> id,
  Value<String> clientId,
  Value<String> patientId,
  Value<String> type,
  Value<double> value,
  Value<String> unit,
  Value<String?> status,
  Value<String?> notes,
  Value<DateTime> recordedAt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> version,
  Value<bool> synced,
  Value<String?> deviceId,
  Value<int> rowid,
});

class $$VitalsTableFilterComposer
    extends Composer<_$DgtlDatabase, $VitalsTable> {
  $$VitalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get clientId => $composableBuilder(
      column: $table.clientId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnFilters(column));
}

class $$VitalsTableOrderingComposer
    extends Composer<_$DgtlDatabase, $VitalsTable> {
  $$VitalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get clientId => $composableBuilder(
      column: $table.clientId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnOrderings(column));
}

class $$VitalsTableAnnotationComposer
    extends Composer<_$DgtlDatabase, $VitalsTable> {
  $$VitalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);
}

class $$VitalsTableTableManager extends RootTableManager<
    _$DgtlDatabase,
    $VitalsTable,
    Vital,
    $$VitalsTableFilterComposer,
    $$VitalsTableOrderingComposer,
    $$VitalsTableAnnotationComposer,
    $$VitalsTableCreateCompanionBuilder,
    $$VitalsTableUpdateCompanionBuilder,
    (Vital, BaseReferences<_$DgtlDatabase, $VitalsTable, Vital>),
    Vital,
    PrefetchHooks Function()> {
  $$VitalsTableTableManager(_$DgtlDatabase db, $VitalsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VitalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VitalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VitalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> clientId = const Value.absent(),
            Value<String> patientId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<double> value = const Value.absent(),
            Value<String> unit = const Value.absent(),
            Value<String?> status = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> recordedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> version = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<String?> deviceId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              VitalsCompanion(
            id: id,
            clientId: clientId,
            patientId: patientId,
            type: type,
            value: value,
            unit: unit,
            status: status,
            notes: notes,
            recordedAt: recordedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            version: version,
            synced: synced,
            deviceId: deviceId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String clientId,
            required String patientId,
            required String type,
            required double value,
            required String unit,
            Value<String?> status = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            required DateTime recordedAt,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> version = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<String?> deviceId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              VitalsCompanion.insert(
            id: id,
            clientId: clientId,
            patientId: patientId,
            type: type,
            value: value,
            unit: unit,
            status: status,
            notes: notes,
            recordedAt: recordedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            version: version,
            synced: synced,
            deviceId: deviceId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$VitalsTableProcessedTableManager = ProcessedTableManager<
    _$DgtlDatabase,
    $VitalsTable,
    Vital,
    $$VitalsTableFilterComposer,
    $$VitalsTableOrderingComposer,
    $$VitalsTableAnnotationComposer,
    $$VitalsTableCreateCompanionBuilder,
    $$VitalsTableUpdateCompanionBuilder,
    (Vital, BaseReferences<_$DgtlDatabase, $VitalsTable, Vital>),
    Vital,
    PrefetchHooks Function()>;
typedef $$BPReadingsTableCreateCompanionBuilder = BPReadingsCompanion Function({
  required String id,
  required String clientId,
  required String patientId,
  required int systolic,
  required int diastolic,
  Value<int?> heartRate,
  required String status,
  Value<String?> position,
  Value<String?> arm,
  Value<double?> fatigueLevel,
  Value<String?> symptoms,
  required DateTime recordedAt,
  Value<DateTime> createdAt,
  Value<int> version,
  Value<bool> synced,
  Value<int> rowid,
});
typedef $$BPReadingsTableUpdateCompanionBuilder = BPReadingsCompanion Function({
  Value<String> id,
  Value<String> clientId,
  Value<String> patientId,
  Value<int> systolic,
  Value<int> diastolic,
  Value<int?> heartRate,
  Value<String> status,
  Value<String?> position,
  Value<String?> arm,
  Value<double?> fatigueLevel,
  Value<String?> symptoms,
  Value<DateTime> recordedAt,
  Value<DateTime> createdAt,
  Value<int> version,
  Value<bool> synced,
  Value<int> rowid,
});

class $$BPReadingsTableFilterComposer
    extends Composer<_$DgtlDatabase, $BPReadingsTable> {
  $$BPReadingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get clientId => $composableBuilder(
      column: $table.clientId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get systolic => $composableBuilder(
      column: $table.systolic, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get diastolic => $composableBuilder(
      column: $table.diastolic, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get heartRate => $composableBuilder(
      column: $table.heartRate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get arm => $composableBuilder(
      column: $table.arm, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get fatigueLevel => $composableBuilder(
      column: $table.fatigueLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get symptoms => $composableBuilder(
      column: $table.symptoms, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnFilters(column));
}

class $$BPReadingsTableOrderingComposer
    extends Composer<_$DgtlDatabase, $BPReadingsTable> {
  $$BPReadingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get clientId => $composableBuilder(
      column: $table.clientId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get systolic => $composableBuilder(
      column: $table.systolic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get diastolic => $composableBuilder(
      column: $table.diastolic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get heartRate => $composableBuilder(
      column: $table.heartRate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get arm => $composableBuilder(
      column: $table.arm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get fatigueLevel => $composableBuilder(
      column: $table.fatigueLevel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get symptoms => $composableBuilder(
      column: $table.symptoms, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnOrderings(column));
}

class $$BPReadingsTableAnnotationComposer
    extends Composer<_$DgtlDatabase, $BPReadingsTable> {
  $$BPReadingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<int> get systolic =>
      $composableBuilder(column: $table.systolic, builder: (column) => column);

  GeneratedColumn<int> get diastolic =>
      $composableBuilder(column: $table.diastolic, builder: (column) => column);

  GeneratedColumn<int> get heartRate =>
      $composableBuilder(column: $table.heartRate, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get arm =>
      $composableBuilder(column: $table.arm, builder: (column) => column);

  GeneratedColumn<double> get fatigueLevel => $composableBuilder(
      column: $table.fatigueLevel, builder: (column) => column);

  GeneratedColumn<String> get symptoms =>
      $composableBuilder(column: $table.symptoms, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);
}

class $$BPReadingsTableTableManager extends RootTableManager<
    _$DgtlDatabase,
    $BPReadingsTable,
    BPReading,
    $$BPReadingsTableFilterComposer,
    $$BPReadingsTableOrderingComposer,
    $$BPReadingsTableAnnotationComposer,
    $$BPReadingsTableCreateCompanionBuilder,
    $$BPReadingsTableUpdateCompanionBuilder,
    (BPReading, BaseReferences<_$DgtlDatabase, $BPReadingsTable, BPReading>),
    BPReading,
    PrefetchHooks Function()> {
  $$BPReadingsTableTableManager(_$DgtlDatabase db, $BPReadingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BPReadingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BPReadingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BPReadingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> clientId = const Value.absent(),
            Value<String> patientId = const Value.absent(),
            Value<int> systolic = const Value.absent(),
            Value<int> diastolic = const Value.absent(),
            Value<int?> heartRate = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> position = const Value.absent(),
            Value<String?> arm = const Value.absent(),
            Value<double?> fatigueLevel = const Value.absent(),
            Value<String?> symptoms = const Value.absent(),
            Value<DateTime> recordedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> version = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BPReadingsCompanion(
            id: id,
            clientId: clientId,
            patientId: patientId,
            systolic: systolic,
            diastolic: diastolic,
            heartRate: heartRate,
            status: status,
            position: position,
            arm: arm,
            fatigueLevel: fatigueLevel,
            symptoms: symptoms,
            recordedAt: recordedAt,
            createdAt: createdAt,
            version: version,
            synced: synced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String clientId,
            required String patientId,
            required int systolic,
            required int diastolic,
            Value<int?> heartRate = const Value.absent(),
            required String status,
            Value<String?> position = const Value.absent(),
            Value<String?> arm = const Value.absent(),
            Value<double?> fatigueLevel = const Value.absent(),
            Value<String?> symptoms = const Value.absent(),
            required DateTime recordedAt,
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> version = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BPReadingsCompanion.insert(
            id: id,
            clientId: clientId,
            patientId: patientId,
            systolic: systolic,
            diastolic: diastolic,
            heartRate: heartRate,
            status: status,
            position: position,
            arm: arm,
            fatigueLevel: fatigueLevel,
            symptoms: symptoms,
            recordedAt: recordedAt,
            createdAt: createdAt,
            version: version,
            synced: synced,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BPReadingsTableProcessedTableManager = ProcessedTableManager<
    _$DgtlDatabase,
    $BPReadingsTable,
    BPReading,
    $$BPReadingsTableFilterComposer,
    $$BPReadingsTableOrderingComposer,
    $$BPReadingsTableAnnotationComposer,
    $$BPReadingsTableCreateCompanionBuilder,
    $$BPReadingsTableUpdateCompanionBuilder,
    (BPReading, BaseReferences<_$DgtlDatabase, $BPReadingsTable, BPReading>),
    BPReading,
    PrefetchHooks Function()>;
typedef $$SyncQueueTableCreateCompanionBuilder = SyncQueueCompanion Function({
  Value<int> id,
  required String opType,
  required String entityType,
  required String entityId,
  required String clientId,
  required String payload,
  Value<int> attempts,
  Value<DateTime?> nextAttemptAt,
  Value<String?> lastError,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$SyncQueueTableUpdateCompanionBuilder = SyncQueueCompanion Function({
  Value<int> id,
  Value<String> opType,
  Value<String> entityType,
  Value<String> entityId,
  Value<String> clientId,
  Value<String> payload,
  Value<int> attempts,
  Value<DateTime?> nextAttemptAt,
  Value<String?> lastError,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$SyncQueueTableFilterComposer
    extends Composer<_$DgtlDatabase, $SyncQueueTable> {
  $$SyncQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get opType => $composableBuilder(
      column: $table.opType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get clientId => $composableBuilder(
      column: $table.clientId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get attempts => $composableBuilder(
      column: $table.attempts, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get nextAttemptAt => $composableBuilder(
      column: $table.nextAttemptAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastError => $composableBuilder(
      column: $table.lastError, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$SyncQueueTableOrderingComposer
    extends Composer<_$DgtlDatabase, $SyncQueueTable> {
  $$SyncQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get opType => $composableBuilder(
      column: $table.opType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get clientId => $composableBuilder(
      column: $table.clientId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get attempts => $composableBuilder(
      column: $table.attempts, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get nextAttemptAt => $composableBuilder(
      column: $table.nextAttemptAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastError => $composableBuilder(
      column: $table.lastError, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$SyncQueueTableAnnotationComposer
    extends Composer<_$DgtlDatabase, $SyncQueueTable> {
  $$SyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get opType =>
      $composableBuilder(column: $table.opType, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => column);

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<DateTime> get nextAttemptAt => $composableBuilder(
      column: $table.nextAttemptAt, builder: (column) => column);

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SyncQueueTableTableManager extends RootTableManager<
    _$DgtlDatabase,
    $SyncQueueTable,
    SyncQueueData,
    $$SyncQueueTableFilterComposer,
    $$SyncQueueTableOrderingComposer,
    $$SyncQueueTableAnnotationComposer,
    $$SyncQueueTableCreateCompanionBuilder,
    $$SyncQueueTableUpdateCompanionBuilder,
    (
      SyncQueueData,
      BaseReferences<_$DgtlDatabase, $SyncQueueTable, SyncQueueData>
    ),
    SyncQueueData,
    PrefetchHooks Function()> {
  $$SyncQueueTableTableManager(_$DgtlDatabase db, $SyncQueueTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> opType = const Value.absent(),
            Value<String> entityType = const Value.absent(),
            Value<String> entityId = const Value.absent(),
            Value<String> clientId = const Value.absent(),
            Value<String> payload = const Value.absent(),
            Value<int> attempts = const Value.absent(),
            Value<DateTime?> nextAttemptAt = const Value.absent(),
            Value<String?> lastError = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              SyncQueueCompanion(
            id: id,
            opType: opType,
            entityType: entityType,
            entityId: entityId,
            clientId: clientId,
            payload: payload,
            attempts: attempts,
            nextAttemptAt: nextAttemptAt,
            lastError: lastError,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String opType,
            required String entityType,
            required String entityId,
            required String clientId,
            required String payload,
            Value<int> attempts = const Value.absent(),
            Value<DateTime?> nextAttemptAt = const Value.absent(),
            Value<String?> lastError = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              SyncQueueCompanion.insert(
            id: id,
            opType: opType,
            entityType: entityType,
            entityId: entityId,
            clientId: clientId,
            payload: payload,
            attempts: attempts,
            nextAttemptAt: nextAttemptAt,
            lastError: lastError,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncQueueTableProcessedTableManager = ProcessedTableManager<
    _$DgtlDatabase,
    $SyncQueueTable,
    SyncQueueData,
    $$SyncQueueTableFilterComposer,
    $$SyncQueueTableOrderingComposer,
    $$SyncQueueTableAnnotationComposer,
    $$SyncQueueTableCreateCompanionBuilder,
    $$SyncQueueTableUpdateCompanionBuilder,
    (
      SyncQueueData,
      BaseReferences<_$DgtlDatabase, $SyncQueueTable, SyncQueueData>
    ),
    SyncQueueData,
    PrefetchHooks Function()>;
typedef $$AIRecommendationsTableCreateCompanionBuilder
    = AIRecommendationsCompanion Function({
  required String id,
  required String patientId,
  required String type,
  required String title,
  required String content,
  required String priority,
  required double confidence,
  Value<String?> triggers,
  Value<String?> relatedVitals,
  Value<DateTime?> validUntil,
  Value<DateTime> createdAt,
  Value<int> version,
  Value<bool> synced,
  Value<bool> acknowledged,
  Value<int> rowid,
});
typedef $$AIRecommendationsTableUpdateCompanionBuilder
    = AIRecommendationsCompanion Function({
  Value<String> id,
  Value<String> patientId,
  Value<String> type,
  Value<String> title,
  Value<String> content,
  Value<String> priority,
  Value<double> confidence,
  Value<String?> triggers,
  Value<String?> relatedVitals,
  Value<DateTime?> validUntil,
  Value<DateTime> createdAt,
  Value<int> version,
  Value<bool> synced,
  Value<bool> acknowledged,
  Value<int> rowid,
});

class $$AIRecommendationsTableFilterComposer
    extends Composer<_$DgtlDatabase, $AIRecommendationsTable> {
  $$AIRecommendationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get confidence => $composableBuilder(
      column: $table.confidence, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get triggers => $composableBuilder(
      column: $table.triggers, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get relatedVitals => $composableBuilder(
      column: $table.relatedVitals, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get validUntil => $composableBuilder(
      column: $table.validUntil, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get acknowledged => $composableBuilder(
      column: $table.acknowledged, builder: (column) => ColumnFilters(column));
}

class $$AIRecommendationsTableOrderingComposer
    extends Composer<_$DgtlDatabase, $AIRecommendationsTable> {
  $$AIRecommendationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get confidence => $composableBuilder(
      column: $table.confidence, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get triggers => $composableBuilder(
      column: $table.triggers, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get relatedVitals => $composableBuilder(
      column: $table.relatedVitals,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get validUntil => $composableBuilder(
      column: $table.validUntil, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get acknowledged => $composableBuilder(
      column: $table.acknowledged,
      builder: (column) => ColumnOrderings(column));
}

class $$AIRecommendationsTableAnnotationComposer
    extends Composer<_$DgtlDatabase, $AIRecommendationsTable> {
  $$AIRecommendationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
      column: $table.confidence, builder: (column) => column);

  GeneratedColumn<String> get triggers =>
      $composableBuilder(column: $table.triggers, builder: (column) => column);

  GeneratedColumn<String> get relatedVitals => $composableBuilder(
      column: $table.relatedVitals, builder: (column) => column);

  GeneratedColumn<DateTime> get validUntil => $composableBuilder(
      column: $table.validUntil, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  GeneratedColumn<bool> get acknowledged => $composableBuilder(
      column: $table.acknowledged, builder: (column) => column);
}

class $$AIRecommendationsTableTableManager extends RootTableManager<
    _$DgtlDatabase,
    $AIRecommendationsTable,
    AIRecommendation,
    $$AIRecommendationsTableFilterComposer,
    $$AIRecommendationsTableOrderingComposer,
    $$AIRecommendationsTableAnnotationComposer,
    $$AIRecommendationsTableCreateCompanionBuilder,
    $$AIRecommendationsTableUpdateCompanionBuilder,
    (
      AIRecommendation,
      BaseReferences<_$DgtlDatabase, $AIRecommendationsTable, AIRecommendation>
    ),
    AIRecommendation,
    PrefetchHooks Function()> {
  $$AIRecommendationsTableTableManager(
      _$DgtlDatabase db, $AIRecommendationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AIRecommendationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AIRecommendationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AIRecommendationsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> patientId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> priority = const Value.absent(),
            Value<double> confidence = const Value.absent(),
            Value<String?> triggers = const Value.absent(),
            Value<String?> relatedVitals = const Value.absent(),
            Value<DateTime?> validUntil = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> version = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<bool> acknowledged = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AIRecommendationsCompanion(
            id: id,
            patientId: patientId,
            type: type,
            title: title,
            content: content,
            priority: priority,
            confidence: confidence,
            triggers: triggers,
            relatedVitals: relatedVitals,
            validUntil: validUntil,
            createdAt: createdAt,
            version: version,
            synced: synced,
            acknowledged: acknowledged,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String patientId,
            required String type,
            required String title,
            required String content,
            required String priority,
            required double confidence,
            Value<String?> triggers = const Value.absent(),
            Value<String?> relatedVitals = const Value.absent(),
            Value<DateTime?> validUntil = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> version = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<bool> acknowledged = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AIRecommendationsCompanion.insert(
            id: id,
            patientId: patientId,
            type: type,
            title: title,
            content: content,
            priority: priority,
            confidence: confidence,
            triggers: triggers,
            relatedVitals: relatedVitals,
            validUntil: validUntil,
            createdAt: createdAt,
            version: version,
            synced: synced,
            acknowledged: acknowledged,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AIRecommendationsTableProcessedTableManager = ProcessedTableManager<
    _$DgtlDatabase,
    $AIRecommendationsTable,
    AIRecommendation,
    $$AIRecommendationsTableFilterComposer,
    $$AIRecommendationsTableOrderingComposer,
    $$AIRecommendationsTableAnnotationComposer,
    $$AIRecommendationsTableCreateCompanionBuilder,
    $$AIRecommendationsTableUpdateCompanionBuilder,
    (
      AIRecommendation,
      BaseReferences<_$DgtlDatabase, $AIRecommendationsTable, AIRecommendation>
    ),
    AIRecommendation,
    PrefetchHooks Function()>;

class $DgtlDatabaseManager {
  final _$DgtlDatabase _db;
  $DgtlDatabaseManager(this._db);
  $$MedicalKnowledgeBaseTableTableManager get medicalKnowledgeBase =>
      $$MedicalKnowledgeBaseTableTableManager(_db, _db.medicalKnowledgeBase);
  $$PatientsTableTableManager get patients =>
      $$PatientsTableTableManager(_db, _db.patients);
  $$ClinicalAssessmentsTableTableManager get clinicalAssessments =>
      $$ClinicalAssessmentsTableTableManager(_db, _db.clinicalAssessments);
  $$LabResultsTableTableManager get labResults =>
      $$LabResultsTableTableManager(_db, _db.labResults);
  $$SymptomsTableTableManager get symptoms =>
      $$SymptomsTableTableManager(_db, _db.symptoms);
  $$MedicationsTableTableManager get medications =>
      $$MedicationsTableTableManager(_db, _db.medications);
  $$RagQueryCacheTableTableManager get ragQueryCache =>
      $$RagQueryCacheTableTableManager(_db, _db.ragQueryCache);
  $$VitalsTableTableManager get vitals =>
      $$VitalsTableTableManager(_db, _db.vitals);
  $$BPReadingsTableTableManager get bPReadings =>
      $$BPReadingsTableTableManager(_db, _db.bPReadings);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
  $$AIRecommendationsTableTableManager get aIRecommendations =>
      $$AIRecommendationsTableTableManager(_db, _db.aIRecommendations);
}
