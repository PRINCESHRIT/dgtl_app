import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/patients.dart';

part 'patients_dao.g.dart';

@DriftAccessor(tables: [Patients])
class PatientsDao extends DatabaseAccessor<AppDatabase> with _$PatientsDaoMixin {
  PatientsDao(AppDatabase db) : super(db);

  // Create a new patient
  Future<int> createPatient(PatientsCompanion patient) async {
    return await into(patients).insert(patient);
  }

  // Get patient by ID
  Future<Patient?> getPatientById(int id) async {
    return await (select(patients)..where((p) => p.id.equals(id))).getSingleOrNull();
  }

  // Get all patients
  Future<List<Patient>> getAllPatients() async {
    return await select(patients).get();
  }

  // Update patient information
  Future<bool> updatePatient(Patient patient) async {
    final updatedPatient = patient.copyWith(updatedAt: DateTime.now());
    return await update(patients).replace(updatedPatient);
  }

  // Delete patient
  Future<int> deletePatient(int id) async {
    return await (delete(patients)..where((p) => p.id.equals(id))).go();
  }

  // Get patients by CKD stage
  Future<List<Patient>> getPatientsByCkdStage(int stage) async {
    return await (select(patients)..where((p) => p.ckdStage.equals(stage))).get();
  }

  // Search patients by name
  Future<List<Patient>> searchPatientsByName(String name) async {
    return await (select(patients)
          ..where((p) => p.name.like('%$name%'))
          ..orderBy([(p) => OrderingTerm.asc(p.name)]))
        .get();
  }

  // Watch patients for reactive UI
  Stream<List<Patient>> watchAllPatients() {
    return select(patients).watch();
  }
}
