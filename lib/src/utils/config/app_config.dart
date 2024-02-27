enum AppMode { prod, dev }

class AppConfig {
  AppConfig({
    required this.appName,
    required this.appMode,
  });

  final String appName;
  final AppMode appMode;
}
