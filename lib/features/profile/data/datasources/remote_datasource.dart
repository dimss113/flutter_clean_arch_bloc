import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:clean_arch_v2/features/profile/data/models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<List<ProfileModel>> getAllUsers(
      int page); // kemungkinan ada error disini: jika gagal ?
  Future<ProfileModel> getUserById(int id);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  @override
  Future<List<ProfileModel>> getAllUsers(int page) async {
    // https://reqres.in/api/users?page=2
    Uri url = Uri.parse('https://reqres.in/api/users?page=$page');
    var response = await http.get(url);

    Map<String, dynamic> dataBody = jsonDecode(response.body);
    List<dynamic> data = dataBody['data'];
    return ProfileModel.fromJsonList(data);
  }

  @override
  Future<ProfileModel> getUserById(int id) async {
    // https://reqres.in/api/users/2
    Uri url = Uri.parse('https://reqres.in/api/users/$id');
    var response = await http.get(url);

    if (response.statusCode == 404) {
      throw Exception('User not found');
    } else if (response.statusCode != 200) {
      throw Exception('Failed to load user');
    }

    Map<String, dynamic> dataBody = jsonDecode(response.body);
    Map<String, dynamic> data = dataBody['data'];
    return ProfileModel.fromJson(data);
  }
}
