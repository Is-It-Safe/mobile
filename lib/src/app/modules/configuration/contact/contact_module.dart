import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/contact/presenter/bloc/contact_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/contact/presenter/pages/contact_page.dart';
import 'package:is_it_safe_app/src/app/modules/home/domain/usecases/get_user_name_use_case.dart';

class ContactModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ContactBloc(
          getUserNameUseCase: i.get<GetUserNameUseCase>(),
        )),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const ContactPage(),
    ),
  ];
}
