import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String addressLine1;
  final String addressLine2;
  final bool isLoading;
  final bool logoutSuccess;

  const ProfileState({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.addressLine1 = '',
    this.addressLine2 = '',
    this.isLoading = false,
    this.logoutSuccess = false,
  });

  ProfileState copyWith({
    String? name,
    String? email,
    String? phone,
    String? addressLine1,
    String? addressLine2,
    bool? isLoading,
    bool? logoutSuccess,
  }) {
    return ProfileState(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      isLoading: isLoading ?? this.isLoading,
      logoutSuccess: logoutSuccess ?? this.logoutSuccess,
    );
  }

  @override
  List<Object?> get props => [
    name,
    email,
    phone,
    addressLine1,
    addressLine2,
    isLoading,
    logoutSuccess,
  ];
}