import 'dart:convert';

class GetLocationNearUserRequest {
  final double latitude;
  final double longitude;

  GetLocationNearUserRequest({
    required this.latitude,
    required this.longitude,
  });

  String toJson() {
    return json.encode(
      Map.from(
        {
          'latidude': latitude,
          'longitude': longitude,
        },
      ),
    );
  }
}
