
import 'package:clean_arch_v2/core/error/failure.dart';
import 'package:clean_arch_v2/features/profile/domain/entities/profile.dart';
import 'package:clean_arch_v2/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class GetUser {
  final ProfileRepository _profileRepository;

  const GetUser(this._profileRepository);

  Future<Either<Failure, Profile>> call(int id) async {
    return await _profileRepository.getUserById(id);
  }
}