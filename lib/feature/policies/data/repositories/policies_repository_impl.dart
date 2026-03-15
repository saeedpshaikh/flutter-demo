import '../../domain/entities/policy_entity.dart';
import '../../domain/repositories/policies_repository.dart';
import '../datasource/policies_remote_data_source.dart';

class PoliciesRepositoryImpl implements PoliciesRepository {
  final PoliciesRemoteDataSource remoteDataSource;

  PoliciesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<PolicyEntity>> fetchPolicies() async {
    return await remoteDataSource.fetchPolicies();
  }
}