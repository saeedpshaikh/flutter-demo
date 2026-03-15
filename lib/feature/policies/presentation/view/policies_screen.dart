import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../bloc/policies_bloc.dart';
import '../bloc/policies_event.dart';
import '../bloc/policies_state.dart';

class PoliciesScreen extends StatefulWidget {
  const PoliciesScreen({super.key});

  @override
  State<PoliciesScreen> createState() => _PoliciesPageState();
}

class _PoliciesPageState extends State<PoliciesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PoliciesBloc>().add(FetchPoliciesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xff173F6B),
        title: const Text(
          'My Policies',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<PoliciesBloc, PoliciesState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.errorMessage != null) {
            return Center(
              child: Text(
                state.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state.policies.isEmpty) {
            return const Center(
              child: Text('No policies found'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.policies.length,
            itemBuilder: (context, index) {
              final policy = state.policies[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      policy.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Policy No. ${policy.policyNo}'),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Text('Status: '),
                        Text(
                          policy.status,
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text('Premium: \$${policy.premium} / month'),
                    const SizedBox(height: 6),
                    Text('Next Due: ${policy.nextDue}'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}