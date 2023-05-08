import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/services/auth_service.dart';
import 'package:is_it_safe_app/src/app/modules/location/review/presenter/bloc/review_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/location/review/presenter/pages/review_page.dart';
import 'package:is_it_safe_app/src/app/modules/location/services/location_service.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/usecases/save_review_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/profile/services/profile_service.dart';

class ReviewModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LocationService(i.get<AuthService>())),
    Bind.lazySingleton((i) => SaveReviewUseCase(i.get<ProfileService>())),
    Bind.lazySingleton(
      (i) => ReviewBloc(
        saveReviewUseCase: i.get<SaveReviewUseCase>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => ReviewPage(location: args.data),
    ),
  ];
}
