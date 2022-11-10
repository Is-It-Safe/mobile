import 'package:is_it_safe_app/src/service/api/modules/profile/response/response_delete_user.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/response/response_get_user.dart';

abstract class IProfileService {
  Future<ResponseGetUser> getUser();
  Future<ResponseDeleteUser> deleteUser(int idUser);
}
