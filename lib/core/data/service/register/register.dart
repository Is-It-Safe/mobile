import 'package:is_it_safe_app/core/data/service/api.dart';
import 'package:is_it_safe_app/core/data/service/register/register_contract.dart';
import 'package:is_it_safe_app/core/model/Gender.dart';
import 'package:is_it_safe_app/core/model/SexualOrientation.dart';
import 'package:is_it_safe_app/core/model/User.dart';

class RegisterService implements RegisterContract {
  final APIService _service = APIService();

  @override
  Future<Map<String, dynamic>> registerUser({required User user}) async {
    final _response = await _service.doRequest(
      RequestConfig(
        'user/save',
        HttpMethod.post,
        body: user.toJson(),
      ),
    );

    return _response;
  }

  @override
  Future<List<Gender>> getGenders() async {
    final _response = await _service.doRequest(
      RequestConfig(
        'gender/find-all',
        HttpMethod.get,
      ),
    );

    List<Gender> _genders =
        (_response as List).map((e) => Gender.fromJson(e)).toList();
    return _genders;
  }

  @override
  Future<List<SexualOrientation>> getSexualOrientations() async {
    final _response = await _service.doRequest(
      RequestConfig(
        'orientation/find-all',
        HttpMethod.get,
      ),
    );

    List<SexualOrientation> _sexualOrientations =
        (_response as List).map((e) => SexualOrientation.fromJson(e)).toList();
    return _sexualOrientations;
  }
}
