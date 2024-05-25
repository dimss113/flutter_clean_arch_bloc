import 'package:dartz/dartz.dart';
import 'package:clean_arch_v2/core/error/failure.dart';
import 'package:clean_arch_v2/features/profile/domain/entities/profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, List<Profile>>> getAllUsers(int page); // kemungkinan ada error disini: jika gagal ?
  Future<Either<Failure, Profile>> getUserById(int id);
}