import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class TermsAndConditionsPage extends StatelessWidget {
  static const route = '/terms_and_conditions';
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SafeAppBar(
        title: S.current.textTermsAndConditions,
      ),
      body: SafeArea(
        child: SfPdfViewer.asset('images/terms_and_conditions.pdf'),
      ),
    );
  }
}


