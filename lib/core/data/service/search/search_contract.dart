import 'package:is_it_safe_app/core/model/Location.dart';

abstract class SearchContract {
  Future<List<Content>> getLocation(String search);
}