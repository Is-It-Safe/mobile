// import 'package:dio/dio.dart';
// import 'package:is_it_safe_app/src/service/api/configuration/api_service.dart';
// import 'package:is_it_safe_app/src/service/api/constants/api_constants.dart';
// import 'package:is_it_safe_app/src/service/api/modules/location/request/request_add_location.dart';
// import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service.dart';

// import 'add_location_service_contract.dart';

// class AddLocationService implements AddLocationServiceContract {
//   final ApiService _service = ApiService();
//   final AuthService _authService;

//   AddLocationService(this._authService);

//   @override
//   Future<bool> addLocationService({
//     required RequestAddLocation request,
//   }) async {
//     final token = await _authService.getAccessToken();
//     final response = await _service.dio.post(
//       ApiConstants.addLocation,
//       data: request.toFormData(),
//       options: Options(
//         headers: {
//           ApiConstants.kAuthorization: token,
//         },
//       ),
//     );

//     if (response.statusCode == 200) {
//       return true;
//     }

//     return false;
//   }
// }
