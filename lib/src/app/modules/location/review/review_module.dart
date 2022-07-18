import 'package:flutter_modular/flutter_modular.dart';

import 'presenter/bloc/review_bloc.dart';
import 'presenter/pages/review_page.dart';


class ReviewModule extends Module {

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ReviewBloc()),
    Bind.lazySingleton((i) => ReviewService()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) =>  ReviewWidget(args: args.data, )),
  ];

  
}
