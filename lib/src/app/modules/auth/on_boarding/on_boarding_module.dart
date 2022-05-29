import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/on_boarding/domain/use_case/save_user_on_boarding_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/auth/on_boarding/presenter/bloc/on_boarding_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/auth/on_boarding/presenter/pages/on_boarding_page.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service.dart';

class OnBoardingModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SharedPreferencesService()),
    Bind.lazySingleton((i) => SaveUserOnBoardingUseCase()),
    Bind.lazySingleton((i) => OnBoardingBloc()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const OnBoardingPage(),
    ),
  ];
}
