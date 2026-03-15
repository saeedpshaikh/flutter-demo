import '../../domain/entities/policy_entity.dart';

class PolicyModel extends PolicyEntity {
  const PolicyModel({
    required super.id,
    required super.name,
    required super.policyNo,
    required super.status,
    required super.premium,
    required super.nextDue,
  });

  factory PolicyModel.fromJson(Map<String, dynamic> json) {
    return PolicyModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      policyNo: json['policyNo'] ?? '',
      status: json['status'] ?? '',
      premium: (json['premium'] as num?)?.toDouble() ?? 0.0,
      nextDue: json['nextDue'] ?? '',
    );
  }
}