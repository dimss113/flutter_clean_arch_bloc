import 'package:clean_arch_v2/core/error/failure.dart';
import 'package:clean_arch_v2/features/profile/data/datasources/local_datasource.dart';
import 'package:clean_arch_v2/features/profile/data/datasources/remote_datasource.dart';
import 'package:clean_arch_v2/features/profile/data/models/profile_model.dart';
import 'package:clean_arch_v2/features/profile/domain/entities/profile.dart';
import 'package:clean_arch_v2/features/profile/domain/repositories/profile_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;

  ProfileRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});
  @override
  Future<Either<Failure, List<Profile>>> getAllUsers(int page) async {
    try {
      // Check internet connection
      // final List<ConnectivityResult> connectivityResult =
      //     await Connectivity().checkConnectivity();
      print("BEFORE GET DATA FROM REMOTE");
      // if (connectivityResult == ConnectivityResult.none) {
      //   // no internet
      //   // get data from local
      //   List<ProfileModel> profileModel =
      //       await localDataSource.getAllUsers(page);
      //   return Right(profileModel);
      // }

      // get data from remote
      List<ProfileModel> profileModel =
          await remoteDataSource.getAllUsers(page);
      // save data to local
      // localDataSource.saveAllUsers(profileModel);
      return Right(profileModel);
    } catch (e) {
      print("ERROR FROM CATCH");
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Profile>> getUserById(int id) async {
    try {
      // Check internet connection
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        // no internet
        // get data from local
        ProfileModel profileModel = await localDataSource.getUserById(id);
        return Right(profileModel);
      }

      // get data from remote
      ProfileModel profileModel = await remoteDataSource.getUserById(id);
      // save data to local
      localDataSource.saveUserById(profileModel);
      return Right(profileModel);
    } catch (e) {
      return Left(Failure());
    }
  }
}
