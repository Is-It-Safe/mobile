import 'package:flutter_modular/flutter_modular.dart';

class AccountModule extends Module {
  @override
  final List<Bind> binds = [
    // Bind.lazySingleton((i) => HomeService()),
    // Bind.lazySingleton((i) => GetBestRatedLocationsUseCase()),
    // Bind.lazySingleton((i) => HomeBloc(
    //       getBestRatedLocationsUseCase: i.get<GetBestRatedLocationsUseCase>(),
    //     )),
  ];

  @override
  final List<ModularRoute> routes = [
    // ChildRoute(
    //   Modular.initialRoute,
    //   child: (context, args) => const AccountPage(),
    // ),
  ];
}
