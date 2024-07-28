import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;

  FirebaseRemoteConfigService(this._remoteConfig);

  Future<void> initialize() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 2),
      ),
    );
    await _remoteConfig.setDefaults({
      'mask_email': true,
    });
    await _remoteConfig.fetchAndActivate();
  }

  bool get maskEmail => _remoteConfig.getBool('mask_email');
}
