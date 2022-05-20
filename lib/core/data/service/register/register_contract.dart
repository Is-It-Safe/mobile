import 'package:is_it_safe_app/core/model/Gender.dart';
import 'package:is_it_safe_app/core/model/SexualOrientation.dart';
import 'package:is_it_safe_app/core/model/User.dart';

abstract class RegisterContract {
  Future<Map<String, dynamic>> registerUser({required User user});
  Future<List<Gender>> getGenders();
  Future<List<SexualOrientation>> getSexualOrientations();
}