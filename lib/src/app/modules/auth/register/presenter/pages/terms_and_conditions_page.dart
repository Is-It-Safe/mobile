import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/pages/const_terms_and_conditions.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';

class TermsAndConditionsPage extends StatelessWidget {
  static const route = '/terms_and_conditions';
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SafeAppBar(
        title: S.current.textTermsAndConditions,
      ),
      body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(termsAndConditions),
          )),
    );
  }
}


