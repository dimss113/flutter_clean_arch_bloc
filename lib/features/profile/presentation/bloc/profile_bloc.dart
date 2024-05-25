import 'package:bloc/bloc.dart';
import 'package:clean_arch_v2/features/profile/domain/usecases/get_all_users.dart';
import 'package:clean_arch_v2/features/profile/presentation/bloc/profile_event.dart';
import 'package:clean_arch_v2/features/profile/presentation/bloc/profile_state.dart';



class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetAllUsers getAllUsers;


  ProfileBloc(this.getAllUsers) : super(const ProfileLoading()) {
    on <GetProfiles> (onGetProfiles);
  }

  void onGetProfiles(GetProfiles event, Emitter<ProfileState> emit) async {
    emit(const ProfileLoading());
    final result = await getAllUsers(event.page);
    result.fold(
      (failure) => emit(ProfileError(failure.message!)),
      (profiles) => emit(ProfileLoaded(profiles)),
    );
  }
  

  // ProfileBloc() : super(ProfileInitial()) {
  //   on<ProfileEvent>((event, emit) {
  //     // TODO: implement event handler
  //   });
  // }
}
