import 'package:my_wheater_app/infrastructure/core/config/env_config.dart';

/// * This file is configuration to make separate between environment
/// see details about [flutter flavor]
class FlavorSettings {
  FlavorSettings.development() {
    EnvConfig.getInstance(
      flavorName: 'development',
      apiBaseUrl: 'https://api.openweathermap.org/data/2.5',
    );
  }

  FlavorSettings.staging() {
    EnvConfig.getInstance(
      flavorName: 'staging',
      apiBaseUrl: 'https://api.openweathermap.org/data/2.5',
    );
  }

  FlavorSettings.production() {
    EnvConfig.getInstance(
      flavorName: 'production',
      apiBaseUrl: 'https://api.openweathermap.org/data/2.5',
    );
  }
}
