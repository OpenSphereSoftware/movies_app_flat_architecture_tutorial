import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum Flavor { development, production }

@immutable
class Constants {
  const Constants._({
    required this.endpoint,
    required this.apiKey,
  });

  factory Constants.of() {
    final flavor = EnumToString.fromString(
      Flavor.values,
      const String.fromEnvironment('FLAVOR'),
    );

    switch (flavor) {
      case Flavor.development:
        return Constants._dev();
      case Flavor.production:
      default:
        return Constants._prd();
    }
  }

  factory Constants._dev() {
    return const Constants._(
      endpoint: 'https://api.themoviedb.org',
      apiKey: '82b0d114d3fb9790768a610b2603b527',
    );
  }

  factory Constants._prd() {
    return const Constants._(
      endpoint: 'https://api.themoviedb.org',
      apiKey: '82b0d114d3fb9790768a610b2603b527',
    );
  }

  static late final Constants instance = Constants.of();

  final String endpoint;
  final String apiKey;
}
