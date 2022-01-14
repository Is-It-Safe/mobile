import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/home_module/home_bloc.dart';
import 'package:is_it_safe_app/app/modules/home_module/home_widget.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
    Bind.lazySingleton((i) => HomeBloc())
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context,args) => HomeWidget())
  ];
}