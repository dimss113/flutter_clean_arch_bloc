// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final int? id;
  final String? fullName;
  final String? email;
  final String? profileImageUrl;

  
  const Profile({
    this.id,
    this.fullName,
    this.email,
    this.profileImageUrl,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [id, fullName, email, profileImageUrl];
}
