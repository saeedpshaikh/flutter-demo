import '../entities/policy_entity.dart';

abstract class PoliciesRepository {
  Future<List<PolicyEntity>> fetchPolicies();
}