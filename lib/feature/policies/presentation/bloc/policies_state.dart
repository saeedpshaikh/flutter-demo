import 'package:equatable/equatable.dart';

import '../../domain/entities/policy_entity.dart';

class PoliciesState extends Equatable {
  final bool isLoading;
  final List<PolicyEntity> policies;
  final String? errorMessage;

  const PoliciesState({
    this.isLoading = false,
    this.policies = const [],
    this.errorMessage,
  });

  PoliciesState copyWith({
    bool? isLoading,
    List<PolicyEntity>? policies,
    String? errorMessage,
    bool clearError = false,
  }) {
    return PoliciesState(
      isLoading: isLoading ?? this.isLoading,
      policies: policies ?? this.policies,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    policies,
    errorMessage,
  ];
}