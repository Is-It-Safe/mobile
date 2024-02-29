import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ShowVersionApplication extends StatefulWidget {
  const ShowVersionApplication({super.key});

  @override
  State<ShowVersionApplication> createState() => _ShowVersionApplicationState();
}

class _ShowVersionApplicationState extends State<ShowVersionApplication> {

  PackageInfo _packageInfo = PackageInfo(
      appName: 'Unknown', packageName: 'Unknown', version: 'Unknown', buildNumber: 'Unknown');

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }


  @override
  Widget build(BuildContext context) {

    return
      Text('Versão do app: ${_packageInfo.version}', style: TextStyles.emotionalStatus());
  }
}
