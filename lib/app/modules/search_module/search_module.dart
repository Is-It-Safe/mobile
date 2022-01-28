import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/search_module/search_bloc.dart';

import 'search_widget.dart';

class SearchModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SearchBloc()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => const SearchWidget()),
  ];
}
