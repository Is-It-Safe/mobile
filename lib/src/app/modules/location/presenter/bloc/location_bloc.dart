import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_locations_by_id_use_case.dart';

class LocationBloC extends SafeBloC {
  final GetLocationsByIdUseCase getLocationsByIdUseCase;

  LocationBloC({
    required this.getLocationsByIdUseCase,
  });

  Future<void> getLocationById(int id) async {
    try {} catch (e) {}
  }

  @override
  Future<void> init() {
    throw UnimplementedError();
  }

  @override
  Future<void> dispose() {
    throw UnimplementedError();
  }
}
