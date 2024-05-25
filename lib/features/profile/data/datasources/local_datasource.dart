import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:clean_arch_v2/features/profile/data/models/profile_model.dart';

abstract class ProfileLocalDataSource {
  Future<List<ProfileModel>> getAllUsers(
      int page); // kemungkinan ada error disini: jika gagal ?
  Future<ProfileModel> getUserById(int id);
  void saveAllUsers(List<ProfileModel> profileModel);
  void saveUserById(ProfileModel profileModel);
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final HiveInterface hive;

  ProfileLocalDataSourceImpl(this.hive);
  @override
  Future<List<ProfileModel>> getAllUsers(int page) async {
    var box = hive.box('profile_box');
    return box.get("getAllUsers");
  }

  @override
  Future<ProfileModel> getUserById(int id) async {
    var box = hive.box('profile_box');
    return box.get("getUserById");
  }

  @override
  void saveAllUsers(List<ProfileModel> profileModel) {
    var box = hive.box('profile_box');
    box.put("getAllUsers", profileModel);
  }

  @override
  void saveUserById(ProfileModel profileModel) {
    var box = hive.box('profile_box');
    box.put("getUserById", profileModel);
  }
}
