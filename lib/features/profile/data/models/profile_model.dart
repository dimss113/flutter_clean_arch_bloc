// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arch_v2/features/profile/domain/entities/profile.dart';
import 'package:equatable/equatable.dart';

class ProfileModel extends Profile {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String avatar;

  
  const ProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
  }): super(id: id, fullName: firstName + " " + lastName, email: email, profileImageUrl: avatar);
  
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'avatar': avatar,
    };
  }

  static List<ProfileModel> fromJsonList(List list) {
    if (list.isEmpty) return [];
    return list.map((item) => ProfileModel.fromJson(item)).toList();
  }
}
