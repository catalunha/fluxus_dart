import 'dart:io';

import 'package:fluxus_migration/init_b4a.dart';
import 'package:fluxus_migration/patient/patient_actions.dart';

void main(List<String> arguments) async {
  // final isInitialized = await initB4AFluxus();
  final isInitialized = await initB4AFluxus2();
  if (!isInitialized) {
    print('B4A not conected...');
    exit(0);
  } else {
    print('B4A conected...');
  }
  // expertiseFluxus1ToJson();
  // expertiseJsonToFluxus2();
  // patientFluxusToJson();
  patientJsonToFluxus2();
}
