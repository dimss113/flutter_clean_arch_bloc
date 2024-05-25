import 'package:clean_arch_v2/features/profile/data/datasources/local_datasource.dart';
import 'package:clean_arch_v2/features/profile/data/datasources/remote_datasource.dart';
import 'package:clean_arch_v2/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:clean_arch_v2/features/profile/domain/repositories/profile_repository.dart';
import 'package:clean_arch_v2/features/profile/domain/usecases/get_all_users.dart';
import 'package:clean_arch_v2/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

abstract class GetAllUserDependencies {
  Future<GetAllUsers> getAllUserDependencies();
}

class GetAllUserDependenciesImpl implements GetAllUserDependencies {
  @override
  Future<GetAllUsers> getAllUserDependencies() async {
    final HiveInterface hive = Hive;

    final ProfileRemoteDataSource profileRemoteDataSource = ProfileRemoteDataSourceImpl();
    final ProfileLocalDataSource profileLocalDataSource = ProfileLocalDataSourceImpl(hive);

    final ProfileRepository profileRepository = ProfileRepositoryImpl(remoteDataSource: profileRemoteDataSource, localDataSource: profileLocalDataSource);

    final GetAllUsers getAllUsers = GetAllUsers(profileRepository);

    return getAllUsers;
  }
}

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<HiveInterface>(Hive);

  sl.registerSingleton<ProfileRemoteDataSource>(
    ProfileRemoteDataSourceImpl()
  );

  sl.registerSingleton<ProfileLocalDataSource>(
    ProfileLocalDataSourceImpl(sl())
  );

  sl.registerSingleton<ProfileRepository>(
    ProfileRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl()
    )
  );

  sl.registerSingleton<GetAllUsers>(
    GetAllUsers(sl())
  );

  sl.registerFactory<ProfileBloc>(
    () => ProfileBloc(sl())
  );
}