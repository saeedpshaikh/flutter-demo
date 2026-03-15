import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/util/api_constants.dart';
import '../model/policy_model.dart';

abstract class PoliciesRemoteDataSource {
  Future<List<PolicyModel>> fetchPolicies();
}

class PoliciesRemoteDataSourceImpl implements PoliciesRemoteDataSource {
  final http.Client client;

  PoliciesRemoteDataSourceImpl({required this.client});


  @override
  Future<List<PolicyModel>> fetchPolicies() async {
    final response = await client.get(Uri.parse(ApiConstants.baseUrl+ApiConstants.fetchPolicies));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);

      return jsonList
          .map((item) => PolicyModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to fetch policies');
    }
  }
}