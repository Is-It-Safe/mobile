import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/location_service.dart';

import 'presenter/bloc/review_bloc.dart';
import 'presenter/pages/review_page.dart';

class ReviewModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ReviewBloc()),
    Bind.lazySingleton((i) => LocationService()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => ReviewWidget(
        args: args.data,
      ),
    ),
  ];
}
