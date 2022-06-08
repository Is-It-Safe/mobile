import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/search/domain/use_case/get_locations_by_name_use_case.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';

class SearchBloc extends SafeBloC {
  late final GetLocationsByNameUseCase _getLocationsByNameUseCase;
  SearchBloc() {
    init();
  }

  @override
  Future<void> init() async {
    _getLocationsByNameUseCase = Modular.get<GetLocationsByNameUseCase>();
  }

  @override
  Future<void> dispose() async {}
}
