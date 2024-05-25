// Usecase get all users
import 'package:clean_arch_v2/core/error/failure.dart';
import 'package:clean_arch_v2/features/profile/domain/entities/profile.dart';
import 'package:clean_arch_v2/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllUsers {
  final ProfileRepository _profileRepository;

  const GetAllUsers(this._profileRepository);

  Future<Either<Failure, List<Profile>>> call(int page) async {
    return await _profileRepository.getAllUsers(page);
  }
}