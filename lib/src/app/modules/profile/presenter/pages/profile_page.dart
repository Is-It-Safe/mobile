import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/app/modules/profile/presenter/widgets/profile_header_widget.dart';
import 'package:is_it_safe_app/src/app/modules/profile/presenter/widgets/profile_review_list_widget.dart';
import 'package:is_it_safe_app/src/core/state/safe_state.dart';
import 'package:is_it_safe_app/src/l10n/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/profile/presenter/bloc/profile_bloc.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';

class ProfilePage extends StatefulWidget {
  static const route = '/profile/';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends SafeState<ProfilePage, ProfileBloc> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileHeaderWidget(user: bloc.user),
              const SizedBox(height: 40.0),
              Text(
                S.current.textYourReviews,
                style: TextStyles.headline3(),
              ),
              ProfileReviewListWidget(
                user: bloc.user,
                messageDeleteReview: bloc.messageDeleteReview,
                deleteReview: (id) => bloc.deleteReview(idReview: id),
                shareReview: (id) => bloc.shareReview(idReview: id),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
