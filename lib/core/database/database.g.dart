// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
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
  static const VerificationMeta _firstNameMeta =
      const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
      'first_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastNameMeta =
      const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
      'last_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateOfBirthMeta =
      const VerificationMeta('dateOfBirth');
  @override
  late final GeneratedColumn<DateTime> dateOfBirth = GeneratedColumn<DateTime>(
      'date_of_birth', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
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
        firstName,
        lastName,
        dateOfBirth,
        gender,
        notes,
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
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
          _dateOfBirthMeta,
          dateOfBirth.isAcceptableOrUnknown(
              data['date_of_birth']!, _dateOfBirthMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
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
      firstName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_name'])!,
      lastName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_name'])!,
      dateOfBirth: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date_of_birth']),
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
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
  final String firstName;
  final String lastName;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Patient(
      {required this.id,
      required this.firstName,
      required this.lastName,
      this.dateOfBirth,
      this.gender,
      this.notes,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    if (!nullToAbsent || dateOfBirth != null) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PatientsCompanion toCompanion(bool nullToAbsent) {
    return PatientsCompanion(
      id: Value(id),
      firstName: Value(firstName),
      lastName: Value(lastName),
      dateOfBirth: dateOfBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfBirth),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Patient.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Patient(
      id: serializer.fromJson<int>(json['id']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      dateOfBirth: serializer.fromJson<DateTime?>(json['dateOfBirth']),
      gender: serializer.fromJson<String?>(json['gender']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'dateOfBirth': serializer.toJson<DateTime?>(dateOfBirth),
      'gender': serializer.toJson<String?>(gender),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Patient copyWith(
          {int? id,
          String? firstName,
          String? lastName,
          Value<DateTime?> dateOfBirth = const Value.absent(),
          Value<String?> gender = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Patient(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        dateOfBirth: dateOfBirth.present ? dateOfBirth.value : this.dateOfBirth,
        gender: gender.present ? gender.value : this.gender,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Patient copyWithCompanion(PatientsCompanion data) {
    return Patient(
      id: data.id.present ? data.id.value : this.id,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      dateOfBirth:
          data.dateOfBirth.present ? data.dateOfBirth.value : this.dateOfBirth,
      gender: data.gender.present ? data.gender.value : this.gender,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Patient(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('gender: $gender, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, firstName, lastName, dateOfBirth, gender,
      notes, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Patient &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.dateOfBirth == this.dateOfBirth &&
          other.gender == this.gender &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PatientsCompanion extends UpdateCompanion<Patient> {
  final Value<int> id;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<DateTime?> dateOfBirth;
  final Value<String?> gender;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PatientsCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.gender = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PatientsCompanion.insert({
    this.id = const Value.absent(),
    required String firstName,
    required String lastName,
    this.dateOfBirth = const Value.absent(),
    this.gender = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : firstName = Value(firstName),
        lastName = Value(lastName);
  static Insertable<Patient> custom({
    Expression<int>? id,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<DateTime>? dateOfBirth,
    Expression<String>? gender,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (gender != null) 'gender': gender,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PatientsCompanion copyWith(
      {Value<int>? id,
      Value<String>? firstName,
      Value<String>? lastName,
      Value<DateTime?>? dateOfBirth,
      Value<String?>? gender,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return PatientsCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      notes: notes ?? this.notes,
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
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
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
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('gender: $gender, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $LabTestsTable extends LabTests with TableInfo<$LabTestsTable, LabTest> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LabTestsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _testNameMeta =
      const VerificationMeta('testName');
  @override
  late final GeneratedColumn<String> testName = GeneratedColumn<String>(
      'test_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
      'unit', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _normalRangeMeta =
      const VerificationMeta('normalRange');
  @override
  late final GeneratedColumn<String> normalRange = GeneratedColumn<String>(
      'normal_range', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, testName, category, unit, normalRange, description, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lab_tests';
  @override
  VerificationContext validateIntegrity(Insertable<LabTest> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('test_name')) {
      context.handle(_testNameMeta,
          testName.isAcceptableOrUnknown(data['test_name']!, _testNameMeta));
    } else if (isInserting) {
      context.missing(_testNameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    }
    if (data.containsKey('normal_range')) {
      context.handle(
          _normalRangeMeta,
          normalRange.isAcceptableOrUnknown(
              data['normal_range']!, _normalRangeMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
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
  LabTest map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LabTest(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      testName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}test_name'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      unit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit']),
      normalRange: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}normal_range']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $LabTestsTable createAlias(String alias) {
    return $LabTestsTable(attachedDatabase, alias);
  }
}

class LabTest extends DataClass implements Insertable<LabTest> {
  final int id;
  final String testName;
  final String category;
  final String? unit;
  final String? normalRange;
  final String? description;
  final DateTime createdAt;
  const LabTest(
      {required this.id,
      required this.testName,
      required this.category,
      this.unit,
      this.normalRange,
      this.description,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['test_name'] = Variable<String>(testName);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<String>(unit);
    }
    if (!nullToAbsent || normalRange != null) {
      map['normal_range'] = Variable<String>(normalRange);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LabTestsCompanion toCompanion(bool nullToAbsent) {
    return LabTestsCompanion(
      id: Value(id),
      testName: Value(testName),
      category: Value(category),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
      normalRange: normalRange == null && nullToAbsent
          ? const Value.absent()
          : Value(normalRange),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
    );
  }

  factory LabTest.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LabTest(
      id: serializer.fromJson<int>(json['id']),
      testName: serializer.fromJson<String>(json['testName']),
      category: serializer.fromJson<String>(json['category']),
      unit: serializer.fromJson<String?>(json['unit']),
      normalRange: serializer.fromJson<String?>(json['normalRange']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'testName': serializer.toJson<String>(testName),
      'category': serializer.toJson<String>(category),
      'unit': serializer.toJson<String?>(unit),
      'normalRange': serializer.toJson<String?>(normalRange),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LabTest copyWith(
          {int? id,
          String? testName,
          String? category,
          Value<String?> unit = const Value.absent(),
          Value<String?> normalRange = const Value.absent(),
          Value<String?> description = const Value.absent(),
          DateTime? createdAt}) =>
      LabTest(
        id: id ?? this.id,
        testName: testName ?? this.testName,
        category: category ?? this.category,
        unit: unit.present ? unit.value : this.unit,
        normalRange: normalRange.present ? normalRange.value : this.normalRange,
        description: description.present ? description.value : this.description,
        createdAt: createdAt ?? this.createdAt,
      );
  LabTest copyWithCompanion(LabTestsCompanion data) {
    return LabTest(
      id: data.id.present ? data.id.value : this.id,
      testName: data.testName.present ? data.testName.value : this.testName,
      category: data.category.present ? data.category.value : this.category,
      unit: data.unit.present ? data.unit.value : this.unit,
      normalRange:
          data.normalRange.present ? data.normalRange.value : this.normalRange,
      description:
          data.description.present ? data.description.value : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LabTest(')
          ..write('id: $id, ')
          ..write('testName: $testName, ')
          ..write('category: $category, ')
          ..write('unit: $unit, ')
          ..write('normalRange: $normalRange, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, testName, category, unit, normalRange, description, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LabTest &&
          other.id == this.id &&
          other.testName == this.testName &&
          other.category == this.category &&
          other.unit == this.unit &&
          other.normalRange == this.normalRange &&
          other.description == this.description &&
          other.createdAt == this.createdAt);
}

class LabTestsCompanion extends UpdateCompanion<LabTest> {
  final Value<int> id;
  final Value<String> testName;
  final Value<String> category;
  final Value<String?> unit;
  final Value<String?> normalRange;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  const LabTestsCompanion({
    this.id = const Value.absent(),
    this.testName = const Value.absent(),
    this.category = const Value.absent(),
    this.unit = const Value.absent(),
    this.normalRange = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  LabTestsCompanion.insert({
    this.id = const Value.absent(),
    required String testName,
    required String category,
    this.unit = const Value.absent(),
    this.normalRange = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : testName = Value(testName),
        category = Value(category);
  static Insertable<LabTest> custom({
    Expression<int>? id,
    Expression<String>? testName,
    Expression<String>? category,
    Expression<String>? unit,
    Expression<String>? normalRange,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (testName != null) 'test_name': testName,
      if (category != null) 'category': category,
      if (unit != null) 'unit': unit,
      if (normalRange != null) 'normal_range': normalRange,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  LabTestsCompanion copyWith(
      {Value<int>? id,
      Value<String>? testName,
      Value<String>? category,
      Value<String?>? unit,
      Value<String?>? normalRange,
      Value<String?>? description,
      Value<DateTime>? createdAt}) {
    return LabTestsCompanion(
      id: id ?? this.id,
      testName: testName ?? this.testName,
      category: category ?? this.category,
      unit: unit ?? this.unit,
      normalRange: normalRange ?? this.normalRange,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (testName.present) {
      map['test_name'] = Variable<String>(testName.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (normalRange.present) {
      map['normal_range'] = Variable<String>(normalRange.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LabTestsCompanion(')
          ..write('id: $id, ')
          ..write('testName: $testName, ')
          ..write('category: $category, ')
          ..write('unit: $unit, ')
          ..write('normalRange: $normalRange, ')
          ..write('description: $description, ')
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
  static const VerificationMeta _labTestIdMeta =
      const VerificationMeta('labTestId');
  @override
  late final GeneratedColumn<int> labTestId = GeneratedColumn<int>(
      'lab_test_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES lab_tests (id)'));
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
      'value', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _testDateMeta =
      const VerificationMeta('testDate');
  @override
  late final GeneratedColumn<DateTime> testDate = GeneratedColumn<DateTime>(
      'test_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, patientId, labTestId, value, status, testDate, notes, createdAt];
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
    if (data.containsKey('lab_test_id')) {
      context.handle(
          _labTestIdMeta,
          labTestId.isAcceptableOrUnknown(
              data['lab_test_id']!, _labTestIdMeta));
    } else if (isInserting) {
      context.missing(_labTestIdMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('test_date')) {
      context.handle(_testDateMeta,
          testDate.isAcceptableOrUnknown(data['test_date']!, _testDateMeta));
    } else if (isInserting) {
      context.missing(_testDateMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
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
      labTestId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}lab_test_id'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}value'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status']),
      testDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}test_date'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
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
  final int labTestId;
  final double value;
  final String? status;
  final DateTime testDate;
  final String? notes;
  final DateTime createdAt;
  const LabResult(
      {required this.id,
      required this.patientId,
      required this.labTestId,
      required this.value,
      this.status,
      required this.testDate,
      this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['patient_id'] = Variable<int>(patientId);
    map['lab_test_id'] = Variable<int>(labTestId);
    map['value'] = Variable<double>(value);
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    map['test_date'] = Variable<DateTime>(testDate);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LabResultsCompanion toCompanion(bool nullToAbsent) {
    return LabResultsCompanion(
      id: Value(id),
      patientId: Value(patientId),
      labTestId: Value(labTestId),
      value: Value(value),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      testDate: Value(testDate),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory LabResult.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LabResult(
      id: serializer.fromJson<int>(json['id']),
      patientId: serializer.fromJson<int>(json['patientId']),
      labTestId: serializer.fromJson<int>(json['labTestId']),
      value: serializer.fromJson<double>(json['value']),
      status: serializer.fromJson<String?>(json['status']),
      testDate: serializer.fromJson<DateTime>(json['testDate']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'patientId': serializer.toJson<int>(patientId),
      'labTestId': serializer.toJson<int>(labTestId),
      'value': serializer.toJson<double>(value),
      'status': serializer.toJson<String?>(status),
      'testDate': serializer.toJson<DateTime>(testDate),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LabResult copyWith(
          {int? id,
          int? patientId,
          int? labTestId,
          double? value,
          Value<String?> status = const Value.absent(),
          DateTime? testDate,
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt}) =>
      LabResult(
        id: id ?? this.id,
        patientId: patientId ?? this.patientId,
        labTestId: labTestId ?? this.labTestId,
        value: value ?? this.value,
        status: status.present ? status.value : this.status,
        testDate: testDate ?? this.testDate,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  LabResult copyWithCompanion(LabResultsCompanion data) {
    return LabResult(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      labTestId: data.labTestId.present ? data.labTestId.value : this.labTestId,
      value: data.value.present ? data.value.value : this.value,
      status: data.status.present ? data.status.value : this.status,
      testDate: data.testDate.present ? data.testDate.value : this.testDate,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LabResult(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('labTestId: $labTestId, ')
          ..write('value: $value, ')
          ..write('status: $status, ')
          ..write('testDate: $testDate, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, patientId, labTestId, value, status, testDate, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LabResult &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.labTestId == this.labTestId &&
          other.value == this.value &&
          other.status == this.status &&
          other.testDate == this.testDate &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class LabResultsCompanion extends UpdateCompanion<LabResult> {
  final Value<int> id;
  final Value<int> patientId;
  final Value<int> labTestId;
  final Value<double> value;
  final Value<String?> status;
  final Value<DateTime> testDate;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const LabResultsCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.labTestId = const Value.absent(),
    this.value = const Value.absent(),
    this.status = const Value.absent(),
    this.testDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  LabResultsCompanion.insert({
    this.id = const Value.absent(),
    required int patientId,
    required int labTestId,
    required double value,
    this.status = const Value.absent(),
    required DateTime testDate,
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : patientId = Value(patientId),
        labTestId = Value(labTestId),
        value = Value(value),
        testDate = Value(testDate);
  static Insertable<LabResult> custom({
    Expression<int>? id,
    Expression<int>? patientId,
    Expression<int>? labTestId,
    Expression<double>? value,
    Expression<String>? status,
    Expression<DateTime>? testDate,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (labTestId != null) 'lab_test_id': labTestId,
      if (value != null) 'value': value,
      if (status != null) 'status': status,
      if (testDate != null) 'test_date': testDate,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  LabResultsCompanion copyWith(
      {Value<int>? id,
      Value<int>? patientId,
      Value<int>? labTestId,
      Value<double>? value,
      Value<String?>? status,
      Value<DateTime>? testDate,
      Value<String?>? notes,
      Value<DateTime>? createdAt}) {
    return LabResultsCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      labTestId: labTestId ?? this.labTestId,
      value: value ?? this.value,
      status: status ?? this.status,
      testDate: testDate ?? this.testDate,
      notes: notes ?? this.notes,
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
    if (labTestId.present) {
      map['lab_test_id'] = Variable<int>(labTestId.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (testDate.present) {
      map['test_date'] = Variable<DateTime>(testDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
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
          ..write('labTestId: $labTestId, ')
          ..write('value: $value, ')
          ..write('status: $status, ')
          ..write('testDate: $testDate, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SymptomLogsTable extends SymptomLogs
    with TableInfo<$SymptomLogsTable, SymptomLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SymptomLogsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _symptomMeta =
      const VerificationMeta('symptom');
  @override
  late final GeneratedColumn<String> symptom = GeneratedColumn<String>(
      'symptom', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _severityMeta =
      const VerificationMeta('severity');
  @override
  late final GeneratedColumn<int> severity = GeneratedColumn<int>(
      'severity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _logDateMeta =
      const VerificationMeta('logDate');
  @override
  late final GeneratedColumn<DateTime> logDate = GeneratedColumn<DateTime>(
      'log_date', aliasedName, false,
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
  List<GeneratedColumn> get $columns =>
      [id, patientId, symptom, severity, description, logDate, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'symptom_logs';
  @override
  VerificationContext validateIntegrity(Insertable<SymptomLog> instance,
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
    if (data.containsKey('symptom')) {
      context.handle(_symptomMeta,
          symptom.isAcceptableOrUnknown(data['symptom']!, _symptomMeta));
    } else if (isInserting) {
      context.missing(_symptomMeta);
    }
    if (data.containsKey('severity')) {
      context.handle(_severityMeta,
          severity.isAcceptableOrUnknown(data['severity']!, _severityMeta));
    } else if (isInserting) {
      context.missing(_severityMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('log_date')) {
      context.handle(_logDateMeta,
          logDate.isAcceptableOrUnknown(data['log_date']!, _logDateMeta));
    } else if (isInserting) {
      context.missing(_logDateMeta);
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
  SymptomLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SymptomLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      patientId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}patient_id'])!,
      symptom: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}symptom'])!,
      severity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}severity'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      logDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}log_date'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SymptomLogsTable createAlias(String alias) {
    return $SymptomLogsTable(attachedDatabase, alias);
  }
}

class SymptomLog extends DataClass implements Insertable<SymptomLog> {
  final int id;
  final int patientId;
  final String symptom;
  final int severity;
  final String? description;
  final DateTime logDate;
  final DateTime createdAt;
  const SymptomLog(
      {required this.id,
      required this.patientId,
      required this.symptom,
      required this.severity,
      this.description,
      required this.logDate,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['patient_id'] = Variable<int>(patientId);
    map['symptom'] = Variable<String>(symptom);
    map['severity'] = Variable<int>(severity);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['log_date'] = Variable<DateTime>(logDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SymptomLogsCompanion toCompanion(bool nullToAbsent) {
    return SymptomLogsCompanion(
      id: Value(id),
      patientId: Value(patientId),
      symptom: Value(symptom),
      severity: Value(severity),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      logDate: Value(logDate),
      createdAt: Value(createdAt),
    );
  }

  factory SymptomLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SymptomLog(
      id: serializer.fromJson<int>(json['id']),
      patientId: serializer.fromJson<int>(json['patientId']),
      symptom: serializer.fromJson<String>(json['symptom']),
      severity: serializer.fromJson<int>(json['severity']),
      description: serializer.fromJson<String?>(json['description']),
      logDate: serializer.fromJson<DateTime>(json['logDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'patientId': serializer.toJson<int>(patientId),
      'symptom': serializer.toJson<String>(symptom),
      'severity': serializer.toJson<int>(severity),
      'description': serializer.toJson<String?>(description),
      'logDate': serializer.toJson<DateTime>(logDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SymptomLog copyWith(
          {int? id,
          int? patientId,
          String? symptom,
          int? severity,
          Value<String?> description = const Value.absent(),
          DateTime? logDate,
          DateTime? createdAt}) =>
      SymptomLog(
        id: id ?? this.id,
        patientId: patientId ?? this.patientId,
        symptom: symptom ?? this.symptom,
        severity: severity ?? this.severity,
        description: description.present ? description.value : this.description,
        logDate: logDate ?? this.logDate,
        createdAt: createdAt ?? this.createdAt,
      );
  SymptomLog copyWithCompanion(SymptomLogsCompanion data) {
    return SymptomLog(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      symptom: data.symptom.present ? data.symptom.value : this.symptom,
      severity: data.severity.present ? data.severity.value : this.severity,
      description:
          data.description.present ? data.description.value : this.description,
      logDate: data.logDate.present ? data.logDate.value : this.logDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SymptomLog(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('symptom: $symptom, ')
          ..write('severity: $severity, ')
          ..write('description: $description, ')
          ..write('logDate: $logDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, patientId, symptom, severity, description, logDate, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SymptomLog &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.symptom == this.symptom &&
          other.severity == this.severity &&
          other.description == this.description &&
          other.logDate == this.logDate &&
          other.createdAt == this.createdAt);
}

class SymptomLogsCompanion extends UpdateCompanion<SymptomLog> {
  final Value<int> id;
  final Value<int> patientId;
  final Value<String> symptom;
  final Value<int> severity;
  final Value<String?> description;
  final Value<DateTime> logDate;
  final Value<DateTime> createdAt;
  const SymptomLogsCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.symptom = const Value.absent(),
    this.severity = const Value.absent(),
    this.description = const Value.absent(),
    this.logDate = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SymptomLogsCompanion.insert({
    this.id = const Value.absent(),
    required int patientId,
    required String symptom,
    required int severity,
    this.description = const Value.absent(),
    required DateTime logDate,
    this.createdAt = const Value.absent(),
  })  : patientId = Value(patientId),
        symptom = Value(symptom),
        severity = Value(severity),
        logDate = Value(logDate);
  static Insertable<SymptomLog> custom({
    Expression<int>? id,
    Expression<int>? patientId,
    Expression<String>? symptom,
    Expression<int>? severity,
    Expression<String>? description,
    Expression<DateTime>? logDate,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (symptom != null) 'symptom': symptom,
      if (severity != null) 'severity': severity,
      if (description != null) 'description': description,
      if (logDate != null) 'log_date': logDate,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SymptomLogsCompanion copyWith(
      {Value<int>? id,
      Value<int>? patientId,
      Value<String>? symptom,
      Value<int>? severity,
      Value<String?>? description,
      Value<DateTime>? logDate,
      Value<DateTime>? createdAt}) {
    return SymptomLogsCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      symptom: symptom ?? this.symptom,
      severity: severity ?? this.severity,
      description: description ?? this.description,
      logDate: logDate ?? this.logDate,
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
    if (symptom.present) {
      map['symptom'] = Variable<String>(symptom.value);
    }
    if (severity.present) {
      map['severity'] = Variable<int>(severity.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (logDate.present) {
      map['log_date'] = Variable<DateTime>(logDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SymptomLogsCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('symptom: $symptom, ')
          ..write('severity: $severity, ')
          ..write('description: $description, ')
          ..write('logDate: $logDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DailyHealthLogsTable extends DailyHealthLogs
    with TableInfo<$DailyHealthLogsTable, DailyHealthLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyHealthLogsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _loggedAtMeta =
      const VerificationMeta('loggedAt');
  @override
  late final GeneratedColumn<DateTime> loggedAt = GeneratedColumn<DateTime>(
      'logged_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _systolicMeta =
      const VerificationMeta('systolic');
  @override
  late final GeneratedColumn<int> systolic = GeneratedColumn<int>(
      'systolic', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _diastolicMeta =
      const VerificationMeta('diastolic');
  @override
  late final GeneratedColumn<int> diastolic = GeneratedColumn<int>(
      'diastolic', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _energyMoodMeta =
      const VerificationMeta('energyMood');
  @override
  late final GeneratedColumn<int> energyMood = GeneratedColumn<int>(
      'energy_mood', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _fatigueMeta =
      const VerificationMeta('fatigue');
  @override
  late final GeneratedColumn<int> fatigue = GeneratedColumn<int>(
      'fatigue', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _painMeta = const VerificationMeta('pain');
  @override
  late final GeneratedColumn<int> pain = GeneratedColumn<int>(
      'pain', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _sleepQualityMeta =
      const VerificationMeta('sleepQuality');
  @override
  late final GeneratedColumn<int> sleepQuality = GeneratedColumn<int>(
      'sleep_quality', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _fluidIntakeMeta =
      const VerificationMeta('fluidIntake');
  @override
  late final GeneratedColumn<int> fluidIntake = GeneratedColumn<int>(
      'fluid_intake', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _fluidOutputMeta =
      const VerificationMeta('fluidOutput');
  @override
  late final GeneratedColumn<int> fluidOutput = GeneratedColumn<int>(
      'fluid_output', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
        loggedAt,
        systolic,
        diastolic,
        energyMood,
        fatigue,
        pain,
        sleepQuality,
        fluidIntake,
        fluidOutput,
        notes,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_health_logs';
  @override
  VerificationContext validateIntegrity(Insertable<DailyHealthLog> instance,
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
    if (data.containsKey('logged_at')) {
      context.handle(_loggedAtMeta,
          loggedAt.isAcceptableOrUnknown(data['logged_at']!, _loggedAtMeta));
    } else if (isInserting) {
      context.missing(_loggedAtMeta);
    }
    if (data.containsKey('systolic')) {
      context.handle(_systolicMeta,
          systolic.isAcceptableOrUnknown(data['systolic']!, _systolicMeta));
    }
    if (data.containsKey('diastolic')) {
      context.handle(_diastolicMeta,
          diastolic.isAcceptableOrUnknown(data['diastolic']!, _diastolicMeta));
    }
    if (data.containsKey('energy_mood')) {
      context.handle(
          _energyMoodMeta,
          energyMood.isAcceptableOrUnknown(
              data['energy_mood']!, _energyMoodMeta));
    }
    if (data.containsKey('fatigue')) {
      context.handle(_fatigueMeta,
          fatigue.isAcceptableOrUnknown(data['fatigue']!, _fatigueMeta));
    }
    if (data.containsKey('pain')) {
      context.handle(
          _painMeta, pain.isAcceptableOrUnknown(data['pain']!, _painMeta));
    }
    if (data.containsKey('sleep_quality')) {
      context.handle(
          _sleepQualityMeta,
          sleepQuality.isAcceptableOrUnknown(
              data['sleep_quality']!, _sleepQualityMeta));
    }
    if (data.containsKey('fluid_intake')) {
      context.handle(
          _fluidIntakeMeta,
          fluidIntake.isAcceptableOrUnknown(
              data['fluid_intake']!, _fluidIntakeMeta));
    }
    if (data.containsKey('fluid_output')) {
      context.handle(
          _fluidOutputMeta,
          fluidOutput.isAcceptableOrUnknown(
              data['fluid_output']!, _fluidOutputMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
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
  DailyHealthLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyHealthLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      patientId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}patient_id'])!,
      loggedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}logged_at'])!,
      systolic: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}systolic']),
      diastolic: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}diastolic']),
      energyMood: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}energy_mood']),
      fatigue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fatigue']),
      pain: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pain']),
      sleepQuality: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sleep_quality']),
      fluidIntake: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fluid_intake']),
      fluidOutput: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fluid_output']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $DailyHealthLogsTable createAlias(String alias) {
    return $DailyHealthLogsTable(attachedDatabase, alias);
  }
}

class DailyHealthLog extends DataClass implements Insertable<DailyHealthLog> {
  final int id;
  final int patientId;
  final DateTime loggedAt;
  final int? systolic;
  final int? diastolic;
  final int? energyMood;
  final int? fatigue;
  final int? pain;
  final int? sleepQuality;
  final int? fluidIntake;
  final int? fluidOutput;
  final String? notes;
  final DateTime createdAt;
  const DailyHealthLog(
      {required this.id,
      required this.patientId,
      required this.loggedAt,
      this.systolic,
      this.diastolic,
      this.energyMood,
      this.fatigue,
      this.pain,
      this.sleepQuality,
      this.fluidIntake,
      this.fluidOutput,
      this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['patient_id'] = Variable<int>(patientId);
    map['logged_at'] = Variable<DateTime>(loggedAt);
    if (!nullToAbsent || systolic != null) {
      map['systolic'] = Variable<int>(systolic);
    }
    if (!nullToAbsent || diastolic != null) {
      map['diastolic'] = Variable<int>(diastolic);
    }
    if (!nullToAbsent || energyMood != null) {
      map['energy_mood'] = Variable<int>(energyMood);
    }
    if (!nullToAbsent || fatigue != null) {
      map['fatigue'] = Variable<int>(fatigue);
    }
    if (!nullToAbsent || pain != null) {
      map['pain'] = Variable<int>(pain);
    }
    if (!nullToAbsent || sleepQuality != null) {
      map['sleep_quality'] = Variable<int>(sleepQuality);
    }
    if (!nullToAbsent || fluidIntake != null) {
      map['fluid_intake'] = Variable<int>(fluidIntake);
    }
    if (!nullToAbsent || fluidOutput != null) {
      map['fluid_output'] = Variable<int>(fluidOutput);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DailyHealthLogsCompanion toCompanion(bool nullToAbsent) {
    return DailyHealthLogsCompanion(
      id: Value(id),
      patientId: Value(patientId),
      loggedAt: Value(loggedAt),
      systolic: systolic == null && nullToAbsent
          ? const Value.absent()
          : Value(systolic),
      diastolic: diastolic == null && nullToAbsent
          ? const Value.absent()
          : Value(diastolic),
      energyMood: energyMood == null && nullToAbsent
          ? const Value.absent()
          : Value(energyMood),
      fatigue: fatigue == null && nullToAbsent
          ? const Value.absent()
          : Value(fatigue),
      pain: pain == null && nullToAbsent ? const Value.absent() : Value(pain),
      sleepQuality: sleepQuality == null && nullToAbsent
          ? const Value.absent()
          : Value(sleepQuality),
      fluidIntake: fluidIntake == null && nullToAbsent
          ? const Value.absent()
          : Value(fluidIntake),
      fluidOutput: fluidOutput == null && nullToAbsent
          ? const Value.absent()
          : Value(fluidOutput),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory DailyHealthLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyHealthLog(
      id: serializer.fromJson<int>(json['id']),
      patientId: serializer.fromJson<int>(json['patientId']),
      loggedAt: serializer.fromJson<DateTime>(json['loggedAt']),
      systolic: serializer.fromJson<int?>(json['systolic']),
      diastolic: serializer.fromJson<int?>(json['diastolic']),
      energyMood: serializer.fromJson<int?>(json['energyMood']),
      fatigue: serializer.fromJson<int?>(json['fatigue']),
      pain: serializer.fromJson<int?>(json['pain']),
      sleepQuality: serializer.fromJson<int?>(json['sleepQuality']),
      fluidIntake: serializer.fromJson<int?>(json['fluidIntake']),
      fluidOutput: serializer.fromJson<int?>(json['fluidOutput']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'patientId': serializer.toJson<int>(patientId),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
      'systolic': serializer.toJson<int?>(systolic),
      'diastolic': serializer.toJson<int?>(diastolic),
      'energyMood': serializer.toJson<int?>(energyMood),
      'fatigue': serializer.toJson<int?>(fatigue),
      'pain': serializer.toJson<int?>(pain),
      'sleepQuality': serializer.toJson<int?>(sleepQuality),
      'fluidIntake': serializer.toJson<int?>(fluidIntake),
      'fluidOutput': serializer.toJson<int?>(fluidOutput),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DailyHealthLog copyWith(
          {int? id,
          int? patientId,
          DateTime? loggedAt,
          Value<int?> systolic = const Value.absent(),
          Value<int?> diastolic = const Value.absent(),
          Value<int?> energyMood = const Value.absent(),
          Value<int?> fatigue = const Value.absent(),
          Value<int?> pain = const Value.absent(),
          Value<int?> sleepQuality = const Value.absent(),
          Value<int?> fluidIntake = const Value.absent(),
          Value<int?> fluidOutput = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt}) =>
      DailyHealthLog(
        id: id ?? this.id,
        patientId: patientId ?? this.patientId,
        loggedAt: loggedAt ?? this.loggedAt,
        systolic: systolic.present ? systolic.value : this.systolic,
        diastolic: diastolic.present ? diastolic.value : this.diastolic,
        energyMood: energyMood.present ? energyMood.value : this.energyMood,
        fatigue: fatigue.present ? fatigue.value : this.fatigue,
        pain: pain.present ? pain.value : this.pain,
        sleepQuality:
            sleepQuality.present ? sleepQuality.value : this.sleepQuality,
        fluidIntake: fluidIntake.present ? fluidIntake.value : this.fluidIntake,
        fluidOutput: fluidOutput.present ? fluidOutput.value : this.fluidOutput,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  DailyHealthLog copyWithCompanion(DailyHealthLogsCompanion data) {
    return DailyHealthLog(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
      systolic: data.systolic.present ? data.systolic.value : this.systolic,
      diastolic: data.diastolic.present ? data.diastolic.value : this.diastolic,
      energyMood:
          data.energyMood.present ? data.energyMood.value : this.energyMood,
      fatigue: data.fatigue.present ? data.fatigue.value : this.fatigue,
      pain: data.pain.present ? data.pain.value : this.pain,
      sleepQuality: data.sleepQuality.present
          ? data.sleepQuality.value
          : this.sleepQuality,
      fluidIntake:
          data.fluidIntake.present ? data.fluidIntake.value : this.fluidIntake,
      fluidOutput:
          data.fluidOutput.present ? data.fluidOutput.value : this.fluidOutput,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyHealthLog(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('systolic: $systolic, ')
          ..write('diastolic: $diastolic, ')
          ..write('energyMood: $energyMood, ')
          ..write('fatigue: $fatigue, ')
          ..write('pain: $pain, ')
          ..write('sleepQuality: $sleepQuality, ')
          ..write('fluidIntake: $fluidIntake, ')
          ..write('fluidOutput: $fluidOutput, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      patientId,
      loggedAt,
      systolic,
      diastolic,
      energyMood,
      fatigue,
      pain,
      sleepQuality,
      fluidIntake,
      fluidOutput,
      notes,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyHealthLog &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.loggedAt == this.loggedAt &&
          other.systolic == this.systolic &&
          other.diastolic == this.diastolic &&
          other.energyMood == this.energyMood &&
          other.fatigue == this.fatigue &&
          other.pain == this.pain &&
          other.sleepQuality == this.sleepQuality &&
          other.fluidIntake == this.fluidIntake &&
          other.fluidOutput == this.fluidOutput &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class DailyHealthLogsCompanion extends UpdateCompanion<DailyHealthLog> {
  final Value<int> id;
  final Value<int> patientId;
  final Value<DateTime> loggedAt;
  final Value<int?> systolic;
  final Value<int?> diastolic;
  final Value<int?> energyMood;
  final Value<int?> fatigue;
  final Value<int?> pain;
  final Value<int?> sleepQuality;
  final Value<int?> fluidIntake;
  final Value<int?> fluidOutput;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const DailyHealthLogsCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.loggedAt = const Value.absent(),
    this.systolic = const Value.absent(),
    this.diastolic = const Value.absent(),
    this.energyMood = const Value.absent(),
    this.fatigue = const Value.absent(),
    this.pain = const Value.absent(),
    this.sleepQuality = const Value.absent(),
    this.fluidIntake = const Value.absent(),
    this.fluidOutput = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DailyHealthLogsCompanion.insert({
    this.id = const Value.absent(),
    required int patientId,
    required DateTime loggedAt,
    this.systolic = const Value.absent(),
    this.diastolic = const Value.absent(),
    this.energyMood = const Value.absent(),
    this.fatigue = const Value.absent(),
    this.pain = const Value.absent(),
    this.sleepQuality = const Value.absent(),
    this.fluidIntake = const Value.absent(),
    this.fluidOutput = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : patientId = Value(patientId),
        loggedAt = Value(loggedAt);
  static Insertable<DailyHealthLog> custom({
    Expression<int>? id,
    Expression<int>? patientId,
    Expression<DateTime>? loggedAt,
    Expression<int>? systolic,
    Expression<int>? diastolic,
    Expression<int>? energyMood,
    Expression<int>? fatigue,
    Expression<int>? pain,
    Expression<int>? sleepQuality,
    Expression<int>? fluidIntake,
    Expression<int>? fluidOutput,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (loggedAt != null) 'logged_at': loggedAt,
      if (systolic != null) 'systolic': systolic,
      if (diastolic != null) 'diastolic': diastolic,
      if (energyMood != null) 'energy_mood': energyMood,
      if (fatigue != null) 'fatigue': fatigue,
      if (pain != null) 'pain': pain,
      if (sleepQuality != null) 'sleep_quality': sleepQuality,
      if (fluidIntake != null) 'fluid_intake': fluidIntake,
      if (fluidOutput != null) 'fluid_output': fluidOutput,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DailyHealthLogsCompanion copyWith(
      {Value<int>? id,
      Value<int>? patientId,
      Value<DateTime>? loggedAt,
      Value<int?>? systolic,
      Value<int?>? diastolic,
      Value<int?>? energyMood,
      Value<int?>? fatigue,
      Value<int?>? pain,
      Value<int?>? sleepQuality,
      Value<int?>? fluidIntake,
      Value<int?>? fluidOutput,
      Value<String?>? notes,
      Value<DateTime>? createdAt}) {
    return DailyHealthLogsCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      loggedAt: loggedAt ?? this.loggedAt,
      systolic: systolic ?? this.systolic,
      diastolic: diastolic ?? this.diastolic,
      energyMood: energyMood ?? this.energyMood,
      fatigue: fatigue ?? this.fatigue,
      pain: pain ?? this.pain,
      sleepQuality: sleepQuality ?? this.sleepQuality,
      fluidIntake: fluidIntake ?? this.fluidIntake,
      fluidOutput: fluidOutput ?? this.fluidOutput,
      notes: notes ?? this.notes,
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
    if (loggedAt.present) {
      map['logged_at'] = Variable<DateTime>(loggedAt.value);
    }
    if (systolic.present) {
      map['systolic'] = Variable<int>(systolic.value);
    }
    if (diastolic.present) {
      map['diastolic'] = Variable<int>(diastolic.value);
    }
    if (energyMood.present) {
      map['energy_mood'] = Variable<int>(energyMood.value);
    }
    if (fatigue.present) {
      map['fatigue'] = Variable<int>(fatigue.value);
    }
    if (pain.present) {
      map['pain'] = Variable<int>(pain.value);
    }
    if (sleepQuality.present) {
      map['sleep_quality'] = Variable<int>(sleepQuality.value);
    }
    if (fluidIntake.present) {
      map['fluid_intake'] = Variable<int>(fluidIntake.value);
    }
    if (fluidOutput.present) {
      map['fluid_output'] = Variable<int>(fluidOutput.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyHealthLogsCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('systolic: $systolic, ')
          ..write('diastolic: $diastolic, ')
          ..write('energyMood: $energyMood, ')
          ..write('fatigue: $fatigue, ')
          ..write('pain: $pain, ')
          ..write('sleepQuality: $sleepQuality, ')
          ..write('fluidIntake: $fluidIntake, ')
          ..write('fluidOutput: $fluidOutput, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PatientsTable patients = $PatientsTable(this);
  late final $LabTestsTable labTests = $LabTestsTable(this);
  late final $LabResultsTable labResults = $LabResultsTable(this);
  late final $SymptomLogsTable symptomLogs = $SymptomLogsTable(this);
  late final $DailyHealthLogsTable dailyHealthLogs =
      $DailyHealthLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [patients, labTests, labResults, symptomLogs, dailyHealthLogs];
}

typedef $$PatientsTableCreateCompanionBuilder = PatientsCompanion Function({
  Value<int> id,
  required String firstName,
  required String lastName,
  Value<DateTime?> dateOfBirth,
  Value<String?> gender,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$PatientsTableUpdateCompanionBuilder = PatientsCompanion Function({
  Value<int> id,
  Value<String> firstName,
  Value<String> lastName,
  Value<DateTime?> dateOfBirth,
  Value<String?> gender,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$PatientsTableReferences
    extends BaseReferences<_$AppDatabase, $PatientsTable, Patient> {
  $$PatientsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$LabResultsTable, List<LabResult>>
      _labResultsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
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

  static MultiTypedResultKey<$SymptomLogsTable, List<SymptomLog>>
      _symptomLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.symptomLogs,
          aliasName:
              $_aliasNameGenerator(db.patients.id, db.symptomLogs.patientId));

  $$SymptomLogsTableProcessedTableManager get symptomLogsRefs {
    final manager = $$SymptomLogsTableTableManager($_db, $_db.symptomLogs)
        .filter((f) => f.patientId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_symptomLogsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$DailyHealthLogsTable, List<DailyHealthLog>>
      _dailyHealthLogsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.dailyHealthLogs,
              aliasName: $_aliasNameGenerator(
                  db.patients.id, db.dailyHealthLogs.patientId));

  $$DailyHealthLogsTableProcessedTableManager get dailyHealthLogsRefs {
    final manager =
        $$DailyHealthLogsTableTableManager($_db, $_db.dailyHealthLogs)
            .filter((f) => f.patientId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_dailyHealthLogsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PatientsTableFilterComposer
    extends Composer<_$AppDatabase, $PatientsTable> {
  $$PatientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get firstName => $composableBuilder(
      column: $table.firstName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

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

  Expression<bool> symptomLogsRefs(
      Expression<bool> Function($$SymptomLogsTableFilterComposer f) f) {
    final $$SymptomLogsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.symptomLogs,
        getReferencedColumn: (t) => t.patientId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SymptomLogsTableFilterComposer(
              $db: $db,
              $table: $db.symptomLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> dailyHealthLogsRefs(
      Expression<bool> Function($$DailyHealthLogsTableFilterComposer f) f) {
    final $$DailyHealthLogsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dailyHealthLogs,
        getReferencedColumn: (t) => t.patientId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DailyHealthLogsTableFilterComposer(
              $db: $db,
              $table: $db.dailyHealthLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PatientsTableOrderingComposer
    extends Composer<_$AppDatabase, $PatientsTable> {
  $$PatientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get firstName => $composableBuilder(
      column: $table.firstName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$PatientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PatientsTable> {
  $$PatientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<DateTime> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

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

  Expression<T> symptomLogsRefs<T extends Object>(
      Expression<T> Function($$SymptomLogsTableAnnotationComposer a) f) {
    final $$SymptomLogsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.symptomLogs,
        getReferencedColumn: (t) => t.patientId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SymptomLogsTableAnnotationComposer(
              $db: $db,
              $table: $db.symptomLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> dailyHealthLogsRefs<T extends Object>(
      Expression<T> Function($$DailyHealthLogsTableAnnotationComposer a) f) {
    final $$DailyHealthLogsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dailyHealthLogs,
        getReferencedColumn: (t) => t.patientId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DailyHealthLogsTableAnnotationComposer(
              $db: $db,
              $table: $db.dailyHealthLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PatientsTableTableManager extends RootTableManager<
    _$AppDatabase,
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
        {bool labResultsRefs,
        bool symptomLogsRefs,
        bool dailyHealthLogsRefs})> {
  $$PatientsTableTableManager(_$AppDatabase db, $PatientsTable table)
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
            Value<String> firstName = const Value.absent(),
            Value<String> lastName = const Value.absent(),
            Value<DateTime?> dateOfBirth = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              PatientsCompanion(
            id: id,
            firstName: firstName,
            lastName: lastName,
            dateOfBirth: dateOfBirth,
            gender: gender,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String firstName,
            required String lastName,
            Value<DateTime?> dateOfBirth = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              PatientsCompanion.insert(
            id: id,
            firstName: firstName,
            lastName: lastName,
            dateOfBirth: dateOfBirth,
            gender: gender,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PatientsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {labResultsRefs = false,
              symptomLogsRefs = false,
              dailyHealthLogsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (labResultsRefs) db.labResults,
                if (symptomLogsRefs) db.symptomLogs,
                if (dailyHealthLogsRefs) db.dailyHealthLogs
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
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
                  if (symptomLogsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$PatientsTableReferences._symptomLogsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PatientsTableReferences(db, table, p0)
                                .symptomLogsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.patientId == item.id),
                        typedResults: items),
                  if (dailyHealthLogsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$PatientsTableReferences
                            ._dailyHealthLogsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PatientsTableReferences(db, table, p0)
                                .dailyHealthLogsRefs,
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
    _$AppDatabase,
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
        {bool labResultsRefs, bool symptomLogsRefs, bool dailyHealthLogsRefs})>;
typedef $$LabTestsTableCreateCompanionBuilder = LabTestsCompanion Function({
  Value<int> id,
  required String testName,
  required String category,
  Value<String?> unit,
  Value<String?> normalRange,
  Value<String?> description,
  Value<DateTime> createdAt,
});
typedef $$LabTestsTableUpdateCompanionBuilder = LabTestsCompanion Function({
  Value<int> id,
  Value<String> testName,
  Value<String> category,
  Value<String?> unit,
  Value<String?> normalRange,
  Value<String?> description,
  Value<DateTime> createdAt,
});

final class $$LabTestsTableReferences
    extends BaseReferences<_$AppDatabase, $LabTestsTable, LabTest> {
  $$LabTestsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$LabResultsTable, List<LabResult>>
      _labResultsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.labResults,
          aliasName:
              $_aliasNameGenerator(db.labTests.id, db.labResults.labTestId));

  $$LabResultsTableProcessedTableManager get labResultsRefs {
    final manager = $$LabResultsTableTableManager($_db, $_db.labResults)
        .filter((f) => f.labTestId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_labResultsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$LabTestsTableFilterComposer
    extends Composer<_$AppDatabase, $LabTestsTable> {
  $$LabTestsTableFilterComposer({
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

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get normalRange => $composableBuilder(
      column: $table.normalRange, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> labResultsRefs(
      Expression<bool> Function($$LabResultsTableFilterComposer f) f) {
    final $$LabResultsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.labResults,
        getReferencedColumn: (t) => t.labTestId,
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
}

class $$LabTestsTableOrderingComposer
    extends Composer<_$AppDatabase, $LabTestsTable> {
  $$LabTestsTableOrderingComposer({
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

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get normalRange => $composableBuilder(
      column: $table.normalRange, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$LabTestsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LabTestsTable> {
  $$LabTestsTableAnnotationComposer({
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

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get normalRange => $composableBuilder(
      column: $table.normalRange, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> labResultsRefs<T extends Object>(
      Expression<T> Function($$LabResultsTableAnnotationComposer a) f) {
    final $$LabResultsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.labResults,
        getReferencedColumn: (t) => t.labTestId,
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
}

class $$LabTestsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LabTestsTable,
    LabTest,
    $$LabTestsTableFilterComposer,
    $$LabTestsTableOrderingComposer,
    $$LabTestsTableAnnotationComposer,
    $$LabTestsTableCreateCompanionBuilder,
    $$LabTestsTableUpdateCompanionBuilder,
    (LabTest, $$LabTestsTableReferences),
    LabTest,
    PrefetchHooks Function({bool labResultsRefs})> {
  $$LabTestsTableTableManager(_$AppDatabase db, $LabTestsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LabTestsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LabTestsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LabTestsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> testName = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String?> unit = const Value.absent(),
            Value<String?> normalRange = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              LabTestsCompanion(
            id: id,
            testName: testName,
            category: category,
            unit: unit,
            normalRange: normalRange,
            description: description,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String testName,
            required String category,
            Value<String?> unit = const Value.absent(),
            Value<String?> normalRange = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              LabTestsCompanion.insert(
            id: id,
            testName: testName,
            category: category,
            unit: unit,
            normalRange: normalRange,
            description: description,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$LabTestsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({labResultsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (labResultsRefs) db.labResults],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (labResultsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$LabTestsTableReferences._labResultsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LabTestsTableReferences(db, table, p0)
                                .labResultsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.labTestId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$LabTestsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LabTestsTable,
    LabTest,
    $$LabTestsTableFilterComposer,
    $$LabTestsTableOrderingComposer,
    $$LabTestsTableAnnotationComposer,
    $$LabTestsTableCreateCompanionBuilder,
    $$LabTestsTableUpdateCompanionBuilder,
    (LabTest, $$LabTestsTableReferences),
    LabTest,
    PrefetchHooks Function({bool labResultsRefs})>;
typedef $$LabResultsTableCreateCompanionBuilder = LabResultsCompanion Function({
  Value<int> id,
  required int patientId,
  required int labTestId,
  required double value,
  Value<String?> status,
  required DateTime testDate,
  Value<String?> notes,
  Value<DateTime> createdAt,
});
typedef $$LabResultsTableUpdateCompanionBuilder = LabResultsCompanion Function({
  Value<int> id,
  Value<int> patientId,
  Value<int> labTestId,
  Value<double> value,
  Value<String?> status,
  Value<DateTime> testDate,
  Value<String?> notes,
  Value<DateTime> createdAt,
});

final class $$LabResultsTableReferences
    extends BaseReferences<_$AppDatabase, $LabResultsTable, LabResult> {
  $$LabResultsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PatientsTable _patientIdTable(_$AppDatabase db) =>
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

  static $LabTestsTable _labTestIdTable(_$AppDatabase db) =>
      db.labTests.createAlias(
          $_aliasNameGenerator(db.labResults.labTestId, db.labTests.id));

  $$LabTestsTableProcessedTableManager? get labTestId {
    if ($_item.labTestId == null) return null;
    final manager = $$LabTestsTableTableManager($_db, $_db.labTests)
        .filter((f) => f.id($_item.labTestId!));
    final item = $_typedResult.readTableOrNull(_labTestIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$LabResultsTableFilterComposer
    extends Composer<_$AppDatabase, $LabResultsTable> {
  $$LabResultsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get testDate => $composableBuilder(
      column: $table.testDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

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

  $$LabTestsTableFilterComposer get labTestId {
    final $$LabTestsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.labTestId,
        referencedTable: $db.labTests,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LabTestsTableFilterComposer(
              $db: $db,
              $table: $db.labTests,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LabResultsTableOrderingComposer
    extends Composer<_$AppDatabase, $LabResultsTable> {
  $$LabResultsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get testDate => $composableBuilder(
      column: $table.testDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

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

  $$LabTestsTableOrderingComposer get labTestId {
    final $$LabTestsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.labTestId,
        referencedTable: $db.labTests,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LabTestsTableOrderingComposer(
              $db: $db,
              $table: $db.labTests,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LabResultsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LabResultsTable> {
  $$LabResultsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get testDate =>
      $composableBuilder(column: $table.testDate, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

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

  $$LabTestsTableAnnotationComposer get labTestId {
    final $$LabTestsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.labTestId,
        referencedTable: $db.labTests,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LabTestsTableAnnotationComposer(
              $db: $db,
              $table: $db.labTests,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LabResultsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LabResultsTable,
    LabResult,
    $$LabResultsTableFilterComposer,
    $$LabResultsTableOrderingComposer,
    $$LabResultsTableAnnotationComposer,
    $$LabResultsTableCreateCompanionBuilder,
    $$LabResultsTableUpdateCompanionBuilder,
    (LabResult, $$LabResultsTableReferences),
    LabResult,
    PrefetchHooks Function({bool patientId, bool labTestId})> {
  $$LabResultsTableTableManager(_$AppDatabase db, $LabResultsTable table)
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
            Value<int> labTestId = const Value.absent(),
            Value<double> value = const Value.absent(),
            Value<String?> status = const Value.absent(),
            Value<DateTime> testDate = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              LabResultsCompanion(
            id: id,
            patientId: patientId,
            labTestId: labTestId,
            value: value,
            status: status,
            testDate: testDate,
            notes: notes,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int patientId,
            required int labTestId,
            required double value,
            Value<String?> status = const Value.absent(),
            required DateTime testDate,
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              LabResultsCompanion.insert(
            id: id,
            patientId: patientId,
            labTestId: labTestId,
            value: value,
            status: status,
            testDate: testDate,
            notes: notes,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LabResultsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({patientId = false, labTestId = false}) {
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
                if (labTestId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.labTestId,
                    referencedTable:
                        $$LabResultsTableReferences._labTestIdTable(db),
                    referencedColumn:
                        $$LabResultsTableReferences._labTestIdTable(db).id,
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
    _$AppDatabase,
    $LabResultsTable,
    LabResult,
    $$LabResultsTableFilterComposer,
    $$LabResultsTableOrderingComposer,
    $$LabResultsTableAnnotationComposer,
    $$LabResultsTableCreateCompanionBuilder,
    $$LabResultsTableUpdateCompanionBuilder,
    (LabResult, $$LabResultsTableReferences),
    LabResult,
    PrefetchHooks Function({bool patientId, bool labTestId})>;
typedef $$SymptomLogsTableCreateCompanionBuilder = SymptomLogsCompanion
    Function({
  Value<int> id,
  required int patientId,
  required String symptom,
  required int severity,
  Value<String?> description,
  required DateTime logDate,
  Value<DateTime> createdAt,
});
typedef $$SymptomLogsTableUpdateCompanionBuilder = SymptomLogsCompanion
    Function({
  Value<int> id,
  Value<int> patientId,
  Value<String> symptom,
  Value<int> severity,
  Value<String?> description,
  Value<DateTime> logDate,
  Value<DateTime> createdAt,
});

final class $$SymptomLogsTableReferences
    extends BaseReferences<_$AppDatabase, $SymptomLogsTable, SymptomLog> {
  $$SymptomLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PatientsTable _patientIdTable(_$AppDatabase db) =>
      db.patients.createAlias(
          $_aliasNameGenerator(db.symptomLogs.patientId, db.patients.id));

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

class $$SymptomLogsTableFilterComposer
    extends Composer<_$AppDatabase, $SymptomLogsTable> {
  $$SymptomLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get symptom => $composableBuilder(
      column: $table.symptom, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get severity => $composableBuilder(
      column: $table.severity, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get logDate => $composableBuilder(
      column: $table.logDate, builder: (column) => ColumnFilters(column));

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

class $$SymptomLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $SymptomLogsTable> {
  $$SymptomLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get symptom => $composableBuilder(
      column: $table.symptom, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get severity => $composableBuilder(
      column: $table.severity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get logDate => $composableBuilder(
      column: $table.logDate, builder: (column) => ColumnOrderings(column));

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

class $$SymptomLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SymptomLogsTable> {
  $$SymptomLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get symptom =>
      $composableBuilder(column: $table.symptom, builder: (column) => column);

  GeneratedColumn<int> get severity =>
      $composableBuilder(column: $table.severity, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get logDate =>
      $composableBuilder(column: $table.logDate, builder: (column) => column);

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

class $$SymptomLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SymptomLogsTable,
    SymptomLog,
    $$SymptomLogsTableFilterComposer,
    $$SymptomLogsTableOrderingComposer,
    $$SymptomLogsTableAnnotationComposer,
    $$SymptomLogsTableCreateCompanionBuilder,
    $$SymptomLogsTableUpdateCompanionBuilder,
    (SymptomLog, $$SymptomLogsTableReferences),
    SymptomLog,
    PrefetchHooks Function({bool patientId})> {
  $$SymptomLogsTableTableManager(_$AppDatabase db, $SymptomLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SymptomLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SymptomLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SymptomLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> patientId = const Value.absent(),
            Value<String> symptom = const Value.absent(),
            Value<int> severity = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime> logDate = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              SymptomLogsCompanion(
            id: id,
            patientId: patientId,
            symptom: symptom,
            severity: severity,
            description: description,
            logDate: logDate,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int patientId,
            required String symptom,
            required int severity,
            Value<String?> description = const Value.absent(),
            required DateTime logDate,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              SymptomLogsCompanion.insert(
            id: id,
            patientId: patientId,
            symptom: symptom,
            severity: severity,
            description: description,
            logDate: logDate,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SymptomLogsTableReferences(db, table, e)
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
                        $$SymptomLogsTableReferences._patientIdTable(db),
                    referencedColumn:
                        $$SymptomLogsTableReferences._patientIdTable(db).id,
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

typedef $$SymptomLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SymptomLogsTable,
    SymptomLog,
    $$SymptomLogsTableFilterComposer,
    $$SymptomLogsTableOrderingComposer,
    $$SymptomLogsTableAnnotationComposer,
    $$SymptomLogsTableCreateCompanionBuilder,
    $$SymptomLogsTableUpdateCompanionBuilder,
    (SymptomLog, $$SymptomLogsTableReferences),
    SymptomLog,
    PrefetchHooks Function({bool patientId})>;
typedef $$DailyHealthLogsTableCreateCompanionBuilder = DailyHealthLogsCompanion
    Function({
  Value<int> id,
  required int patientId,
  required DateTime loggedAt,
  Value<int?> systolic,
  Value<int?> diastolic,
  Value<int?> energyMood,
  Value<int?> fatigue,
  Value<int?> pain,
  Value<int?> sleepQuality,
  Value<int?> fluidIntake,
  Value<int?> fluidOutput,
  Value<String?> notes,
  Value<DateTime> createdAt,
});
typedef $$DailyHealthLogsTableUpdateCompanionBuilder = DailyHealthLogsCompanion
    Function({
  Value<int> id,
  Value<int> patientId,
  Value<DateTime> loggedAt,
  Value<int?> systolic,
  Value<int?> diastolic,
  Value<int?> energyMood,
  Value<int?> fatigue,
  Value<int?> pain,
  Value<int?> sleepQuality,
  Value<int?> fluidIntake,
  Value<int?> fluidOutput,
  Value<String?> notes,
  Value<DateTime> createdAt,
});

final class $$DailyHealthLogsTableReferences extends BaseReferences<
    _$AppDatabase, $DailyHealthLogsTable, DailyHealthLog> {
  $$DailyHealthLogsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PatientsTable _patientIdTable(_$AppDatabase db) =>
      db.patients.createAlias(
          $_aliasNameGenerator(db.dailyHealthLogs.patientId, db.patients.id));

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

class $$DailyHealthLogsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyHealthLogsTable> {
  $$DailyHealthLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get loggedAt => $composableBuilder(
      column: $table.loggedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get systolic => $composableBuilder(
      column: $table.systolic, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get diastolic => $composableBuilder(
      column: $table.diastolic, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get energyMood => $composableBuilder(
      column: $table.energyMood, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get fatigue => $composableBuilder(
      column: $table.fatigue, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get pain => $composableBuilder(
      column: $table.pain, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sleepQuality => $composableBuilder(
      column: $table.sleepQuality, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get fluidIntake => $composableBuilder(
      column: $table.fluidIntake, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get fluidOutput => $composableBuilder(
      column: $table.fluidOutput, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

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

class $$DailyHealthLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyHealthLogsTable> {
  $$DailyHealthLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get loggedAt => $composableBuilder(
      column: $table.loggedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get systolic => $composableBuilder(
      column: $table.systolic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get diastolic => $composableBuilder(
      column: $table.diastolic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get energyMood => $composableBuilder(
      column: $table.energyMood, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get fatigue => $composableBuilder(
      column: $table.fatigue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get pain => $composableBuilder(
      column: $table.pain, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sleepQuality => $composableBuilder(
      column: $table.sleepQuality,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get fluidIntake => $composableBuilder(
      column: $table.fluidIntake, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get fluidOutput => $composableBuilder(
      column: $table.fluidOutput, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

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

class $$DailyHealthLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyHealthLogsTable> {
  $$DailyHealthLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);

  GeneratedColumn<int> get systolic =>
      $composableBuilder(column: $table.systolic, builder: (column) => column);

  GeneratedColumn<int> get diastolic =>
      $composableBuilder(column: $table.diastolic, builder: (column) => column);

  GeneratedColumn<int> get energyMood => $composableBuilder(
      column: $table.energyMood, builder: (column) => column);

  GeneratedColumn<int> get fatigue =>
      $composableBuilder(column: $table.fatigue, builder: (column) => column);

  GeneratedColumn<int> get pain =>
      $composableBuilder(column: $table.pain, builder: (column) => column);

  GeneratedColumn<int> get sleepQuality => $composableBuilder(
      column: $table.sleepQuality, builder: (column) => column);

  GeneratedColumn<int> get fluidIntake => $composableBuilder(
      column: $table.fluidIntake, builder: (column) => column);

  GeneratedColumn<int> get fluidOutput => $composableBuilder(
      column: $table.fluidOutput, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

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

class $$DailyHealthLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DailyHealthLogsTable,
    DailyHealthLog,
    $$DailyHealthLogsTableFilterComposer,
    $$DailyHealthLogsTableOrderingComposer,
    $$DailyHealthLogsTableAnnotationComposer,
    $$DailyHealthLogsTableCreateCompanionBuilder,
    $$DailyHealthLogsTableUpdateCompanionBuilder,
    (DailyHealthLog, $$DailyHealthLogsTableReferences),
    DailyHealthLog,
    PrefetchHooks Function({bool patientId})> {
  $$DailyHealthLogsTableTableManager(
      _$AppDatabase db, $DailyHealthLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyHealthLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyHealthLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyHealthLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> patientId = const Value.absent(),
            Value<DateTime> loggedAt = const Value.absent(),
            Value<int?> systolic = const Value.absent(),
            Value<int?> diastolic = const Value.absent(),
            Value<int?> energyMood = const Value.absent(),
            Value<int?> fatigue = const Value.absent(),
            Value<int?> pain = const Value.absent(),
            Value<int?> sleepQuality = const Value.absent(),
            Value<int?> fluidIntake = const Value.absent(),
            Value<int?> fluidOutput = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              DailyHealthLogsCompanion(
            id: id,
            patientId: patientId,
            loggedAt: loggedAt,
            systolic: systolic,
            diastolic: diastolic,
            energyMood: energyMood,
            fatigue: fatigue,
            pain: pain,
            sleepQuality: sleepQuality,
            fluidIntake: fluidIntake,
            fluidOutput: fluidOutput,
            notes: notes,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int patientId,
            required DateTime loggedAt,
            Value<int?> systolic = const Value.absent(),
            Value<int?> diastolic = const Value.absent(),
            Value<int?> energyMood = const Value.absent(),
            Value<int?> fatigue = const Value.absent(),
            Value<int?> pain = const Value.absent(),
            Value<int?> sleepQuality = const Value.absent(),
            Value<int?> fluidIntake = const Value.absent(),
            Value<int?> fluidOutput = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              DailyHealthLogsCompanion.insert(
            id: id,
            patientId: patientId,
            loggedAt: loggedAt,
            systolic: systolic,
            diastolic: diastolic,
            energyMood: energyMood,
            fatigue: fatigue,
            pain: pain,
            sleepQuality: sleepQuality,
            fluidIntake: fluidIntake,
            fluidOutput: fluidOutput,
            notes: notes,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DailyHealthLogsTableReferences(db, table, e)
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
                        $$DailyHealthLogsTableReferences._patientIdTable(db),
                    referencedColumn:
                        $$DailyHealthLogsTableReferences._patientIdTable(db).id,
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

typedef $$DailyHealthLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DailyHealthLogsTable,
    DailyHealthLog,
    $$DailyHealthLogsTableFilterComposer,
    $$DailyHealthLogsTableOrderingComposer,
    $$DailyHealthLogsTableAnnotationComposer,
    $$DailyHealthLogsTableCreateCompanionBuilder,
    $$DailyHealthLogsTableUpdateCompanionBuilder,
    (DailyHealthLog, $$DailyHealthLogsTableReferences),
    DailyHealthLog,
    PrefetchHooks Function({bool patientId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PatientsTableTableManager get patients =>
      $$PatientsTableTableManager(_db, _db.patients);
  $$LabTestsTableTableManager get labTests =>
      $$LabTestsTableTableManager(_db, _db.labTests);
  $$LabResultsTableTableManager get labResults =>
      $$LabResultsTableTableManager(_db, _db.labResults);
  $$SymptomLogsTableTableManager get symptomLogs =>
      $$SymptomLogsTableTableManager(_db, _db.symptomLogs);
  $$DailyHealthLogsTableTableManager get dailyHealthLogs =>
      $$DailyHealthLogsTableTableManager(_db, _db.dailyHealthLogs);
}
