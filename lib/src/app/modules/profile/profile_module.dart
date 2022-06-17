import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/use_case/get_user_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/profile/presenter/bloc/profile_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/profile/presenter/pages/profile_page.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/profile_service.dart';

class ProfileModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ProfileService()),
    Bind.lazySingleton((i) => GetUserUseCase()),
    Bind.lazySingleton((i) => ProfileBloc(
          getUserUseCase: i.get<GetUserUseCase>(),
        )),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const ProfilePage(),
    ),
  ];
}
