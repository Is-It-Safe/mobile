import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/register_module/pages/register_choose_profile_avatar.dart';
import 'package:is_it_safe_app/app/modules/register_module/pages/register_profile_widget.dart';
import 'package:is_it_safe_app/app/modules/register_module/pages/register_widget.dart';
import 'package:is_it_safe_app/app/modules/register_module/register_bloc.dart';
import 'package:is_it_safe_app/core/data/service/register/register.dart';
import 'package:is_it_safe_app/core/utils/constants/routes.dart';

class RegisterModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => RegisterBloc(service: RegisterService())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => const RegisterWidget()),
    ChildRoute(kRouteRegisterProfile,
        child: (context, args) => const RegisterProfileWidget()),
    ChildRoute(kRouteRegisterProfilePicture,
        child: (context, args) => const RegisterChooseProfileAvatarWidget()),
  ];
}
