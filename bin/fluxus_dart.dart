import 'dart:io';

import 'package:fluxus_dart/init_b4a.dart';
import 'package:fluxus_dart/supabase/migrate_patient.dart';

void main(List<String> arguments) async {
  // final isInitialized = await initB4AFluxus();
  final isInitialized = await initB4AFluxus3();
  if (!isInitialized) {
    print('B4A not conected...');
    exit(0);
  } else {
    print('B4A conected...');
  }
  // expertiseFluxus1ToJson();
  // expertiseJsonToFluxus2();
  // patientFluxusToJson();
  // patientJsonToFluxus2();
  // sharedAction01();
  // userProfileAction01();
  // await attendanceAction01();
  // await eventAction01();
  // activityAction01();
  // await patientHealthPlanAction01();
  // await therapyAction01();
  // overbook();
  migratePatient();
}
