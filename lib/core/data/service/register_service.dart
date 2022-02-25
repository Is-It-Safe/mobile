import 'package:is_it_safe_app/core/data/service/config/api_service.dart';
import 'package:is_it_safe_app/core/model/Gender.dart';
import 'package:is_it_safe_app/core/model/SexualOrientation.dart';
import 'package:is_it_safe_app/core/model/User.dart';

class RegisterService {
  final APIService _service = APIService();

  Future registerUser({required User user}) async {
    final _response = await _service.doRequest(
      RequestConfig(
        'user/save',
        HttpMethod.post,
        body: user.toJson(),
      ),
    );

    return _response;
  }

  Future getGenders() async {
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

  Future getSexualOrientations() async {
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
