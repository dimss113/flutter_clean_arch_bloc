import 'package:clean_arch_v2/dependency_injection.dart';
import 'package:clean_arch_v2/features/profile/domain/usecases/get_all_users.dart';
import 'package:clean_arch_v2/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:clean_arch_v2/features/profile/presentation/bloc/profile_event.dart';
import 'package:clean_arch_v2/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  print("Dependencies initialized");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => sl()..add(const GetProfiles(1)),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            return ListView.builder(
              itemCount: state.profiles!.length,
              itemBuilder: (context, index) {
                final profile = state.profiles![index];
                return ListTile(
                  leading: Image.network(profile.profileImageUrl!),
                  title: Text('${profile.fullName}'),
                  subtitle: Text(profile.email!),
                );
              },
            );
          } else if (state is ProfileError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Press the button to load users.'));
          }
        },
      ),
    );
  }
}
