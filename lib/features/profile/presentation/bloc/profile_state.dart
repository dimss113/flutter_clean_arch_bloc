import 'package:clean_arch_v2/features/profile/domain/entities/profile.dart';
import 'package:equatable/equatable.dart';


abstract class ProfileState extends Equatable {
  final List<Profile> ? profiles;
  final String ? message;

  const ProfileState({this.profiles, this.message});  

  @override
  List<Object> get props => [profiles!];
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  const ProfileLoaded(List<Profile> profiles) : super(profiles: profiles);
}

class ProfileError extends ProfileState {
  @override
  final String message;

  const ProfileError(this.message) : super(message: message);

  @override
  List<Object> get props => [message];
}