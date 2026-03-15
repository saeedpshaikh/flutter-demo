import '../entities/policy_entity.dart';
import '../repositories/policies_repository.dart';

class GetPoliciesUseCase {
  final PoliciesRepository repository;

  GetPoliciesUseCase(this.repository);

  Future<List<PolicyEntity>> call() async {
    return await repository.fetchPolicies();
  }
}