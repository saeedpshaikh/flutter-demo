import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:nyl_demo/feature/home/view/home_screen.dart';
import 'package:nyl_demo/feature/profile/view/profile_screen.dart';

import '../../claim/view/claim_screen.dart';
import '../../home/presentation/bloc/home_bloc.dart';
import '../../home/presentation/bloc/home_event.dart';
import '../../policies/data/datasource/policies_remote_data_source.dart';
import '../../policies/data/repositories/policies_repository_impl.dart';
import '../../policies/domain/usecase/get_policies_usecase.dart';
import '../../policies/presentation/bloc/policies_bloc.dart';
import '../../policies/presentation/bloc/policies_event.dart';
import '../../policies/presentation/view/policies_screen.dart';
import '../../profile/bloc/profile_bloc.dart';
import '../bloc/tab_bloc.dart';
import '../bloc/tab_event.dart';
import '../bloc/tab_state.dart';


class MainTabView extends StatelessWidget {
  const MainTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      BlocProvider(
        create: (_) => HomeBloc()..add(LoadHomeData()),
        child: const HomeScreen(),
      ),
      //const PoliciesScreen(),

      BlocProvider(
        create: (_) => PoliciesBloc(
            getPoliciesUseCase: GetPoliciesUseCase(
              PoliciesRepositoryImpl(
                remoteDataSource:
                PoliciesRemoteDataSourceImpl(client: http.Client()),
              ),
            ))..add(FetchPoliciesEvent()),
        child: const PoliciesScreen(),
      ),
      const ClaimScreen(),
     // const ProfileScreen(),
      BlocProvider(
        create: (_) => ProfileBloc(),
        child: const ProfileScreen(),
      ),
    ];

    return BlocBuilder<TabBloc, TabState>(
      builder: (context, state) {
        return Scaffold(
          body: pages[state.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.selectedIndex,
            onTap: (index) {
              context.read<TabBloc>().add(TabChanged(index));
            },
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.policy_outlined),
                label: 'Policies',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment_outlined),
                label: 'Claims',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}


