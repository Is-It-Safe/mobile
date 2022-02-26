import 'package:flutter_test/flutter_test.dart';
import 'package:is_it_safe_app/app/modules/main_module/modules/search_module/search_bloc.dart';

Future<void> main() async {
  final bloc = SearchBloc();

  await bloc.getAllPlaces();

  print(bloc.places.isNotEmpty);
  print(bloc.places);
  print(bloc.places[1].endereco);
}
