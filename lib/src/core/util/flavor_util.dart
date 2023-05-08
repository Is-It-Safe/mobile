import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/service/api/constants/api_constants.dart';

enum FlavorEnum { dev, prod }

extension FlavorEnumExtension on FlavorEnum {
  String get name => toString().split(StringConstants.dot)[1];
}

class FlavorUtil {
  final String appName;
  final FlavorEnum? flavor;
  final Color bannerColor;
  final BannerLocation bannerLocation;
  final String url;

  FlavorUtil._internal({
    this.flavor,
    this.appName = StringConstants.appName,
    required this.bannerColor,
    required this.bannerLocation,
    required this.url,
  });

  static FlavorUtil? _instance;

  static FlavorUtil get instance {
    return _instance ??= FlavorUtil();
  }

  static bool get isProduction {
    return FlavorUtil.instance.flavor == FlavorEnum.prod;
  }

  static bool get isDevelopment {
    return FlavorUtil.instance.flavor == FlavorEnum.dev;
  }

  static FlavorUtil get prod {
    return FlavorUtil(
      flavor: FlavorEnum.prod,
      bannerColor: Colors.green,
      url: ApiConstants.kProductionUrl,
    );
  }

  static FlavorUtil get dev {
    return FlavorUtil(
      flavor: FlavorEnum.dev,
      bannerColor: Colors.red,
      url: ApiConstants.kDevelopUrl,
    );
  }

  static FlavorUtil get platformFlavor {
    String flavor = const String.fromEnvironment('flavor');
    switch (flavor) {
      case 'prod':
        return prod;
      default:
        return dev;
    }
  }

  static void setup(FlavorUtil flavor) => _instance = flavor;

  factory FlavorUtil({
    FlavorEnum? flavor,
    String appName = StringConstants.appName,
    Color bannerColor = Colors.red,
    BannerLocation bannerLocation = BannerLocation.topStart,
    String url = ApiConstants.kDevelopUrl,
  }) {
    return _instance = FlavorUtil._internal(
      flavor: flavor,
      bannerColor: bannerColor,
      bannerLocation: bannerLocation,
      url: url,
      appName: appName,
    );
  }
}
