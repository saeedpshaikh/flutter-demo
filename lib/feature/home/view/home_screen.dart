import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/bloc/home_bloc.dart';
import '../presentation/bloc/home_state.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xffF5F7FB),

          appBar: AppBar(
            backgroundColor: const Color(0xff173F6B),
            title: const Text("NYL LIFE",style: TextStyle(
              color: Colors.white,
            ),),
            centerTitle: true,
            leading: const Icon(Icons.menu),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(Icons.notifications),
              )
            ],
          ),

          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  "Hello, ${state.userName}",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 16),

                // Policy Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xff173F6B),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        state.policyName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Status: ${state.policyStatus}",
                        style: const TextStyle(color: Colors.white),
                      ),

                      Text(
                        "Next Due ${state.nextDueDate}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Action Buttons
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 3,
                  children: [

                    _buildButton("My Policies"),
                    _buildButton("Make Payment"),
                    _buildButton("Start Claim"),
                    _buildButton("Profile"),

                  ],
                ),

                const SizedBox(height: 20),

                // Premium Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        "Next Premium Due: \$${state.premiumAmount}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        "Due on ${state.nextDueDate}",
                      ),

                    ],
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Need Help? Contact Support"),
                      Icon(Icons.arrow_forward_ios, size: 16)
                    ],
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildButton(String title) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff1F5DAA),
      ),
      child:  Text(title,style: TextStyle(
    color: Colors.white,)
    ),
    );
  }
}