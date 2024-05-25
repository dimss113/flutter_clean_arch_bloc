import 'package:clean_arch_v2/features/profile/data/datasources/local_datasource.dart';
import 'package:clean_arch_v2/features/profile/data/datasources/remote_datasource.dart';
import 'package:clean_arch_v2/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:clean_arch_v2/features/profile/domain/repositories/profile_repository.dart';
import 'package:clean_arch_v2/features/profile/domain/usecases/get_all_users.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

void main() async {
  final HiveInterface hive = Hive;

  final ProfileRemoteDataSource profileRemoteDataSource = ProfileRemoteDataSourceImpl();
  final ProfileLocalDataSource profileLocalDataSource = ProfileLocalDataSourceImpl(hive);

  final ProfileRepository profileRepository = ProfileRepositoryImpl(remoteDataSource: profileRemoteDataSource, localDataSource: profileLocalDataSource);

  final GetAllUsers getAllUsers = GetAllUsers(profileRepository);
  var response = await getAllUsers.call(1);

  // var response = await getAllUsers(1);

  print(response);
}