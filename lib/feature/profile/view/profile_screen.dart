import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(LoadProfileData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.logoutSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logout clicked')),
          );

          // later navigate to login screen here
          // Navigator.pushReplacement(...)
        }
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xffF5F7FB),
            body: Column(
                children: [
                  _buildTopBar(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 8),
                          const Center(
                            child: Text(
                              "My Profile",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff0E2341),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          _buildUserCard(state),
                          const SizedBox(height: 16),

                          _buildAddressCard(state),
                          const SizedBox(height: 16),

                          _buildOptionsCard(),
                          const SizedBox(height: 24),

                          _buildLogoutButton(context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

          );
        },
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      height: 78,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: const BoxDecoration(
        color: Color(0xff173F6B),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(2),
          bottomRight: Radius.circular(2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 22),
          _LogoBox(),
          Icon(Icons.notifications_none, color: Colors.white, size: 32),
        ],
      ),
    );
  }

  Widget _buildUserCard(ProfileState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 38,
            backgroundImage: AssetImage('assets/images/profile.png'),
            backgroundColor: Colors.grey,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff0E2341),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  state.email,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xff394867),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  state.phone,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xff0E2341),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(ProfileState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: _boxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.addressLine1,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff0E2341),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  state.addressLine2,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xff5B6475),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, size: 30, color: Color(0xff7C8395)),
        ],
      ),
    );
  }

  Widget _buildOptionsCard() {
    return Container(
      decoration: _boxDecoration(),
      child: Column(
        children: const [
          _ProfileOptionTile(title: 'Edit Profile'),
          Divider(height: 1),
          _ProfileOptionTile(title: 'Update Contact Info'),
          Divider(height: 1),
          _ProfileOptionTile(title: 'Change Password'),
          Divider(height: 1),
          _ProfileOptionTile(title: 'Notification Settings'),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<ProfileBloc>().add(LogoutTapped());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        alignment: Alignment.center,
        decoration: _boxDecoration(),
        child: const Text(
          'Logout',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xff0E2341),
          ),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}

class _ProfileOptionTile extends StatelessWidget {
  final String title;

  const _ProfileOptionTile({required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          color: Color(0xff0E2341),
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Color(0xff7C8395),
        size: 28,
      ),
      onTap: () {},
    );
  }
}

class _LogoBox extends StatelessWidget {
  const _LogoBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: 72,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xff1F5DAA),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Text(
        "NYL\nLIFE",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          height: 0.9,
        ),
      ),
    );
  }
}