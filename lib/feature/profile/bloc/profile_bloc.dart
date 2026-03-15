import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<LoadProfileData>(_onLoadProfileData);
    on<LogoutTapped>(_onLogoutTapped);
  }

  void _onLoadProfileData(
      LoadProfileData event,
      Emitter<ProfileState> emit,
      ) {
    emit(
      state.copyWith(
        name: 'Saeed Shaikh',
        email: 'saeed@example.com',
        phone: '+1 202 507 6000',
        addressLine1: '123 Main Street',
        addressLine2: 'New York, NY 10001',
        isLoading: false,
      ),
    );
  }

  void _onLogoutTapped(
      LogoutTapped event,
      Emitter<ProfileState> emit,
      ) {
    emit(state.copyWith(logoutSuccess: true));
  }
}