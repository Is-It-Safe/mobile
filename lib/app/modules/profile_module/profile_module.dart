import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/profile_module/profile_bloc.dart';
import 'package:is_it_safe_app/app/modules/profile_module/profile_widget.dart';

class ProfileModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ProfileBloc()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => const ProfileWidget()),
  ];
}
