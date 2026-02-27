import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_26/model/profile_model.dart';
import '../core/api_end_points.dart';

/// This is the class responsible for talk with the backend that hey this app need data and call the backed to get data
/// Initially i use the try-case block i know it can be better error handling in future
class ProfileService {
  Future<ProfileModel?> fetchProfileDetails(int profileId) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${ApiEndPoints.BASE_URL}${ApiEndPoints.getProfile}/$profileId',
        ),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final dynamic data = json.decode(response.body);

        final ProfileModel profileDetails = ProfileModel.fromJson(data);

        return profileDetails;

      } else {
        final error = jsonDecode(response.body);
        print(response.statusCode);
        return error;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
