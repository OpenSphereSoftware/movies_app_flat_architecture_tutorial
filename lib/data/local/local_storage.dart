import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

final rxSharedPreferencesProvider = Provider((_) => RxSharedPreferences(
      SharedPreferences.getInstance(),
      kReleaseMode ? null : const RxSharedPreferencesDefaultLogger(),
      // disable logging when running in release mode.
    ));
