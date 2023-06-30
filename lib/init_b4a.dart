import 'package:parse_server_sdk/parse_server_sdk.dart';

Future<bool> initB4AFluxus() async {
  const keyApplicationId = '41khDEwc9OeEDclYQ9UnT2HEmysZ2E5JG5534qsp';
  const keyClientKey = 'Ha2Cr0rF2iHTCiJFyeadmwMY6wTVmDw4R9W2Mu6O';
  // const keyApplicationId = String.fromEnvironment('ApplicationId');
  // const keyClientKey = String.fromEnvironment('ClientKey');
  const keyServerUrl = 'https://parseapi.back4app.com';
  await Parse().initialize(
    keyApplicationId,
    keyServerUrl,
    clientKey: keyClientKey,
    // debug: true,
  );
  ParseResponse healthCheck = (await Parse().healthCheck());
  if (healthCheck.success) {
    return true;
  } else {
    return false;
  }
}

Future<bool> initB4AFluxus3() async {
  const keyApplicationId = 'DJORW0khdQmM9ZrmDt2gKOrVfPHdYFlJkRRY51I1';
  const keyClientKey = '1a84GqtZaTHeVs1UL3UknN0qqcDmfFnwG3LxL2v6';
  // const keyApplicationId = String.fromEnvironment('ApplicationId');
  // const keyClientKey = String.fromEnvironment('ClientKey');
  const keyServerUrl = 'https://parseapi.back4app.com';
  await Parse().initialize(
    keyApplicationId,
    keyServerUrl,
    clientKey: keyClientKey,
    // debug: true,
  );
  ParseResponse healthCheck = (await Parse().healthCheck());
  if (healthCheck.success) {
    return true;
  } else {
    return false;
  }
}
