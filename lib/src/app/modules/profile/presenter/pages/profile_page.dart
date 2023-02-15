import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/profile/presenter/bloc/profile_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/profile/presenter/widgets/profile_header.dart';
import 'package:is_it_safe_app/src/app/modules/profile/presenter/widgets/profile_reviews_list.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';

class ProfilePage extends StatefulWidget {
  static const route = '/profile/';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ModularState<ProfilePage, ProfileBloc> {
  @override
  void initState() {
    super.initState();
    SafeLogUtil.instance.route(Modular.to.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 24.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileHeader(controller: controller),
              const SizedBox(height: 40.0),
              Text(
                S.current.textYourReviews,
                style: TextStyles.headline3(),
              ),
              ProfileReviewsList(controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}
