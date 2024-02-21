import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:my_wheater_app/app/app.dart';
import 'package:my_wheater_app/bootstrap.dart';
import 'package:my_wheater_app/infrastructure/core/config/env_config.dart';
import 'package:my_wheater_app/infrastructure/core/config/flavor.dart';

void main() {
  FlavorSettings.development();

  ///[console] flavor running
  if (!kReleaseMode) {
    final settings = EnvConfig.getInstance();
    log('🚀 APP FLAVOR NAME      : ${settings.flavorName}', name: 'ENV');
    log('🚀 APP API_BASE_URL     : ${settings.apiBaseUrl}', name: 'ENV');
  }
  bootstrap(() => const App());
}
