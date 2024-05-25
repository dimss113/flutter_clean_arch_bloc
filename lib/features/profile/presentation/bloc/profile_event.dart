
import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfiles extends ProfileEvent {
  final int page;

  const GetProfiles(this.page);

  @override
  List<Object> get props => [page];
}
